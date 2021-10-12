function [rx, ry, ryaw, rk, s] = calc_spline_course(x, y, ds)

if nargin < 3
    ds = 0.1;
end

disp(ds)

sp = Spline2D(x, y);
s = (0:ds:sp.s(end));

rx = [];
ry = [];
ryaw = []; 
rk = [];
for i_s = s
    [ix, iy] = sp.calc_position(i_s);
    rx = [rx ix]; %#ok<*AGROW>
    ry = [ry iy];
    ryaw = [ryaw sp.calc_yaw(i_s)];
    rk = [rk sp.calc_curvature(i_s)];        
end

