function MHC= Fitness(chromosome,N,LengthWorkshop,WidthWorkshop,M,L,W,Xio,Yio,Xoo,Yoo,Lo,Wo,Xo,Yo,LoC,WoC,XoC,YoC,f,C)
%N= Number of machines
MHC = 0;
%LengthWorkshop = Length of the workshop
%WidthWorkshop =  Width of the workshop
%M = Number of obstacles
%L =  Length of machine i in original orientation
%W =Width of machine i in original orientation
%Xio ,Yio = Coordinates of the input of machine i in relation to its centroid.
%Xoo ,Yoo = Coordinates of the output of machine i in relation to its centroid.
%Lo  = Length of obstacle i
%Wo  = Width of obstacle i
%Xo = The x-coordinate of obstacle i
%Yo = The Y-coordinate of obstacle i
%ylower = Vertical coordinates of the upper side of aisle
%yupper = Vertical dimension of the lower side of aisle
%xlower = 1;
%Xupper = 1;
%F = Material flow quantity from facility i to facility j
%C  = Unit cost for transportation between two machines
Theta = zeros(1,N);
Xin   = zeros(1,N);
Yin   = zeros(1,N);
Xout  = zeros(1,N);
Yout  = zeros(1,N);
Result = IsOverLapHappend(chromosome,N,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
if Result == false
    Map = ones(WidthWorkshop,LengthWorkshop);
    %Add Obstacle Into Map
    for v = 1:length(Xo)
        Map(Yo(v)-floor(Wo(v)/2):Yo(v)+floor(Wo(v)/2), Xo(v)-floor(Lo(v)/2):Xo(v)+floor(Lo(v)/2)) = 0;
    end
    for i = 1:N
        Theta(i) = (pi / 2) * chromosome(i).Orientation;
        Xin(i) = floor(chromosome(i).X+(cos(Theta(i))*Xio(i))-(sin(Theta(i))*Yio(i)));%%shak dara,
        Yin(i) = floor(chromosome(i).Y+(cos(Theta(i))*Yio(i))+(sin(Theta(i))*Xio(i)));
        Xout(i) =floor(chromosome(i).X+(cos(Theta(i))*Xoo(i))-(sin(Theta(i))*Yoo(i)));
        Yout(i) =floor(chromosome(i).Y+(cos(Theta(i))*Yoo(i))+(sin(Theta(i))*Xoo(i)));   
        L(i) =floor(abs(L(i)*cos(Theta(i)))+abs(sin(Theta(i))*W(i)));
        W(i) =floor(abs(W(i)*cos(Theta(i)))+abs(sin(Theta(i))*L(i)));
        %Add Car Into Map        
        Map(chromosome(i).Y-floor(W(i)/2):chromosome(i).Y+floor(W(i)/2), chromosome(i).X-floor(L(i)/2):chromosome(i).X+floor(L(i)/2)) = 0;
        %Place Input & Output
        Map(Yin(i),Xin(i)) = 1;
        Map(Yout(i),Xout(i)) = 1;

    end
    for i = 1:N
        for j = 1:N
            start = floor(sub2ind(size(Map),Yout(i),Xout(i))); 
            goal = floor(sub2ind(size(Map),Yin(j),Xin(j)));   
            costs = ones(size(Map));
            final = a_star(logical(Map), costs, start, goal);
            MHC = MHC +  f(i,j)*C(i,j)*length(final);
        %a_star_plot(logical(map), costs, final)
        end
    end
else
     MHC = 0;
end

end