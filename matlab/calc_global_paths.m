% function calc_global_paths(fplist, csp)
function fplist = calc_global_paths(fplist, csp)

cnt = 0;
for k = 1:length(fplist)
    cnt = cnt+1;
    fp = fplist(k);
    
    cnt2 = 0;
    
    for i = 1:length(fp.s)
        cnt2 = cnt2 + 1;
        
        [ix, iy] = csp.calc_position(fp.s(i));
        if isempty(ix)
            break
        end
                
        iyaw = csp.calc_yaw(fp.s(i));
                       
        di = fp.d(i);
        fx = ix + di * cos(iyaw + pi / 2.0);
        fy = iy + di * sin(iyaw + pi / 2.0);
        fp.x(i) = fx;
        fp.y(i) = fy;             
        
    end
        
    % calc yaw and ds
    for i = 1:(length(fp.x)-1)
        dx = fp.x(i + 1) - fp.x(i);
        dy = fp.y(i + 1) - fp.y(i);
        fp.yaw(i) = atan2(dy, dx);
        fp.ds(i) = sqrt(dx^2 + dy^2);
    end
    
    if ~isempty(fp.yaw)
        fp.yaw(end+1) = fp.yaw(end);
        fp.ds(end+1) = fp.ds(end);
    end
    
    % calc curvature
    for i = 1:(length(fp.yaw) - 1)
        fp.c(i) = ((fp.yaw(i + 1) - fp.yaw(i)) / fp.ds(i));
    end
    
    if ~isempty(fp.c)
        fp.c(end+1) = fp.c(end);
    end
       
    fplist(k) = fp;
end

end % end calc_global_paths




