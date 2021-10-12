% main.m

%% setup

% parameters
params.MAX_SPEED = 50.0 / 3.6;  % maximum speed [m/s]
params.MAX_ACCEL = 2.0;  % maximum acceleration [m/ss]
params.MAX_CURVATURE = 1.0;  % maximum curvature [1/m]
params.MAX_ROAD_WIDTH = 7.0;  % maximum road width [m]
params.D_ROAD_W = 1.0;  % road width sampling length [m]
params.DT = 0.2;  % time tick [s]
params.MAXT = 5.0;  % max prediction time [m]
params.MINT = 4.0;  % min prediction time [m]
params.TARGET_SPEED = 30.0 / 3.6;  % target speed [m/s]
params.D_T_S = 5.0 / 3.6;  % target speed sampling length [m/s]
params.N_S_SAMPLE = 1;  % sampling number of target speed
params.ROBOT_RADIUS = 2.0;  % robot radius [m]

% cost weights
params.KJ = 0.1;
params.KT = 0.1;
params.KD = 1.0;
params.KLAT = 1.0;
params.KLON = 1.0;

%% function calls

disp('start!');

wx = [0.0, 10.0, 20.5, 35.0, 70.5];
wy = [0.0, -6.0, 5.0, 6.5, 0.0];

ob = [20.0, 10.0
      30.0, 6.0
      30.0, 8.0
      35.0, 8.0
      50.0, 3.0];

[tx, ty, tyaw, tc, csp] = generate_target_course(wx, wy);

% initial state
c_speed = 10.0 / 3.6;  % current speed [m/s]
c_d = 2.0;  % current lateral position [m]
c_d_d = 0.0;  % current lateral speed [m/s]
c_d_dd = 0.0;  % current latral acceleration [m/s]
s0 = 0.0;  % current course position

area = 20.0;  % animation area length [m]

show_animation = 1;

for i = 1:500
    path = frenet_optimal_planning(params,...
       csp, s0, c_speed, c_d, c_d_d, c_d_dd, ob);
   
    s0 = path.s(2);
    c_d = path.d(2);
    c_d_d = path.d_d(2);
    c_d_dd = path.d_dd(2);
    c_speed = path.s_d(2);

    var = sqrt((path.x(1) - tx(end))^2+(path.y(1) - ty(end))^2);
    if var < 1.0
        disp('Goal');
        break
    end
    
    figure(1);
    if show_animation
        clf
        plot(tx, ty)
        hold on
        plot(ob(:,1), ob(:,2), 'xk')
        plot(path.x(1:end), path.y(1:end), '-or')
        plot(path.x(1), path.y(1), 'vc')
        xlim([path.x(1) - area, path.x(1) + area])
        ylim([path.y(1) - area, path.y(1) + area])
        title(['v[km/h]: ', num2str(c_speed * 3.6)])
        grid on
        %pause(0.0001)        
    end
end

