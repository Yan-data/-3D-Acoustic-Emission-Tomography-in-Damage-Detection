xx=[];yy=[];zz=[];
for i=1:31
    even=evt{i};
    
    x(i)=even(1);
    y(i)=even(2);
    z(i)=even(3);
           
    if( -40<x(i)&&x(i)<40&&-40<y(i)&&y(i)<40&&-1<z(i)&&z(i)<101)
            
    xx(i)=x(i);
    yy(i)=y(i);
    zz(i)=z(i);
   end
       
    
    
end
%figure
scatter3(xx,yy,zz,40,'r')


hold on
xreal=[ 40 80 120  40 80 120 40 80 120 40 80 120 40 80 120 40 80 120 40 80 120];
yreal=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
zreal=[50 50 50 100 100 100 150 150 150 200 200 200 250 250 250 300 300 300 350 350 350];
scatter3(xreal,yreal,zreal,30,'fill');

figure
k=10;
title(['z=',num2str(zg(k))])
xlabel('x')
ylabel('y')
for j=1:14
    for i=1:14
        xf(i,j)=xg(i);
        yf(i,j)=yg(j);
        zf(i,j)=hitg(i,j,k);
    end
end

surf(xf,yf,zf)
view(0,90)
%%%%%%%%%%%%%%%%%%%%%%%%x-y
for k=10
    figure
    hold on
  
    title(['z=',num2str(zg(k)),'mm'])
    xlabel('x (mm)')
ylabel('y (mm)')
%axis image,box off

t = colorbar('peer',gca);
set(get(t,'ylabel'),'String', 'ray numbers');
surf(xg,yg,reshape(hitg(:,:,k),17,16)')
view(0,90)
hold off
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%x-z
for k=3
    figure
    hold on
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')

set(gca,'ZDir','reverse')

title(['y=',num2str(yg(k)),'mm'])
%set(gca,'YDir','reverse');
t = colorbar('peer',gca);
set(get(t,'ylabel'),'String', 'ray numbers');
surf(xg,zg,reshape(hitg(:,k,:),17,23)')
view(0,90)
axis image
hold off
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%y-z
for k=10
    figure
    hold on
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')

set(gca,'ZDir','reverse')
%axis image,box off
title(['x=',num2str(yg(k)),'mm'])
%set(gca,'YDir','reverse');
t = colorbar('peer',gca);
set(get(t,'ylabel'),'String', 'ray numbers');
surf(yg,zg,reshape(hitg(k,:,:),16,23)')
%h=ones(16,23);
%mesh(yg,zg,h,'EdgeColor','black')

view(0,90)
axis image
hold off
end
%cross-section of number of rays

end


[xi yi zi]=meshgrid(xn(2):(xn(nx-1)-xn(2))/100:xn(nx-1), yn(2):(yn(ny-1)-yn(2))/100 :yn(ny-1),zn(2):(zn(nz-1)-zn(2))/100 :zn(nz-1));
vi=interp3(xg,yg,zg,vg,xi,yi,zi);

figure
hold on
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')

%set(gca,'YDir','reverse')
%set(gca,'ZDir','reverse')
p=0;
slice(xi,yi,zi,vi,[],[ p],[]),shading interp
view(0,180)
title(['z=',num2str(p),'mm']);
t = colorbar('peer',gca);
set(get(t,'ylabel'),'String', 'velocity km/s');
axis image,box off

hold off




%%%%%%%%%%%%%%%%%%%%%%%%%%%% x-z plane
p=30;
hold on
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')
set(gca,'ZDir','reverse')
axis image,box off
title(['y=',num2str(p),'mm']);
t = colorbar('peer',gca);
set(get(t,'ylabel'),'String', 'velocity km/s');
%%%%%%line1
x1=0:0.16:160;
y1=ones(1,1001)*p;
z1=ones(1,1001)*100;
plot3(x1,y1,z1,'Color','red','LineWidth',2);

%%%%%%%%%%%line2
x2=0:0.16:160;
y2=ones(1,1001)*p;
z2=ones(1,1001)*105;
plot3(x2,y2,z2,'Color','red','LineWidth',2);
%%%%%%%%%%%line3
x3=ones(1,1001)*160;
y3=ones(1,1001)*p;
z3=100:0.005:105;
plot3(x3,y3,z3,'Color','red','LineWidth',2);
%%%%%%%%%%%line4
x4=zeros(1,1001);
y4=ones(1,1001)*p;
z4=100:0.005:105;
plot3(x4,y4,z4,'Color','red','LineWidth',2);

hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%% y-z plane
p=80;
hold on
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')
%set(gca,'YDir','normal')
axis image,box off
title(['x=',num2str(p),'mm']);
t = colorbar('peer',gca);
set(get(t,'ylabel'),'String', 'velocity km/s');
%%%%%%line1
x1=ones(1,1001)*80;
y1=ones(1,1001)*15;
z1=180:0.04:220;
plot3(x1,y1,z1,'Color','red','LineWidth',2);

%%%%%%%%%%%line2
x2=ones(1,1001)*80;
y2=ones(1,1001)*35;
z2=180:0.04:220;
plot3(x2,y2,z2,'Color','red','LineWidth',2);
%%%%%%%%%%%line3
x3=ones(1,1001)*80;
y3=15:0.02:35;
z3=ones(1,1001)*180;
plot3(x3,y3,z3,'Color','red','LineWidth',2);
%%%%%%%%%%%line4
x4=ones(1,1001)*80;
y4=15:0.02:35;
z4=ones(1,1001)*220;
plot3(x4,y4,z4,'Color','red','LineWidth',2);

hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%% x-y plane
p=100;
hold on
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')
set(gca,'YDir','normal')
axis image,box off
title(['z=',num2str(p),'mm']);
t = colorbar('peer',gca);
set(get(t,'ylabel'),'String', 'velocity km/s');
%%%%%%line1
x1=0:0.16:160;
y1=zeros(1,1001)*p;
z1=ones(1,1001)*100;
plot3(x1,y1,z1,'Color','red','LineWidth',2);

%%%%%%%%%%%line2
x2=0:0.16:160;
y2=ones(1,1001)*80;
z2=ones(1,1001)*100;
plot3(x2,y2,z2,'Color','red','LineWidth',2);
%%%%%%%%%%%line3
x3=ones(1,1001)*160;
y3=0:0.08:80;
z3=ones(1,1001)*p;
plot3(x3,y3,z3,'Color','red','LineWidth',2);
%%%%%%%%%%%line4
x4=zeros(1,1001);
y4=0:0.08:80;
z4=ones(1,1001)*p;
plot3(x4,y4,z4,'Color','red','LineWidth',2);

hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load xn
load yn
load zn
load nx
load ny
load nz
load xg
load yg
load zg
load vg

load  xg
load  yg
load zg
load  hitg
load  vg
load  evt
load m
load xn
load  yn
load zn
load nx
load ny
load nz



load hitg-3mm8sensor1 hitg 
load vg-3mm8sensor1 vg 
load evt-3mm8sensor1 evt 
load m-3mm8sensor1 m




