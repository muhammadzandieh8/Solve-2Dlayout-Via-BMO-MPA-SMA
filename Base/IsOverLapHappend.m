function Result = IsOverLapHappend(chromosome,MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC)
addpath(genpath('..'))
car_widths = W;
car_lengths = L;
obstacle_positionsX = XoC;
obstacle_positionsY = YoC;
obstacle_lengths = LoC;
obstacle_widths = WoC;
num_cars = MachineNumber;
Map = ones(WidthWorkshop, LengthWorkshop);
Result = false;
for v = 1:length(obstacle_positionsX)
    Map(obstacle_positionsY(v)-floor(obstacle_widths(v)/2):obstacle_positionsY(v)+floor(obstacle_widths(v)/2), obstacle_positionsX(v)-floor(obstacle_lengths(v)/2):obstacle_positionsX(v)+floor(obstacle_lengths(v)/2)) = 0;
end

for i=1:size(chromosome,2)
    if all(chromosome(i).X < LengthWorkshop && chromosome(i).X > 1  && chromosome(i).Y < WidthWorkshop && chromosome(i).Y > 1)
        if Map(chromosome(i).Y , chromosome(i).X ) == 1
            Theta = (pi / 2) * chromosome(i).Orientation;                
            newLength = floor(abs(L(i) * cos(Theta)) + abs(W(i) * sin(Theta)))+1;
            NewWidth= floor(abs(W(i) * cos(Theta)) + abs(L(i) * sin(Theta)))+1;
            if chromosome(i).Y + floor(NewWidth/2) < WidthWorkshop && chromosome(i).X + floor(newLength/2) < LengthWorkshop && chromosome(i).Y - floor(NewWidth/2) > 1 && chromosome(i).X - floor(newLength/2) > 1
                % Check if the area is clear for the car
                if all(all(Map(chromosome(i).Y - floor(NewWidth/2):chromosome(i).Y + floor(NewWidth/2), chromosome(i).X - floor(newLength/2):chromosome(i).X + floor(newLength/2)) == 1))
                    Map(chromosome(i).Y-floor(NewWidth/2):chromosome(i).Y+floor(NewWidth/2), chromosome(i).X-floor(newLength/2):chromosome(i).X+floor(newLength/2)) = 0;
                else
                    Result = true;    
                end
            else
                Result = true;    
            end
        else
            Result = true;
        end
    else
        Result = true;
    end
end
