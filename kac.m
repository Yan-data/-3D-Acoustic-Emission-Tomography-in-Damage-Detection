function [iter,x]=kac(A,b,w,tolx,maxiter)
 global s
% SYNTAX: [s,x]=kac(A,b,tolx,maxiter)
% The following MATLAB implementation of Kaczmarz algorithm shows how
% easy the algorithm is to implement.
% Inputs:
%          A    = Constraint matrix.
%          b    = right hand side.
%       tolx    = Terminate when the relative diff between two iterations
%                 is less than tolx.
%    maxiter    = Stop after maxiter iterations.
%
% Outputs:
%        x = Solution.
%
% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

% First, find the size of the matrix.

[m n] = size(A);


%[m,n]=size(A);
%
% Setup an initial solution of all zeros.
x=s;
%x=zeros(n,1);
%x(1:n)=0.5;
iter=0;
%
% Precompute the row norms squared.
n2=zeros(m,1);
for i=1:m,
    n2(i)=norm(A(i,:)',2)^2;
end;
%
% The main loop performs iterations of Kaczmarz algorithm until
% maxiters is exceeded or successive iterates differ by less
% than tolx.
while (1==1);
%
% Check to see whether we’ve exceeded the maxiters limit.
    iter=iter+1;
    if (iter > maxiter);
        disp('Maximum Iteration Exceeded')
    return;
    end;
%
% Start the update cycle with the current solution.
newx=x;
%
% Perform a cycle of m updates.
    for i=1:m,
        adj=0.8*w(m)*((newx'*A(i,:)'-b(i))/(n2(i)))*A(i,:)';
        adj(adj>0.003)=0.003;
        adj(adj<-0.003)=-0.003;
        newx=newx-adj;
        newx(newx>1/3)=1/3;
        newx(newx<1/6)=1/6;
             
    end;
    
    A1=A>0;

        for j=1:m
       if sum(A1(:,j))<1
          newx(j)=1/4;
       end
        end
%
% Check for convergence to fixed solution.
    if (norm(newx-x)/(1+norm(x)) < tolx),
        return;
    end;
%
% Update x for the next major iteration.
    x=newx;
    
end;
% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

% cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
