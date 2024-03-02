function [chromosome,Result] = CreateCarLocation(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC)

addpath(genpath('..'))
chromosome = repmat(Chromosome(),1,MachineNumber);
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
%% Place cars on the map without collisions
car_locationsX = zeros(1, num_cars);
car_locationsY = zeros(1, num_cars);

for c = 1:num_cars
    [x, y,Orientation] = FindNonCollidingRandomPosition5(Map, car_widths(c), car_lengths(c));
    if x == -1 || y == -1 
        %error('Cannot place car %d without collision.', c);
        Result = true;
    else
        car_locationsX(c) = x;
        car_locationsY(c) = y;
        chromosome(c).X= x;
        chromosome(c).Y= y;
        chromosome(c).Orientation = Orientation;
        Theta = (pi / 2) * Orientation;                
        newLength = floor(abs(car_lengths(c) * cos(Theta)) + abs(car_widths(c) * sin(Theta)))+1;
        NewWidth= floor(abs(car_widths(c) * cos(Theta)) + abs(car_lengths(c) * sin(Theta)))+1;
        car_widths(c) = NewWidth;
        car_lengths(c) = newLength;
        Map(y-floor(car_widths(c)/2):y+floor(car_widths(c)/2), x-floor(car_lengths(c)/2):x+floor(car_lengths(c)/2)) = 0;
    end
end

%% Plotting the environment, cars, and obstacles
% figure;
% hold on;
% rectangle('Position', [0, 0, LengthWorkshop, WidthWorkshop], 'EdgeColor', 'k', 'LineWidth', 2);
% 
% for i = 1:num_cars
%     rectangle('Position', [car_locationsX(i) - car_lengths(i)/2, car_locationsY(i) - car_widths(i)/2, car_lengths(i), car_widths(i)], 'EdgeColor', 'y', 'LineWidth', 2);
%     text(car_locationsX(i), car_locationsY(i), num2str(i), 'Color', 'b', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold');
% end
% 
% for k = 1:num_obstacles
%     rectangle('Position', [obstacle_positionsX(k) - obstacle_lengths(k)/2, obstacle_positionsY(k) - obstacle_widths(k)/2, obstacle_lengths(k), obstacle_widths(k)], 'EdgeColor', 'r', 'LineWidth', 2);
% end
% 
% xlim([-5, LengthWorkshop+5]);
% ylim([-5, WidthWorkshop+5]);
% title('Environment with Cars and Obstacles');
% xlabel('Y');
% ylabel('X');
% hold off;
    
    
    
    
    
    
    
    
    
    
    
    
    
end