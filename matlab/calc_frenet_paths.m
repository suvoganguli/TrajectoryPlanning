% function: frenet_paths = calc_frenet_paths(c_speed, c_d, c_d_d, c_d_dd, s0)
function frenet_paths = calc_frenet_paths(params,c_speed, c_d, c_d_d, c_d_dd, s0)

frenet_paths = [];

D_ROAD_W = params.D_ROAD_W;
MAX_ROAD_WIDTH = params.MAX_ROAD_WIDTH;
MINT = params.MINT;
MAXT = params.MAXT;
DT = params.DT;
TARGET_SPEED = params.TARGET_SPEED;
D_T_S = params.D_T_S;
N_S_SAMPLE = params.N_S_SAMPLE;
KJ = params.KJ;
KT = params.KT;
KD = params.KD;
KLAT = params.KLAT;
KLON = params.KLON;

cnt = 1;
cnt3 = 1;

% generate path to each offset goal
for di = (-MAX_ROAD_WIDTH : D_ROAD_W : (MAX_ROAD_WIDTH - D_ROAD_W))
    
    % Lateral motion planning
    for Ti = (MINT : DT : (MAXT - DT))
        
        fp = Frenet_path(params);
        
        lat_qp = quintic_polynomial(c_d, c_d_d, c_d_dd, di, 0.0, 0.0, Ti);
                
        fp.t = 0.0 : params.DT : Ti;
        for k = 1:(length(fp.t))
            fp.d(k) = lat_qp.calc_point(fp.t(k));
            fp.d_d(k) = lat_qp.calc_first_derivative(fp.t(k));
            fp.d_dd(k) = lat_qp.calc_second_derivative(fp.t(k));
            fp.d_ddd(k) = lat_qp.calc_third_derivative(fp.t(k));
        end
       
        cnt2 = 1;
        
        % Longitudinal motion planning (Velocity keeping)
        for tv = (TARGET_SPEED - D_T_S * N_S_SAMPLE : D_T_S : (TARGET_SPEED + D_T_S * N_S_SAMPLE))
            tfp = fp;
            lon_qp = quartic_polynomial(s0, c_speed, 0.0, tv, 0.0, Ti);
            
            for j = 1:(length(fp.t))
                tfp.s(j) = lon_qp.calc_point(fp.t(j));
                tfp.s_d(j) = lon_qp.calc_first_derivative(fp.t(j));
                tfp.s_dd(j) = lon_qp.calc_second_derivative(fp.t(j));
                tfp.s_ddd(j) = lon_qp.calc_third_derivative(fp.t(j));
            end
            
            Jp = sum(tfp.d_ddd.^2);  % square of jerk
            Js = sum(tfp.s_ddd.^2);  % square of jerk
            
            % square of diff from target speed
            ds_ = (TARGET_SPEED - tfp.s_d(end))^2;
            
            tfp.cd = KJ * Jp + KT * Ti + KD * tfp.d(end)^2;
            tfp.cv = KJ * Js + KT * Ti + KD * ds_;
            tfp.cf = KLAT * tfp.cd + KLON * tfp.cv;
            
            frenet_paths = copyfields(frenet_paths,tfp,cnt3);

            cnt2 = cnt2+1;
            cnt3 = cnt3+1;
        end
        cnt = cnt + 1;
    end
end

end % end calc_frenet_paths

function frenet_paths = copyfields(frenet_paths,tfp,cnt) %#ok<INUSD>

fnames = fieldnames(tfp);

for k = 1:length(fnames)
   eval(['frenet_paths(cnt).',fnames{k},'= tfp.',fnames{k},';']); 
end

end