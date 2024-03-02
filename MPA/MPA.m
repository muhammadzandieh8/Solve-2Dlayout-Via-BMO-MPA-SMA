function temp = MPA(algorithmName,Max_iteration,chromosomes,PopSize, MachineNumber,LengthWorkshop,WidthWorkshop,ub,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,ylower,yupper,xlower,xupper,f,C,ShowBestAnswer,LoC,WoC,XoC,YoC)
tic
disp('MPA is now tackling your problem...')
addpath(genpath('..'))
dim = 3;   %dimension size

lb = [6 6 0];% lower boundary 
ub = [35 25 3];    % upper boundary

% initialize position
%bestPositions=zeros(1,dim);
Destination_fitness=inf;%change this to -inf for maximization problems
AllFitness = inf*ones(PopSize,1);%record the fitness of all slime mold
weight = ones(PopSize,1);%fitness weight of each slime mold
Convergence_curve=zeros(1,Max_iteration);
z=0.3; % parameter

%disp('Initialize the set of random solutions...')
%Initialize the set of random solutions
Prey = chromosomes;

%%%%%%%%%%%%%%%%%%%%%%%%%555
Top_predator_pos=repmat(Chromosome(),1,MachineNumber);
Top_predator_fit=inf; 

Convergence_curve=zeros(1,Max_iteration);
stepsize=repmat(Chromosome(),PopSize,MachineNumber);
fitness=inf(PopSize,1);

Iter=1;
FADs=0.2;
P=0.5;

