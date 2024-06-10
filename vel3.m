function v=vel3(isp,x,y,z)
global xn yn zn vel nx ny nz

global  err
%fprintf('%f %f %f %f',x,y,z,isp);
[ip,jp,kp]=intmap(x,y,z);

if(ip==0||jp==0||kp==0) 
  fprintf('Error in intmap - position off the map: %f %f %f ',x,y,z);
  err=1;
  return
end

      ip1=ip+1;
      jp1=jp+1;
      kp1=kp+1;
% check for outer boundary (to larger values) hit (needed for bldrtgrd)
% (anyway should only be the case if value is on boundary)
      if (ip1>nx)
          ip1 = ip -1;
          xf=(x-xn(ip))/(xn(ip)-xn(ip1));
      else 
          xf=(x-xn(ip))/(xn(ip1)-xn(ip));
      end
      if (jp1>ny)
         jp1 = jp -1;
         yf=(y-yn(jp))/(yn(jp)-yn(jp1));
      else 
         yf=(y-yn(jp))/(yn(jp1)-yn(jp));
      end
      if (kp1>nz) 
         kp1 = kp -1;
         zf=(z-zn(kp))/(zn(kp)-zn(kp1));
      else 
         zf=(z-zn(kp))/(zn(kp1)-zn(kp));
      end

      xf1=1.0-xf;
      yf1=1.0-yf;
      zf1=1.0-zf;

      wv(1)=xf1*yf1*zf1;
      wv(2)=xf*yf1*zf1;
      wv(3)=xf1*yf*zf1;
      wv(4)=xf*yf*zf1;
      wv(5)=xf1*yf1*zf;
      wv(6)=xf*yf1*zf;
      wv(7)=xf1*yf*zf;
      wv(8)=xf*yf*zf;
%  calculate velocity

%  (or V*Q if iuseq=1)
      
% put the following in an if - then construct.
      if isp==1 
        kp=kp+nz;
        kp1=kp+1;
      elseif kp1>(2*nz)
          kp1 = kp -1;
      end

v=wv(1)*vel(ip,jp,kp)+wv(2)*vel(ip1,jp,kp)+wv(3)*vel(ip,jp1,kp)+wv(4)*vel(ip1,jp1,kp)+wv(5)*vel(ip,jp,kp1)+wv(6)*vel(ip1,jp,kp1)+wv(7)*vel(ip,jp1,kp1)+wv(8)*vel(ip1,jp1,kp1);
     

      end


