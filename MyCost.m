function [z, sol]=MyCost(xhat,model)
    x=double(xhat>=0.5);
    d=model.d;
    A=CreateMatrixFromVector(x);
    q=CalcDisconnectivity(A);
    AD=A.*d;
    alpha=5*sum(d(:));
    SumAD=sum(AD(:));
    z=SumAD+alpha*q;
    sol.A=A;
    sol.q=q;
    sol.SumAD=SumAD;
    sol.z=z;
    sol.IsFeasible=(q==0);
end