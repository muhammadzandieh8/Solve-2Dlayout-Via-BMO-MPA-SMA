%Number of machines
MachineNumber=8;
%Length of the workshop
LengthWorkshop = 35;
%Width of the workshop
WidthWorkshop = 25;
%Number of obstacles
M = 2;
% upper boundary
ub = [35 25 3];  
%PopSize =30;
%PopSize =230;

%Length of machine i in original orientation
L = [4	8	4	4	4	4	4	4];
%Width of machine i in original orientation
W = [4	4	4	4	4	6	4	4];
%Coordinates of the input of machine i in relation to its centroid.
Xio = [ 1	-2	-2	 2	-1	-1	 2	-1];
Yio = [ 2	 2	 2	-2	-2	-3	 1	 2];
%Coordinates of the output of machine i in relation to its centroid.
Xoo = [ 2	-4	-2	 2	 2	-2	-2	 1];
Yoo = [-1	-1	-2	 1	 0	 3	 1	-2];
%Length of obstacle i
%Vertical coordinates of the upper side of aisle
ylower = 9 ;
%Vertical dimension of the lower side of aisle
yupper = 12;

xlower = 0;

xupper = 35;

Lo  = [4 2];
%Width of obstacle i
Wo  = [2 4];
%The x-coordinate of obstacle i
Xo = [12 7];
%The Y-coordinate of obstacle i
Yo = [3 18];


LoC  = [4 2 35];
%Width of obstacle i
WoC  = [2 4 3];
%The x-coordinate of obstacle i
XoC = [12 7 18];
%The Y-coordinate of obstacle i
YoC = [3 18 10];
%Material flow quantity from facility i to facility j
f =[00  50  45  20  00  19  46  15;
    28	00	13	15	24	27	25	48;
    13	28	00	00	31	12	0	49;
    00	14	20	00	26	47	41	33;
    47	49	42	33	00	48	25	12;
    16	10	27	32	19	00	19	00;
    43	41	47	15	15	30	00	24;
    32	00	17	44	17	23	13	00;];
%Unit cost for transportation between two machines
C = [1  1  1  1  1  1  1  1;
     1  1  1  1  1  1  1  1;
     1  1  1  1  1  1  1  1;
     1  1  1  1  1  1  1  1;
     1  1  1  1  1  1  1  1;
     1  1  1  1  1  1  1  1;
     1  1  1  1  1  1  1  1;
     1  1  1  1  1  1  1  1;];
 chromosomes = repmat(Chromosome(),PopSize,MachineNumber);
 Overlaps =zeros(1,PopSize);
 tic
 for i = 1:PopSize
%     Res = false;

    chromosomes(i,:) = CreateCar(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
    d = IsOverLapHappend(chromosomes(i,:),MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
%      while ~Res

%           [chromosomes(i,:),Result] = CreateCarLocation(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,Lo,Wo,Xo,Yo);
%           Res = Result;
%           %Overlaps(i) = Overlap_Machines(chromosomes(i,:),L,W,Lo,Wo,Xo,Yo,ylower,yupper,xlower,xupper);   
%      end
 end    
 elapsed_time=toc;
fprintf('Create Poplation %f Seconds. \n',elapsed_time);
%  [val,idx] =sort(Overlaps);
%  disp(val);