function PlotIt(sol,model)
    X=model.X;
    Y=model.Y;
    n=model.n;
    A=sol.A;
    for i=1:n
        for j=i+1:n
            if A(i,j)~=0
                plot([X(i) X(j)],[Y(i) Y(j)],':c',...
    'LineWidth',3,...
    'MarkerSize',10,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.9,0.1,0.1])
                hold on;
                grid on;
            end
        end
    end
    plot(X,Y,'bp','MarkerSize',15,'MarkerEdgeColor',[1 1 0],'MarkerFaceColor',[0.2 0.2 1]);
    hold off;
end