
clc;
clear;
close all;
warning('off');

%% Problem 
model=CreateModel();
CostFunction=@(xhat) MyCost(xhat,model);        % Cost Function
nVar=model.n*(model.n-1)/2;             % Number of Decision Variables
VarSize=[1 nVar];   % Decision Variables Matrix Size
VarMin=0;         % Lower Bound of Variables
VarMax=1;         % Upper Bound of Variables

%% TLBO Parameters
MaxIt = 500;        % Maximum Number of Iterations
nPop = 300;           % Population Size

%% Initial
% Empty Structure for Individuals
empty_individual.Position = [];
empty_individual.Cost = [];
empty_individual.Sol=[];
% Initialize Population Array
pop = repmat(empty_individual, nPop, 1);
% Initialize Best Solution
BestSol.Cost = inf;
% Initialize Population Members
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost, pop(i).Sol]= CostFunction(pop(i).Position);
if pop(i).Cost < BestSol.Cost
BestSol = pop(i);
end
end
% Initialize Best Cost Record
BestCosts = zeros(MaxIt, 1);

%% TLBO Body
for it = 1:MaxIt
% Calculate Population Mean
Mean = 0;
for i = 1:nPop
Mean = Mean + pop(i).Position;
end
Mean = Mean/nPop;
% Select Teacher
Teacher = pop(1);
for i = 2:nPop
if pop(i).Cost < Teacher.Cost
Teacher = pop(i);
end
end
% Teacher Phase
for i = 1:nPop
% Create Empty Solution
newsol = empty_individual;
% Teaching Factor
TF = randi([1 2]);
% Teaching (moving towards teacher)
newsol.Position = pop(i).Position ...
+ rand(VarSize).*(Teacher.Position - TF*Mean);
% Clipping
newsol.Position = max(newsol.Position, VarMin);
newsol.Position = min(newsol.Position, VarMax);
% Evaluation
[newsol.Cost, newsol.Sol]= CostFunction(newsol.Position);
% Comparision
if newsol.Cost<pop(i).Cost
pop(i) = newsol;
if pop(i).Cost < BestSol.Cost
BestSol = pop(i);
end
end
end

% Learner Phase
for i = 1:nPop
A = 1:nPop;
A(i) = [];
j = A(randi(nPop-1));
Step = pop(i).Position - pop(j).Position;
if pop(j).Cost < pop(i).Cost
Step = -Step;
end
% Create Empty Solution
newsol = empty_individual;
% Teaching (moving towards teacher)
newsol.Position = pop(i).Position + rand(VarSize).*Step;
% Clipping
newsol.Position = max(newsol.Position, VarMin);
newsol.Position = min(newsol.Position, VarMax);
% Evaluation
[newsol.Cost, newsol.Sol]= CostFunction(newsol.Position);
% Comparision
if newsol.Cost<pop(i).Cost
pop(i) = newsol;
if pop(i).Cost < BestSol.Cost
BestSol = pop(i);
end
end
end
% Store Record for Current Iteration
BestCosts(it) = BestSol.Cost;
% Show Iteration Information
disp(['In Iteration ' num2str(it) ': TLBO Best Cost Is = ' num2str(BestCosts(it))]);
figure(1);
PlotIt(BestSol.Sol,model);
pause(0.01);
end
title('TLBO Minimum Spanning Tree');

%% Plot
figure;
semilogy(BestCosts,'k', 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;


