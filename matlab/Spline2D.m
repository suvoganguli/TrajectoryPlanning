classdef Spline2D
    
    properties
        s
        sx
        sy
        ds
    end
    
    methods
        
        % constructor
        function obj = Spline2D(x,y)
            [obj.s, obj.ds] = obj.calc_s(x, y);
            obj.sx = Spline(obj.s, x);
            obj.sy = Spline(obj.s, y);
        end
        
        function [s, ds] = calc_s(~,x,y)
            dx = diff(x);
            dy = diff(y);
            for i = 1:length(dx)
                dxi = dx(i);
                dyi = dy(i);
                ds(i) = sqrt(dxi^2 + dyi^2);
            end
            s(1) = 0;
            s = [s, cumsum(ds)];
        end
        
        function [x,y] = calc_position(obj,s)
            x = obj.sx.calc(s);
            y = obj.sy.calc(s);
        end
        
        function k = calc_curvature(obj, s)
            dx = obj.sx.calcd(s);
            ddx = obj.sx.calcdd(s);
            dy = obj.sy.calcd(s);
            ddy = obj.sy.calcdd(s);
            k = (ddy * dx - ddx * dy) / (dx^2 + dy^2);        
        end
        
        function yaw = calc_yaw(obj, s)
            dx = obj.sx.calcd(s);
            dy = obj.sy.calcd(s);
            yaw = atan2(dy, dx);
        end
        
    end
    
end