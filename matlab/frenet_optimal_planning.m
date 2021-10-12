function bestpath = frenet_optimal_planning(params,csp, s0, c_speed, c_d, c_d_d, c_d_dd, ob)

fplist = calc_frenet_paths(params,c_speed, c_d, c_d_d, c_d_dd, s0);
fplist = calc_global_paths(fplist, csp);
fplist = check_paths(fplist, ob, params);

% find minimum cost path
mincost = inf;
bestpath = [];
for k = 1:length(fplist)
    fp = fplist(k);
    if mincost >= fp.cf
        mincost = fp.cf;
        bestpath = fp;        
    end
end

end
