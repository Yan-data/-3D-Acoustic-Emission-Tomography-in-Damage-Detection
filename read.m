
[f16,msg]=fopen('output.txt','w');
if f16 < 0 
   disp(msg);
   fprintf('output');
end
%control parameter

neq=26;
iuseq=0;
it=30;
global xn nx ny nz nx1 ny1 nz1
global yn
global zn
global vel
global ax
global by
global cz
global Np
global time
global ixloc
global iyloc
global izloc
 
global ne xl yl zl bld nx2 nxy nxy2 err
global s
%input event and station
%- - -- - - - - - - - - - - - - - - - - - - - - - - - - -               
%  this routine reads in the station list, sets up the
%  coordinate system
 fprintf(f16,'  station list');
 fprintf(f16,'      station     x      y      z   \n')
%read sensor coordinates
[f2,msg]=fopen('stns.txt','r');   
 if f2 < 0 
   disp(msg);
   fprintf('stns.txt');
 end
 
nst=1;
while ~feof(f2)
  a=fscanf(f2,'%f',1);
  b=fscanf(f2,'%f',1);
  c=fscanf(f2,'%f',1);
  if ~isempty(a)
  fprintf(f16,'%3d %7.2f %7.2f %7.2f\n',nst,a,b,c);
  xst(nst)=a;
  yst(nst)=b;
  zst(nst)=c;
  nst=nst+1;
  end
 end
fclose(f2);
%end of station coordinates reading


%read velocity input 

[f3,msg]=fopen('mod.txt','r'); 
if f3 < 0 
   disp(msg);
   fprintf('MOD file');
end
bld=fscanf(f3,'%f',1); 
nx=fscanf(f3,'%f',1);
ny=fscanf(f3,'%f',1);
nz=fscanf(f3,'%f',1);
fprintf(f16,['velocity grid size: bld=%3.2f  nx=%4.1f  ny=%f'...
    'nz=%f\n'],bld,nx,ny,nz);
fprintf(['velocity grid size: bld=%3.2f  nx=%4.1f  ny=%f'...
    'nz=%f\n'],bld,nx,ny,nz);
for i=1:nx
    xn(i)=fscanf(f3,'%f',1);
    fprintf(f16,'%7.1f',xn(i));
    fprintf('%7.1f',xn(i));
end
fprintf(f16,'\n');
fprintf('\n');
for i=1:ny
    yn(i)=fscanf(f3,'%f',1);
    fprintf(f16,'%7.1f',yn(i));
    fprintf('%7.1f',yn(i));
end
fprintf(f16,'\n');
fprintf('\n');

for i=1:nz
    zn(i)=fscanf(f3,'%f',1);
    fprintf(f16,'%7.1f',zn(i));
    fprintf('%7.1f',zn(i));
end
fprintf(f16,'\n');
fprintf('\n');


   kv=1;
         for k=1:nz
            k2=k + (kv-1)*nz;
         fprintf(f16,'layer %d  velocity     z =%f\n',k,zn(k));
         fprintf('layer %d  velocity     z =%f\n',k,zn(k));
           for  j=1:ny
              for i=1:nx
               vel(i,j,k2)=fscanf(f3,'%f',1);                           
       
               fprintf(f16,'%6.3f',vel(i,j,k2));
               fprintf('%6.3f',vel(i,j,k2));
              end
              fprintf(f16,'\n');
              fprintf('\n');
            end
         end
   
% CHANGE FOR Q INVERSION
if iuseq==1 
        for k=1:nz
          fprintf(f16,' layer   %d  Q    z =%f\n',k,zn(k));
            fprintf(' layer   %d  Q    z =%f\n',k,zn(k));
           for j=1:ny
               for i=1:nx
                qval(i,j,k)=fscanf(f3,'%f',1); 
                fprintf(f16,'%7.1f',qval(i,j,k));
                fprintf('%7.1f',qval(i,j,k));
               end
                fprintf(f16,'\n');
                fprintf('\n');
           end
        end
      
%  compute 1/tstar
        kv=2;
       for  k=1:nz
            ks=k+nz;
            fprintf(f16,' layer   %d  Q * Vp   z =%f\n', k,zn(k));
          fprintf(' layer   %d  Q * Vp   z =%f\n', k,zn(k));
            for  j=1:ny
               for  i=1:nx
                  vel(i,j,ks)=vel(i,j,k)*qval(i,j,k);
                fprintf(f16,'%7.1f',vel(i,j,ks));
                fprintf('%7.1f',vel(i,j,ks));
               end
               fprintf(f16,'\n');
               fprintf('\n');
            end
       end
 end
 %  compute total number of gridpoints (nodes)
      nodes=nx*ny*nz;
      nxy=nx*ny;
      nx2=nx-2;             
      nxy2=nx2*(ny-2);      % number non-edge nodes in layer
      nz2=nz-2;
      nodes2=nz2*nxy2;
