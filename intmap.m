function [ip,jp,kp]=intmap(x,y,z)
global ixloc iyloc izloc xl yl zl bld
      ip=ceil((x+xl)/bld);
      ip=ixloc(ip);
      jp=ceil((yl+y)/bld);
      jp=iyloc(jp);
      kp=ceil((z+zl)/bld);
      kp=izloc(kp);
      
%  If an array element=0, the position is off the map.
      return
 end
