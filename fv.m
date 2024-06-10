function ve=fv(ne,loc,i)
global ax by cz 
global iuseq err
iuseq=0;
P1=loc;
P2=[ax(ne,i),by(ne,i),cz(ne,i)];
[X,Y,Z]=bresenham_line3d(P1,P2);
N=length(X);
ve=0;

for h=1:N
    if iuseq==0
       v(h)=vel3(0,X(h),Y(h),Z(h));
    elseif iuseq==1
       v(h)=vel3(1,X(h),Y(h),Z(h));
    end
    
    ve=ve+v(h);
end

if err==1
    return
end
ve=ve/N;

end

    
