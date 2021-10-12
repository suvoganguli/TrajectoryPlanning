function [rx, ry, ryaw, rk, csp] = generate_target_course(x,y)
    
    csp = Spline2D(x, y);
    
    s = 0:0.1:csp.s(end);

    rx = [];
    ry = [];
    ryaw = [];
    rk = [];
    
    cnt = 1;
    for i_s = s
        [ix, iy] = csp.calc_position(i_s);
        rx(cnt) = ix; %#ok<*AGROW>
        ry(cnt) = iy;
        ryaw(cnt) = csp.calc_yaw(i_s);
        rk(cnt) = csp.calc_curvature(i_s);
        cnt = cnt+1;
    end
    
end