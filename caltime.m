function t=caltime(time,nen,evt,index)
global ax by cz Np

for ne=1:nen
    
       new=index(ne);
       k=1;
      
       v=fv(new,evt{new},k);
       m=evt{new};
       l=sqrt((ax(new,1)-m(1))^2+(by(new,1)-m(2))^2+(cz(new,1)-m(3))^2);
       t(k,new)=l/v;
       
    for k=2:Np    
        t(k,new)=time(k,new)+t(1,new);
    end
        
end
    t=t(:)';  
    
end