clear all 
close all
clc

addpath('Base')
addpath('FLP')
addpath('BMO')
addpath('SMA')
addpath('MPA')

%algorithms = { 'FLP','BMO','MPA','SMA'};
algorithms = { 'FLP'};

run = 1; % 25
Max_iteration = 6;
PopSize =5;
filename = 'result';
functionsNumber = 4;
ShowBestAnswer = 3;

solution = zeros(functionsNumber, run);
InitValues;
Answer = repmat(Chromosome(),(ShowBestAnswer*functionsNumber),MachineNumber);
currentval = 1;
for ii = 1 : length(algorithms)
    disp(algorithms(ii));
    algorithm = str2func(char(algorithms(ii)));
    %for i = 1 : functionsNumber
        %disp(i);
        %for j = 1 : run
            chromo = algorithm(algorithms(ii),Max_iteration,chromosomes,PopSize, MachineNumber,LengthWorkshop,WidthWorkshop,ub,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,ylower,yupper,xlower,xupper,f,C,ShowBestAnswer,LoC,WoC,XoC,YoC);
            %Answer(currentval,:)= chromo(ii,:);
            %currentval = currentval+1;
            %solution(i, j) = bestFitness - globalMins(i);
   
        %end
    %end
%     xlswrite(strcat(filename, '-d=', num2str(dimension), '.xlsx'), solution, func2str(algorithm));
%     eD = strcat(func2str(algorithm), '-Bitti :)');
%     disp(eD);
end
%DrawMap(Answer,tempval,W,L,Lo,Wo,Xo,Yo,ylower,yupper,xlower,xupper);
