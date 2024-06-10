function a=matrix(evt)
global ax by cz Np ne nx ny nz nxy nx1 ny1 nz1
global xn yn zn

global khit hit


nodes=nx*ny*nz;
a=zeros(Np,nodes);


    for j=1:Np
        P1=[ax(ne,j),by(ne,j),cz(ne,j)];
        P2=evt;
        %e2s=sqrt((P1(1)-P2(1))^2+(P1(2)-P2(2))^2+(P1(3)-P2(3))^2);
        %fprintf('real distance from evt to station %f\n',e2s);
        [X,Y,Z]= bresenham_line3d(P1, P2);
        ud=unit(P1,P2);
       
        N=length(X);
        %length between
        %l=0;
       for h=1:N-1
           [ip,jp,kp]=intmap(X(h),Y(h),Z(h));
           
           
           
           
      % copy from vel2
           ip1=ip+1;
      jp1=jp+1;
      kp1=kp+1;
% check for outer boundary (to larger values) hit (needed for bldrtgrd)
% (anyway should only be the case if value is on boundary)
      if (ip1>nx)
          ip1 = ip -1;
          xf=(X(h)-xn(ip))/(xn(ip)-xn(ip1));
      else 
          xf=(X(h)-xn(ip))/(xn(ip1)-xn(ip));
      end
      if (jp1>ny)
         jp1 = jp -1;
         yf=(Y(h)-yn(jp))/(yn(jp)-yn(jp1));
      else 
         yf=(Y(h)-yn(jp))/(yn(jp1)-yn(jp));
      end
      if (kp1>nz) 
         kp1 = kp -1;
         zf=(Z(h)-zn(kp))/(zn(kp)-zn(kp1));
      else 
         zf=(Z(h)-zn(kp))/(zn(kp1)-zn(kp));
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
           %cccccccccccccccccccc
           
           %fprintf('nx%f\n nxy%f\n',nx,nxy);
            %g=ip-1+nx*(jp-1)+nxy*(kp-1);
            %fprintf(' size%d',size(g));
            in(1)=ip+nx*(jp-1)+nxy*(kp-1);
          
            in(2)=in(1)+1;
            in(3)=in(1)+nx;
            in(4)=in(3)+1;
            in(5)=in(1)+nxy;
            in(6)=in(5)+1;
            in(7)=in(5)+nx;
            in(8)=in(7)+1;
            in(9)=ip+nx*(jp-1)+nxy*(kp-1);
            
           a(j,in(9))=ud;
           %l=a(j,in(9))+l;
% Assign zero weight to boundary nodes (these nodes are not 
%  included in the inversion, but are in the velocity array,
%  thus we want to avoid writing to negative or incorrect 
%  elements of the partial derivative matrix)

            if ip==1 
               wv(1)=0.0;
               wv(3)=0.0;
               wv(5)=0.0;
               wv(7)=0.0;
            elseif ip==nx1 

                  wv(2)=0.0;
                  wv(4)=0.0;
                  wv(6)=0.0;
                  wv(8)=0.0;
            end
            
            if jp==1
               wv(1)=0.0;
               wv(2)=0.0;
               wv(5)=0.0;
               wv(6)=0.0;
            elseif jp==ny1 

                  wv(3)=0.0;
                  wv(4)=0.0;
                  wv(7)=0.0;
                  wv(8)=0.0;
            end
            
            if((kp==1)||(kp==(nz1+1))) 
               for izg=1:4
                  wv(izg)=0.0;
               end
            elseif((kp==nz1)||(kp==(2*nz1))) 

                  for izg=5:8
                     wv(izg)=0.0;
                  end
            end
              
 
%  Accumulate model partial derivatives
            for kk=1:2
               kk1=kk-1;
               for jj=1:2
                  jj1=jj-1;
                  for ii=1:2
                     ijk=ii+2*jj1+4*kk1;
% skip boundary nodes
                     if wv(ijk)<0.05 
                         break
                     end
                     ini=in(ijk);
                     %fprintf('%d %d %d %d %d',ijk,in(ijk),ip,jp,kp);
                     hit(in(ijk))=hit(in(ijk))+wv(ijk);
                     %fprintf('ijk %f\n',in(ijk));
                     %no=(ne-1)*Np+j;
                     %inp=ini+(no-1)*nodes;
                     if hit(in(ijk)) ~= 0
                         
                     khit(in(ijk))=khit(in(ijk))+1;
                     end
                  end
               end
            end

       end
%       fprintf('path %f\n',l);
    end
end
 
    
    
    
    
    
    
    
    
    
    
    
    