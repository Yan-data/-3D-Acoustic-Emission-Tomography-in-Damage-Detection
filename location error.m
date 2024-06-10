 location error for 63 sources


load evt-14foam
xt=zeros(1,63);
yt=zeros(1,63);

for i=1:63
    loc=evt{i};
    xt(i)=loc(1);
    yt(i)=loc(3);
end


a=140:-20:20;
b=120:20:280;
[x,y]=meshgrid(b,a);
yr=x(:)';
xr=y(:)';
ex=xr-xt;
ey=yr-yt;
error=((ex.*ex)+(ey.*ey));
err=sqrt(error);
avg1=sum(error);

acc=(avg1-avg)/avg1;


save acclayerb acclayerb

%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
location error for 6mm,30 degree,3mm


load evt-silica
xt=zeros(1,54);
yt=zeros(1,54);

for i=1:54
    loc=evt{i};
    xt(i)=loc(1);
    yt(i)=loc(3);
end


a=[140 120 100 60 40 20];
b=120:20:280;
[x,y]=meshgrid(b,a);
yr=x(:)';
xr=y(:)';
ex=xr-xt;
ey=yr-yt;
error=((ex.*ex)+(ey.*ey));
avg=sum(error);

acc=(avg1-avg)/avg1;


save accsilica accsilica

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%location error for 60 degree


load evt-60degree
xt=zeros(1,54);
yt=zeros(1,54);

for i=1:54
    loc=evt{i};
    xt(i)=loc(1);
    yt(i)=loc(3);
end


a=[140 120 80 60 40 20];
b=120:20:280;
[x,y]=meshgrid(b,a);
yr=x(:)';
xr=y(:)';
ex=xr-xt;
ey=yr-yt;
error=((ex.*ex)+(ey.*ey));
avg=sum(error);

acc=(avg1-avg)/avg1;


save acc60degree acc60degree


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%concrete
load evtnn1
xt=zeros(1,91);
yt=zeros(1,91);

for i=1:91
    loc=evt{i};
    xt(i)=loc(1);
    yt(i)=loc(3);
end


a=20:20:140;
b=[50 75 125:25:375];
[x,y]=meshgrid(b,a);
yr=x(:)';
xr=y(:)';
ex=xr-xt;
ey=yr-yt;
error=sqrt((ex.*ex)+(ey.*ey));
avg1=sum(error);

acc=(avg1-avg)/avg1;


save acc acc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%concrete 21
load evt21-120i15
xt=zeros(1,21);
yt=zeros(1,21);

for i=1:21
    loc=evt{i};
    xt(i)=loc(1);
    yt(i)=loc(3);
end


a=40:40:120;
b=[50:50:350];
[x,y]=meshgrid(b,a);
yr=x(:)';
xr=y(:)';
ex=xr-xt;
ey=yr-yt;
error=sqrt((ex.*ex)+(ey.*ey));
avg=sum(error);

acc=(avg1-avg)/avg1;


save acc acc


