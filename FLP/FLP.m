function temp = FLP(algorithmName,Max_iteration,chromosomes,PopSize, MachineNumber,LengthWorkshop,WidthWorkshop,ub,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,ylower,yupper,xlower,xupper,f,C,ShowBestAnswer,LoC,WoC,XoC,YoC)
tic



%%%%%%%%%%%%
% newPopulation = CreateCar(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);  
% Result = IsOverLapHappend(newPopulation,MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
% temp= Fitness(newPopulation,MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);    
% 



% addpath('FLP');
% addpath('BMO');
% addpath('SMA');
% addpath('MPA');
disp('FLP is now tackling your problem')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Step 1.1: Define the Population size; crossover probability and mutation probability
%PopSize = randi([100 250],1);
%disp(['Population size is ' num2str(PopSize)]);

CrossoverProbability = 0.7;
CP_NormalDistribution = CrossoverProbability;
CP_StandardDeviation = 0.1; 

MutationProbability = 0.18; 
MP_NormalDistribution = MutationProbability;
MP_StandardDeviation = 0.06;


elitism =0.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Step 1.2: Generate random initial populations of N chromosomes
MHC = zeros(PopSize,1);
Score = zeros(PopSize,1);

%disp('Generate random initial populations of N chromosomes')
for i = 1:PopSize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Step 1.3: Evaluate the fitness of all the individuals using A* algorithm
    MHC(i)= Fitness(chromosomes(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);    
end
Iteration = 1;
%disp('Step 2')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Step 2
while Iteration <  Max_iteration
    disp(['FLP iterations is ' num2str(Iteration)]);
    newPopulation = chromosomes;
    %disp('Step 2.1')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Step 2 .1
    Iteration = Iteration + 1;
    %disp(['Current iteration size is ' num2str(Iteration)]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Selection of the best solutions for reproduction
    %disp('Selection of the best solutions for reproduction')
    for i = 1:PopSize
       MHC(i)= Fitness(chromosomes(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);    
    end 
    [val,idx] = sort(MHC);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Apply Crossover operator
    %disp('Apply Crossover')
    for i = 1:2:(PopSize-1)
        [newPopulation(i,:),newPopulation(i+1,:)]= Crossover(chromosomes(idx(i),:),chromosomes(idx(i+1),:),CrossoverProbability);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Apply mutation operator
    %disp('Apply mutation')
    for i = 1:PopSize
        newPopulation(i,:)= Mutation(newPopulation(idx(i),:),MutationProbability);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Update the fitness of the modified individuals using A* algorithm
    %disp('Update the fitness')
    for i = 1:PopSize
        MHC(i)= Fitness(newPopulation(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);    
    end
    [val,idx] = sort(MHC);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Perform elitism
    %disp('Perform elitism')
    for i=PopSize*elitism+1:PopSize
        newPopulation(round(i),:) = chromosomes(idx(round(i)),:);
    end
    
    for i = 1:PopSize
        Result = IsOverLapHappend(newPopulation(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
        if Result == true
            newPopulation(i,:) = CreateCar(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);  
            Result = IsOverLapHappend(newPopulation(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
        end
        MHC(i)= Fitness(newPopulation(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);    
    end
    [val,idx] = sort(MHC);
    chromosomes = newPopulation;
end

 temp = repmat(Chromosome(),ShowBestAnswer,MachineNumber);
%temp = chromosomes(idx(1):idx(ShowBestAnswer),:);
for x=1:ShowBestAnswer
    temp(x,:)= chromosomes(idx(x),:);
    tempval(x) = val(x);
end
elapsed_time=toc;
DrawMap(algorithmName,LengthWorkshop,WidthWorkshop,temp,tempval,W,L,LoC,WoC,XoC,YoC);
fprintf('FLP Finished %f Seconds. \n',elapsed_time);
end




