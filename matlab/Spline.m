classdef Spline
    
    properties
        x
        y
        a
        b
        c
        d
        w
        nx
    end
    
    methods
       
        % constructor
        function obj = Spline(x,y)            
            obj.b = [];
            obj.c = [];
            obj.d = [];
            obj.w = [];
            obj.x = x;
            obj.y = y;
            obj.nx = length(x);
            h = diff(x);
            obj.a = y;
            
            A = obj.calcA(h);
            b = obj.calcB(h);
            c = A\b;
            
            obj.c = c;
                                    
            for i = 1:(obj.nx-1)
                obj.d(i) = (obj.c(i+1) - obj.c(i)) / (3.0 * h(i));
                tb(i) = (obj.a(i+1) - obj.a(i))/h(i) - h(i)*(obj.c(i+1) + 2*obj.c(i))/3; %#ok<AGROW>
                obj.b(i) = tb(i);
            end
            
        end
        
        % calc
        function result = calc(obj,t)            
            if t < obj.x(1)
                result = [];
                return
            end
            
            if t > obj.x(end)
                result = [];
                return
            end
            
            i = obj.search_index(t);
            dx = t - obj.x(i);
            
            % Temporary fix
            obj.b(end+1) = obj.b(end);
            obj.d(end+1) = obj.b(end);

            result = obj.a(i) + obj.b(i)*dx +  obj.c(i)*dx^2 + obj.d(i)*dx^3;            
        end
        
        % calcd
        function result = calcd(obj,t)            
            if t < obj.x(1)
                result = [];
                return
            end
            
            if t > obj.x(end)
                result = [];
                return
            end
            
            i = obj.search_index(t);
            dx = t - obj.x(i);
            
            result = obj.b(i) + 2*obj.c(i)*dx + 3*obj.d(i)*dx^2;              
        end
        
        % calcdd
        function result = calcdd(obj,t)
            if t < obj.x(1)
                result = [];
                return
            end
            
            if t > obj.x(end)
                result = [];
                return
            end
            
            i = obj.search_index(t);
            dx = t - obj.x(i);
            
            result = 2*obj.c(i) + 6*obj.d(i)*dx;            
        end
        
        % search_index
        function result = search_index(obj,x)   
            result = [];
            for i = 1:length(obj.x)
                if obj.x(i) > x
                    result = i-1;
                    result = max(result,1);
                    result = min(result,length(obj.x));
                    return
                end                
            end
            if isempty(result)
                result = length(obj.x);
            end
        end
        
        % calcA
        function A = calcA(obj,h)
            A = zeros(obj.nx, obj.nx);
            A(1,1) = 1.0;
            for i = 1:(obj.nx - 1)
                if i ~= (obj.nx - 1)
                    A(i+1,i+1) = 2.0 * (h(i) + h(i+1));
                end
                A(i+1,i) = h(i);
                A(i,i+1) = h(i);
            end
            A(1,2) = 0.0;
            A(obj.nx, obj.nx-1) = 0.0;
            A(obj.nx, obj.nx) = 1.0;
        end
        
        % calcB
        function B = calcB(obj,h)
        B = zeros(obj.nx,1);
        for i = 1:(obj.nx - 2)
            B(i+1) = 3.0 * (obj.a(i+2) - obj.a(i+1)) / ...
                h(i+1) - 3.0 * (obj.a(i+1) - obj.a(i)) / h(i);
        end
        end

    end % end methods
        
end % end classdef