%  peripheral nodes
      nx1=nx-1;
      ny1=ny-1;
      nz1=nz-1;
   
    fclose(f3);
    %----------------------end of velocity input
%----------------------------------------------------------    
%bldmap    
%    array size limits
     ixkms=1500;
     iykms=1500;
     izkms=1500;

      xl=bld-xn(1);
      ixmax=(xn(nx)+xl)/bld;
      yl=bld-yn(1);
      iymax=(yn(ny)+yl)/bld;
      zl=bld-zn(1);
      izmax=(zn(nz)+zl)/bld;
s=zeros(nodes,1);
 for  k=1:nz;
   for j=1:ny;
       for i=1:nx;
       nd=i+nx*(j-1)+nxy*(k-1);
       s(nd)=1/vel(i,j,k);
       end
   end;
end;

%  Check for array size overflow
      if(ixmax>ixkms|| iymax>iykms|| izmax>izkms)
fprintf([' ***** error in array size maximum map dimensions (km) x=%d,'...
    'y=%d z=%d'],ixkms,iykms,izkms);
fprintf(' Actual map size (km):  x=%d y=%d z=%d',ixmax,iymax,izmax);
      
       return
      end
 
ix=1;
      for  i=1:ixmax
         ix1=ix+1;
         xnow=i*bld-xl;
         if xnow>=xn(ix1)
         ix=ix1;
         end
         ixloc(i)=ix;
       end
  
%  Fill remainder of array with zeroes.

      for  i=ixmax+1:ixkms
         ixloc(i)=0;
      end

 iy=1;
     for  i=1:iymax
         iy1=iy+1;
         ynow=i*bld-yl;
         if ynow>=yn(iy1)
             iy=iy1;
         end
         iyloc(i)=iy;
     end
      for i=iymax+1:iykms
         iyloc(i)=0;
      end
  iz=1;
      for  i=1:izmax
         iz1=iz+1;
         znow=i*bld-zl;
         if znow>=zn(iz1)
             iz=iz1;
         end
         izloc(i)=iz;
      end

     for i=izmax+1:izkms
         izloc(i)=0;
     end
     
 %end of bldmap
%-----------------------------------------------

%read arrival times 

[f4,msg]=fopen('b1s1.txt','r');   
 if f4<0
    disp(msg);
    fprintf('frac');
 end
 ne=1;
while ~feof(f4)
  No_of_sensors=fscanf(f4,'%f',1);
  if ~isempty(No_of_sensors)
  Np=No_of_sensors;
      for k=1:Np
        
  %printf("\n for sensor with travel time %d",k);
       n=fscanf(f4,'%f',1);
       time(k,ne)=fscanf(f4,'%f',1);
       ax(ne,k)=xst(n);
       by(ne,k)=yst(n);
	   cz(ne,k)=zst(n);
      end
    ne=ne+1;  
   end
    
end
fclose(f4);


% - - -- - - - - - - - - - - - - - - - - - - - - - - - - -   
%location and sirt loop
m=1;
      A=[];
w=[];
    nen=0;
      khit=zeros(1,nodes);
    for ne=1:neq
     
        xguess=[1 1 20];
       [guess res]=amoeba('res',xguess,50);
        %guess=amoeba('res',xguess);
        evt{ne}=[guess(1) guess(2) guess(3)];
       %evt{ne}=guess;
        
         if( -5<guess(1)&&guess(1)<60&&-16<guess(2)&&guess(2)<16&&-1<guess(3)&&guess(3)<48)
            nen=nen+1;
        a=newmatrix(evt{ne});
        if res<=2
            w(nen*8-7:nen*8)=1;
            elseif 2<res<=6 
                w(nen*8-7:nen*8)=0.9;
                elseif 6<res<=15 
                w(nen*8-7:nen*8)=0.7;
            else  w(nen*8-7:nen*8)=0.5;
        end
        A=[A;a];
        index(nen)=ne;
        
        end
        
        
    end
    
    A1=A>0;
    [dm dn]=size(A1);
    for i=1:dn
        khit(1,i)=sum(A1(:,i));
    end
    
    if err==1
        break
    end
   t=caltime(time,nen,evt,index);
   
   [itt,s]=kac(A,t,w,0.0005,800);
   %s=sirt(A,t);
   v=1./s;
   % cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

% Post to Grid
for  k=1:nz;
   for j=1:ny;
       for i=1:nx;
       ndx=i+nx*(j-1)+nxy*(k-1);
       vel(i,j,k)=v(ndx);
       hit(i,j,k)=khit(ndx);
       end
   end;
end;

 fprintf('iiiii%d',m); 

% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
%present in 3D grid
vg=[];
hitg=[];

