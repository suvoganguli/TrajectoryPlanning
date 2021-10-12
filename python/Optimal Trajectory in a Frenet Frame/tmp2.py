
class Obj:
    def __init__(self):
		vvec = []

def fun():
    objlist = []
    
    obj = Obj()
    obj.vvec = [1,1,1]
    objlist.append(obj)

    obj = Obj()
    obj.vvec = [3,3,3]
    objlist.append(obj)

    obj = Obj()
    obj.vvec = [0.5,0.5,0.5]
    objlist.append(obj)    
    
    okind = []
    for i in range(3):
        print(i)
        if objlist[i].vvec[0] > 1.5:
            continue
            
        okind.append(i)
        
    print(okind)    
    return [objlist[i] for i in okind]
    
    
def main():

    olist = fun()
    print(len(olist))
    print(olist[0])
    print(olist[2])
    
    
if __name__ == '__main__':
    main()