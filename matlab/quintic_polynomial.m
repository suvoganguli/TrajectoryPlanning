classdef quintic_polynomial
    
    properties
        xs
        vxs
        axs
        xe
        vxe
        axe
        T
        a0
        a1
        a2
        a3
        a4
        a5
    end
    
    methods
        
        function obj = quintic_polynomial(xs, vxs, axs, xe, vxe, axe, T)
            
            % calc coefficient of quintic polynomial
            obj.xs = xs;
            obj.vxs = vxs;
            obj.axs = axs;
            obj.xe = xe;
            obj.vxe = vxe;
            obj.axe = axe;
            obj.T = T;
            
            obj.a0 = xs;
            obj.a1 = vxs;
            obj.a2 = axs / 2.0;
            
            A = [T^3, T^4, T^5;
                 3 * T^2, 4 * T^3, 5 * T^4;
                 6 * T, 12 * T^2, 20 * T^3];
            b = [xe - obj.a0 - obj.a1 * T - obj.a2 * T^2;
                vxe - obj.a1 - 2 * obj.a2 * T;
                axe - 2 * obj.a2];
            x = A\b;
            
            obj.a3 = x(1);
            obj.a4 = x(2);
            obj.a5 = x(3);
            
        end
        
        function xt = calc_point(obj, t)
            xt = obj.a0 + obj.a1 * t + obj.a2 * t^2 + ...
                obj.a3 * t^3 + obj.a4 * t^4 + obj.a5 * t^5;
        end
        
        function  xt = calc_first_derivative(obj, t)
            xt = obj.a1 + 2 * obj.a2 * t + ...
                3 * obj.a3 * t^2 + 4 * obj.a4 * t^3 + 5 * obj.a5 * t^4;
        end
        
        function xt = calc_second_derivative(obj, t)
            xt = 2 * obj.a2 + 6 * obj.a3 * t + 12 * obj.a4 * t^2 + 20 * obj.a5 * t^3;
        end
        
        function xt = calc_third_derivative(obj, t)            
            xt = 6 * obj.a3 + 24 * obj.a4 * t + 60 * obj.a5 * t^2;            
        end
        
    end
end
