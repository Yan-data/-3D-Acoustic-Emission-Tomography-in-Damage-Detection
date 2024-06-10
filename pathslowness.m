% %read velocity and get slowness vector  write s
input1;
nsts=6;
ne=80;
%read station coordinates
sta='sta';
input2(sta);

nobs=nsts*ne;
 l(nobs,nodes)=0;
%read event coordinates and compute path vector
for i=1:ne
    %read event coordinates and travel time
    input4;
    for j=1:nsts
        P1=[xe,ye,ze];
        P2=[xr,yr,zr];
        [X,Y,Z]= bresenham_line3d(P1, P2);
       ud=unit(P1,P2);
       nobs=i*j;
        A=P2-P1; %direction vector
        
        %length between
       for h=2:length(X)-1
           [ip,jp,kp]=intmap(X(h),Y(h),Z(h));
           in=ip+nx2*(jp-1)+nxy2*(kp-1);
             dx=X(k)-xe;
             dy=Y(k)-ye;
             dz=Z(k)-ze;
             ds=sqrt(dx*dx+dy*dy+dz*dz);
             ud=ds/(h-1);
           l(nobs,h)=ud;
       end
    end
end

   input1
   nx=160;
   ny=150;
   nz=400;
for i=1:nx
        xn(i)=i-1;
 end
for i=1:ny
        yn(i)=i-1;
end
for i=1:nz
        zn(i)=i-1;
end

% %read velocity and get slowness vector  write s input1;
kv=1;
         for k=1:nz
            k2=k + (kv-1)*nz;
            for j=1:ny
               for i=1:nx
               vel(i,j,k2)=v;
               s(i,j,k2)=1/v;
               fwrite(16) (s(i,j,k2),i=1:nx)
               end
            end
         end
         
  nodes=nx*ny*nz;
      nxy=nx*ny;
   % read station
   
      
    fid = fopen('stns', 'r');  
for j=1:nsts
   stn(j)=fread(fid,'uchar');
   x=fread(fid);
   y=fread(fid);
   z =fread(fid); 
   stc(1,j)=x;
   stc(2,j)=y;
   stc(3,j)=z;
   j=j+1;
end
 fclose(fid);
           
     
     vel3(isp,x,y,z,v)


      intmap(x,y,z,ip,jp,kp)
      if(ip.eq.0.or.jp.eq.0.or.kp.eq.0) then
        write(6,*)'Error in intmap - position off the map: ',x,y,z
        stop
      endif

      ip1=ip+1;
      jp1=jp+1;
      kp1=kp+1;
%check for outer boundary (to larger values) hit (needed for bldrtgrd)
% (anyway should only be the case if value is on boundary)
      if (ip1.gt.nx) 
          ip1 = ip -1;
          xf=(x-xn(ip))/(xn(ip)-xn(ip1));
      else 
          xf=(x-xn(ip))/(xn(ip1)-xn(ip));
      end
      if (jp1.gt.ny)
         jp1 = jp -1;
         yf=(y-yn(jp))/(yn(jp)-yn(jp1));
      else 
         yf=(y-yn(jp))/(yn(jp1)-yn(jp));
      end
      if (kp1.gt.nz)
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

  v=wv(1)*vel(ip,jp,kp)+wv(2)*vel(ip1,jp,kp)+wv(3)*vel(ip,jp1,kp)+wv(4)*vel(ip1,jp1,kp)+wv(5)*vel(ip,jp,kp1)+wv(6)*vel(ip1,jp,kp1)+wv(7)*vel(ip,jp1,kp1)+wv(8)*vel(ip1,jp1,kp1);
      return



  
  

 



    
      
      
      
    

     
     


