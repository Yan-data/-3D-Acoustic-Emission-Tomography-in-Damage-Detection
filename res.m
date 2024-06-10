function sum_abs=res(loc)
global Np time
global ax
global by
global cz ne err
%loc=[loc(1) 0 loc(2)];
for i=1:Np
    v(i)=fv(ne,loc,i);
    if err==1
        fprintf('res error');
        break
    end
end

for i=2:Np
    delta(i)=v(i)*time(i,ne)-v(1)*time(1,ne);
    D(i)=ax(ne,1)^2+by(ne,1)^2+cz(ne,1)^2-ax(ne,i)^2-by(ne,i)^2-cz(ne,i)^2;
    deltax(i)=ax(ne,1)-ax(ne,i);  
    deltay(i)=by(ne,1)-by(ne,i);
    deltaz(i)=cz(ne,1)-cz(ne,i);
end
R=0;
for i=3:Np
    A(i)=2*(deltax(2)/delta(2)-deltax(i)/delta(i));
    B(i)=2*(deltay(2)/delta(2)-deltay(i)/delta(i));
    C(i)=2*(deltaz(2)/delta(2)-deltaz(i)/delta(i));
    W(i)=D(2)/delta(2)-D(i)/delta(i)+delta(2)-delta(i);
    h(i)=sqrt(A(i)^2+B(i)^2+C(i)^2);
    alpha(i)=A(i)/h(i);
    beta(i)=B(i)/h(i);
    gama(i)=C(i)/h(i);
    p(i)=W(i)/h(i);
    r(i)=abs(alpha(i)*loc(1)+beta(i)*loc(2)+gama(i)*loc(3)-p(i));
    
    R=R+r(i);
end
   sum_abs=R;
end
%end badness