while Iter<=Max_iteration  
disp(['MPA iterations is ' num2str(Iter)]);
     %------------------- Detecting top predator -----------------    
     for i=1:size(Prey,1)  
        %Prey(i,:) = BringBackChromosome(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,M,Lo,Wo,Xo,Yo,Xio,Yio,Xoo,Yoo,ylower,yupper,xlower,xupper,Prey(i,:));       
        Result = IsOverLapHappend(Prey(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
        if Result == true
            Prey(i,:) = CreateCar(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);  
        end
        %Calculate Fitness
        fitness(i) = Fitness(Prey(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);                     
     if fitness(i)<Top_predator_fit 
       Top_predator_fit=fitness(i); 
       Top_predator_pos=Prey(i,:);
     end  
    end
     %------------------- Marine Memory saving -------------------  
 if Iter==1
   fit_old=fitness;    Prey_old=Prey;
 end
     
  Inx=(fit_old<fitness);
%   Prey=Indx.*Prey_old+~Indx.*Prey;
%   fitness=Inx.*fit_old+~Inx.*fitness;
  for i=1:size(Prey,1)
      if i == Inx(i)
          for j = 1:MachineNumber
              Prey(i,j).X =XYCal(((Inx(i)*Prey_old(i,j).X + ~Inx(i)*Prey(i,j).X)),LengthWorkshop);
              Prey(i,j).Y = XYCal(((Inx(i)*Prey_old(i,j).Y + ~Inx(i)*Prey(i,j).Y)),WidthWorkshop);
              Prey(i,j).Orientation = OrientationCal((Inx(i)*Prey_old(i,j).Orientation + ~Inx(i)*Prey(i,j).Orientation));
          end
          fitness(i) = Fitness(Prey(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);
          if fitness(i)<Top_predator_fit 
               Top_predator_fit=fitness(i); 
               Top_predator_pos=Prey(i,:);
          end
      end
  end    
  fit_old=fitness;    Prey_old=Prey;

     %------------------------------------------------------------   
     
 Elite=repmat(Top_predator_pos,PopSize,1);  %(Eq. 10) 
 CF=(1-Iter/Max_iteration)^(2*Iter/Max_iteration);
                             
 RL=0.05*levy(PopSize,MachineNumber,1.5);   %Levy random number vector
 RB=randn(PopSize,MachineNumber);          %Brownian random number vector
           
  for i=1:size(Prey,1)
     for j=1:size(Prey,2)        
       R=rand();
          %------------------ Phase 1 (Eq.12) ------------------- 
       if Iter<Max_iteration/3 
          %stepsize(i,j)=RB(i,j)*(Elite(i,j)-RB(i,j)*Prey(i,j));                    
          %Prey(i,j)=Prey(i,j)+P*R*stepsize(i,j); 
          stepsize(i,j).X=(RB(i,j)*(Elite(i,j).X-RB(i,j)*Prey(i,j).X));                    
          stepsize(i,j).Y=(RB(i,j)*(Elite(i,j).Y-RB(i,j)*Prey(i,j).Y));                    
          stepsize(i,j).Orientation=(RB(i,j)*(Elite(i,j).Orientation-RB(i,j)*Prey(i,j).Orientation));                    

          Prey(i,j).X=XYCal((Prey(i,j).X+P*R*stepsize(i,j).X),LengthWorkshop); 
          Prey(i,j).Y=XYCal((Prey(i,j).Y+P*R*stepsize(i,j).Y),WidthWorkshop); 
          Prey(i,j).Orientation=OrientationCal(Prey(i,j).Orientation+P*R*stepsize(i,j).Orientation);           
          %--------------- Phase 2 (Eqs. 13 & 14)----------------
       elseif Iter>Max_iteration/3 && Iter<2*Max_iteration/3 
          
         if i>size(Prey,1)/2
          %stepsize(i,j)=RB(i,j)*(RB(i,j)*Elite(i,j)-Prey(i,j));
          %Prey(i,j)=Elite(i,j)+P*CF*stepsize(i,j); 
          stepsize(i,j).X=(RB(i,j)*(RB(i,j)*Elite(i,j).X-Prey(i,j).X));                    
          stepsize(i,j).Y=(RB(i,j)*(RB(i,j)*Elite(i,j).Y-Prey(i,j).Y));       
          stepsize(i,j).Orientation=(RB(i,3)*(RB(i,j)*Elite(i,j).Orientation-Prey(i,j).Orientation));
          
          Prey(i,j).X=XYCal((Elite(i,j).X+P*CF*stepsize(i,j).X),LengthWorkshop); 
          Prey(i,j).Y=XYCal((Elite(i,j).Y+P*CF*stepsize(i,j).Y),WidthWorkshop); 
          Prey(i,j).Orientation=OrientationCal(Elite(i,j).Orientation+P*CF*stepsize(i,j).Orientation);      
         else
          %stepsize(i,j)=RL(i,j)*(Elite(i,j)-RL(i,j)*Prey(i,j));                     
          %Prey(i,j)=Prey(i,j)+P*R*stepsize(i,j);  
          stepsize(i,j).X=RL(i,j)*(Elite(i,j).X-RL(i,j)*Prey(i,j).X);                   
          stepsize(i,j).Y=RL(i,j)*(Elite(i,j).Y-RL(i,j)*Prey(i,j).Y);                   
          stepsize(i,j).Orientation=(RL(i,j)*(Elite(i,j).Orientation-RL(i,j)*Prey(i,j).Orientation));      
          
          Prey(i,j).X=XYCal((Elite(i,j).X+P*R*stepsize(i,j).X),LengthWorkshop);
          Prey(i,j).Y=XYCal((Elite(i,j).Y+P*R*stepsize(i,j).Y),WidthWorkshop); 
          Prey(i,j).Orientation=OrientationCal(Elite(i,j).Orientation+P*R*stepsize(i,j).Orientation);    
         end
         %----------------- Phase 3 (Eq. 15)-------------------
       else 
%            stepsize(i,j)=RL(i,j)*(RL(i,j)*Elite(i,j)-Prey(i,j)); 
%            Prey(i,j)=Elite(i,j)+P*CF*stepsize(i,j);  
          stepsize(i,j).X=RL(i,j)*(RL(i,j)*Elite(i,j).X-Prey(i,j).X);               
          stepsize(i,j).Y=RL(i,j)*(RL(i,j)*Elite(i,j).Y-Prey(i,j).Y);                    
          stepsize(i,j).Orientation=(RL(i,j)*(Elite(i,j).Orientation-RL(i,j)*Prey(i,j).Orientation));
          
          Prey(i,j).X=XYCal((Elite(i,j).X+P*CF*stepsize(i,j).X),LengthWorkshop); 
          Prey(i,j).Y=XYCal((Elite(i,j).Y+P*CF*stepsize(i,j).Y),WidthWorkshop); 
          Prey(i,j).Orientation=OrientationCal(Elite(i,j).Orientation+P*CF*stepsize(i,j).Orientation);  
       end  
      end                                         
  end    
        
     %------------------ Detecting top predator ------------------        
 for i=1:size(Prey,1)  
        %Calculate Fitness
        fitness(i) = Fitness(Prey(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);                     
     if fitness(i)<Top_predator_fit 
       Top_predator_fit=fitness(i); 
       Top_predator_pos=Prey(i,:);
     end  
 end       
     %---------------------- Marine Memory saving ----------------   
 if Iter==0
   fit_old=fitness;    Prey_old=Prey;
 end
     
  Inx=(fit_old<fitness);
%   Prey=Indx.*Prey_old+~Indx.*Prey;
%   fitness=Inx.*fit_old+~Inx.*fitness;
  for i=1:size(Prey,1)
      if i == Inx(i)
          for j = 1:MachineNumber
              Prey(i,j).X = XYCal((Inx(i)*Prey_old(i,j).X + ~Inx(i)*Prey(i,j).X),LengthWorkshop); 
              Prey(i,j).Y = XYCal((Inx(i)*Prey_old(i,j).Y + ~Inx(i)*Prey(i,j).Y),WidthWorkshop);
              Prey(i,j).Orientation = OrientationCal(Inx(i)*Prey_old(i,j).Orientation + ~Inx(i)*Prey(i,j).Orientation);
          end
      end
  end    
  fit_old=fitness;    Prey_old=Prey;
     %---------- Eddy formation and FADs’ effect (Eq 16) ----------- 
                             
  if rand()<FADs
     U=rand(PopSize,MachineNumber)<FADs;                                                                                              
     %Prey=Prey+CF*((Xmin+rand(N,dim).*(Xmax-Xmin)).*U);
       for i=1:size(Prey,1)
         for j=1:size(Prey,2)
              Prey(i,j).X = XYCal((Prey(i,j).X +CF*((lb(1)+randi([0,PopSize])*(ub(1)-lb(1)))*U(i,j))),LengthWorkshop);
              Prey(i,j).Y = XYCal((Prey(i,j).Y +CF*((lb(2)+randi([0,PopSize])*(ub(2)-lb(2)))*U(i,j))),WidthWorkshop);
              Prey(i,j).Orientation = OrientationCal(Prey(i,j).Orientation +CF*((lb(3)+randi([0,PopSize])*(ub(3)-lb(3)))*U(i,j)));
         end
       end

  else
     r=rand();  Rs=size(Prey,1);
%      stepsi=(FADs*(1-r)+r)*(Prey(randperm(Rs),:)-Prey(randperm(Rs),:));
     for i=1:size(Prey,1)
        for j=1:size(Prey,2)
              idx = randi([1,Rs]);
              idx2 = randi([1,Rs]);
              stepsize(i,j).X=(FADs*(1-r)+r)*(Prey(idx,j).X-Prey(idx2,j).X);    
              stepsize(i,j).Y=(FADs*(1-r)+r)*(Prey(idx,j).Y-Prey(idx2,j).Y);    
              stepsize(i,j).Orientation=(FADs*(1-r)+r)*(Prey(idx,j).Orientation-Prey(idx2,j).Orientation);    
                                       
              Prey(i,j).X=XYCal((Prey(i,j).X+stepsize(i,j).X),LengthWorkshop);
              Prey(i,j).Y=XYCal((Prey(i,j).Y+stepsize(i,j).Y),WidthWorkshop);              
              Prey(i,j).Orientation=OrientationCal(Prey(i,j).Orientation+stepsize(i,j).Orientation);                    

        end
       end     
  end                                                      
  Iter=Iter+1;  
  Convergence_curve(Iter)=Top_predator_fit;
  for i=1:size(Prey,1)
         Result = IsOverLapHappend(Prey(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
        if Result == true
            Prey(i,:) = CreateCar(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);  
        end
  end
end
 for i=1:size(Prey,1)  
        fitness(i) = Fitness(Prey(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C);                     
 end
[val,idx] =sort(fitness);
temp = repmat(Chromosome(),ShowBestAnswer,MachineNumber);
for x=1:ShowBestAnswer
    temp(x,:)= Prey(idx(x),:);
    tempval(x) = val(x);
end
elapsed_time=toc;
DrawMap(algorithmName,LengthWorkshop,WidthWorkshop,temp,tempval,W,L,LoC,WoC,XoC,YoC);
fprintf('MPA Finished %f Seconds. \n',elapsed_time);
end
