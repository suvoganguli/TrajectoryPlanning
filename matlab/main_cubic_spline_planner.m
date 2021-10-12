% main_cubic_spline_planner

disp("Spline 2D test")

x = [-2.5, 0.0, 2.5, 5.0, 7.5, 3.0, -1.0];
y = [0.7, -6, 5, 6.5, 0.0, 5.0, -2.0];

sp = Spline2D(x, y);
s = 0:0.1:sp.s(end);

rx = [];
ry = [];
ryaw = [];
rk = [];

for i_s = s
    [ix, iy] = sp.calc_position(i_s);
    rx = [rx ix];
    ry = [ry iy];
    ryaw = [ryaw sp.calc_yaw(i_s)];
    rk = [rk sp.calc_curvature(i_s)];
end

figure(1); clf
plot(x,y,'b+');
hold on
plot(rx,ry,'r');
legend('input','spline');
grid on

figure(2); clf
plot(s,ryaw*180/pi,'r');
legend('yaw');
grid on

figure(3); clf
plot(s,rk,'r');
legend('curvature');
grid on
