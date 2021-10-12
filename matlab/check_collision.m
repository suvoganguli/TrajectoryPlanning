function out = check_collision(fp, ob, params)

out = true;
collision = 0;

for j=1:(size(ob,1))
    for i = 1:length(fp.x)
        ix = fp.x(i);
        iy = fp.y(i);        
        d = ((ix - ob(j,1))^2 + (iy - ob(j,2))^2);
        if d <= params.ROBOT_RADIUS^2
            collision = 1;
        end
    end
end

if collision == 1
    out = false;    
end