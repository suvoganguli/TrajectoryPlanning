classdef Frenet_path
    
    properties
        t = [];
        d = [];
        d_d = [];
        d_dd = [];
        d_ddd = [];
        s = [];
        s_d = [];
        s_dd = [];
        s_ddd = [];
        cd = 0.0;
        cv = 0.0;
        cf = 0.0;
        
        x = [];
        y = [];
        yaw = [];
        ds = [];
        c = [];
        
        params;
    end
    
    methods
        
        function obj = Frenet_path(params)
            obj.params = params;
        end
        

    end % end methods
    
end % end classdef