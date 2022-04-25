function A=CreateMatrixFromVector(x)
    k=numel(x);
    n=(sqrt(8*k+1)+1)/2;
    A=zeros(n,n);
    c=0;
    for i=1:n
        for j=i+1:n
            c=c+1;
            A(i,j)=x(c);
            A(j,i)=x(c);
        end
    end
end