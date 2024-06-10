function a=newmatrix(evt)
global ax by cz Np ne nx ny nz nxy 


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
        out=0;
       for h=1:N
           [ip,jp,kp]=intmap(X(h),Y(h),Z(h));
           in=ip+nx*(jp-1)+nxy*(kp-1);
     % THE VALUE IS ORGANIZED LINE BY LINE INSTEAD OF COLUMN BY COLUMN
           if out==in
               a(j,in)=a(j,in)+ud;
           else
               a(j,in)=ud;
           end
               
           out=in;
           %l=a(j,in)+l;
% Assign zero weight to boundary nodes (these nodes are not 
%  included in the inversion, but are in the velocity array,
%  thus we want to avoid writing to negative or incorrect 
%  elements of the partial derivative matrix)

 
       end
%       fprintf('path %f\n',l);
    end
end
 
    
    
    
    
    
    
    
    
    
    
    
    