for z=zn(2:nz-1)
    for y=yn(2:ny-1)
        for x=xn(2:nx-1)
            [i j k]=intmap(x,y,z);
            ig=i-1;
            jg=j-1;
            kg=k-1;
            vg(jg,ig,kg)=vel(i,j,k);
            hitg(jg,ig,kg)=hit(i,j,k);
        end
    end
end

save xn xn
save yn yn
save zn zn
save nx nx
save ny ny
save nz nz
save hitgnn1 hitg 
save vgnn1 vg 
save evtnn1 evt 
save mnn1 m
save nen1 nen




% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
 
 
for m=2:it
    A=[];
    nen=0;
    w=[];
    khit=zeros(1,nodes);
    for ne=1:neq
       
       location=evt{ne};
        %xguess=[location(1) location(3) ];
        %xguess=evt{ne};
        [guess res]=amoeba('res',location,50);
        evt{ne}=[guess(1) guess(2) guess(3)];
        %evt{ne}=guess;
        
       if( -5<guess(1)&&guess(1)<60&&-16<guess(2)&&guess(2)<16&&-1<guess(3)&&guess(3)<48)
            nen=nen+1;
            if res<=2
            w(nen*8-7:nen*8)=1;
            elseif 2<res<=6 
                w(nen*8-7:nen*8)=0.9;
                elseif 6<res<=15 
                w(nen*8-7:nen*8)=0.7;
            else  w(nen*8-7:nen*8)=0.5;
        end
        a=newmatrix(evt{ne});
        A=[A;a];
        index(nen)=ne;
        end
        
    end
    
    A1=A>0;
    [dm dn]=size(A1);
    for i=1:dn
        khit(1,i)=sum(A1(:,i));
    end
    
    
    if err==1
        break
    end
    t=caltime(time,nen,evt,index);
   [itt,s]=kac(A,t,w,0.0005,800);
   %s=sirt(A,t);
   v=1./s;
   % cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

% Post to Grid
for  k=1:nz;
   for j=1:ny;
       for i=1:nx;
       ndx=i+nx*(j-1)+nxy*(k-1);
       vel(i,j,k)=v(ndx);
       hit(i,j,k)=khit(ndx);
       end
   end;
end;
fprintf('iiiii%d',m);




% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
end


% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
%present in 3D grid
 
vg=[];
hitg=[];
xg=xn(2:nx-1);
yg=yn(2:ny-1);
zg=zn(2:nz-1);

for z=zn(2:nz-1)
    for y=yn(2:ny-1)
        for x=xn(2:nx-1)
            [i j k]=intmap(x,y,z);
            ig=i-1;
            jg=j-1;
            kg=k-1;
            vg(jg,ig,kg)=vel(i,j,k);
            hitg(jg,ig,kg)=hit(i,j,k);
            
        end
    end
end

save xgnn xg
save ygnn yg
save zgnn zg
save hitgnn hitg
save vgnn vg
save evtnn evt
save mnn m
save nen nen


% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

fprintf(f16,'FINAL LOCATIONS  X     Y    Z\n');
for ne=1:neq
    fprintf(f16,'%4d %7.2f %7.2f %7.2f\n',ne,evt{ne});
end

 
         
        if(iuseq==0) 
           fprintf(f16,'FINAL P-VELOCITY MODEL\n');
        else
           fprintf(f16,'FINAL Q MODEL');
        end
 
         kv=1;
         for k=1:nz
            k2=k + (kv-1)*nz; 
          if(iuseq==0) 
             fprintf(f16,'layer %3d  velocity nodes   z =%7.1f\n',k,zn(k));
          else
              fprintf(f16,'layer %3d  nodes    z =%7.1f\n',k,zn(k));
          end
         for  j=1:ny
              for i=1:nx
                  if iuseq==0
                  fprintf(f16,'%5.2f',vel(i,j,k2));
                  else
                      fprintf(f16,'%5.2f',qval(i,j,k));
                  end
              end
              fprintf(f16,'\n');
         end
         end
            
     
   fprintf(f16,' OBSERVATION MATRIX - KHIT - (will be 0 for fixed nodes)\n'); 
         
         for  k=1:nz
            k2=k+(kv-1)*nz;
            
            if(iuseq==0) 
              fprintf(f16,'layer %3d  P-vel nodes    z =%7.1f\n',k,zn(k)); 
          else
              fprintf(f16,'layer %3d  Q     nodes    z =%7.1f\n',k,zn(k)); 
            end
            kk=k+(kv-1)*nz;
            for  j=1:ny
               n1=(kk-1)*nxy+(j-1)*nx+1;
               n2=n1+nx-1;
               for i=n1:n2
                   fprintf(f16,'%6d',khit(i));
               end
               fprintf(f16,'\n');
            end
         end
   

 

fclose(f16);


