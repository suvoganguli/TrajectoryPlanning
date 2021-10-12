class Frenet_path:

    def __init__(self):
        self.t = []
        self.d = []
        self.d_d = []
        self.d_dd = []
        self.d_ddd = []
        self.s = []
        self.s_d = []
        self.s_dd = []
        self.s_ddd = []
        self.cd = 0.0
        self.cv = 0.0
        self.cf = 0.0

        self.x = []
        self.y = []
        self.yaw = []
        self.ds = []
        self.c = []


fplist = []

for i in range(3):
	fp = Frenet_path()
	fp.s_d = [1,1,1,1]
	fplist.append(fp)
	
print(fplist[0].s_d)
	