function model=CreateModel()
    X = [30 0 0 100 60 20 0 10 90 40 20 60 0 40 20 20 60 100];
    Y = [20 60 40 40 80 10 80 80 100 80 40 20 100 30 80 100 60 70];
    n=numel(X);
    d=zeros(n,n);
    for i=1:n
        for j=i+1:n
            d(i,j)=sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
            d(j,i)=d(i,j);
        end
    end
    model.n=n;
    model.X=X;
    model.Y=Y;
    model.d=d;
end