function fplist_out = check_paths(fplist, ob, params)

okind = [];
cnt = 1;
for i = 1:length(fplist)
    ok = 0;
    if any(fplist(i).s_d > params.MAX_SPEED)
        ok = 1;
    elseif any(fplist(i).s_dd > params.MAX_ACCEL)
        ok = 1;
    elseif any(fplist(i).c > params.MAX_CURVATURE)
        ok = 1;
    elseif ~check_collision(fplist(i),ob,params)
        ok = 1;
    end
    if ok == 0
        okind(cnt) = i; %#ok<AGROW>
        cnt = cnt+1;
    end
end

fplist_out = [];
cnt = 0;
for idx = okind
    cnt = cnt+1;
    fplist_out = copyfields(fplist(idx),cnt,fplist_out); %#ok<AGROW>
end


end

function fp = copyfields(fp_in,cnt,fp) %#ok<INUSL>

fnames = fieldnames(fp_in);

for j = 1:length(fnames)
    eval(['fp(cnt).',fnames{j},'= fp_in.',fnames{j},';']);
end

end