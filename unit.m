function ud=unit(P1,P2)
A=P2-P1;
a=max(abs(A));
b=abs(A/a);
ud=norm(b);
end

%COMPUTE THE LENGTH IN ONE SQUARE ELEMENT