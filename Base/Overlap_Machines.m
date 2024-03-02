function overlap_percentage = Overlap_Machines(chromosome,L,W,Lo,Wo,Xo,Yo)
ProblemX = [chromosome(1,:).X,Xo];
ProblemY = [chromosome(1,:).Y,Yo];
ProblemL=[L,Lo];
ProblemW=[W,Wo];
num_cars = size(ProblemX, 2);
for i = 1:size(chromosome, 2)
    Theta = (pi / 2) * chromosome(1,i).Orientation;
    ProblemL(i) = floor(abs(L(i) * cos(Theta)) + abs(sin(Theta) *W(i)));
    ProblemW(i) = floor(abs(W(i) * cos(Theta)) + abs(sin(Theta) *L(i)));
end
overlap_matrix = zeros(num_cars, num_cars); 

for i = 1:num_cars
    for j = i+1:num_cars
        if j <= num_cars
        car1_length = ProblemL(i);
        car1_width = ProblemW(i);
        car1_x =ProblemX(i);
        car1_y = ProblemY(i);

        car2_length = ProblemL(j);
        car2_width = ProblemW(j);
        car2_x = ProblemX(j);
        car2_y = ProblemY(j);

        car1_x1 = car1_x - car1_width/2;
        car1_x2 = car1_x + car1_width/2;
        car1_y1 = car1_y - car1_length/2;
        car1_y2 = car1_y + car1_length/2;

        car2_x1 = car2_x - car2_width/2;
        car2_x2 = car2_x + car2_width/2;
        car2_y1 = car2_y - car2_length/2;
        car2_y2 = car2_y + car2_length/2;

        if (car1_x1 <= car2_x2 && car1_x2 >= car2_x1 && car1_y1 <= car2_y2 && car1_y2 >= car2_y1) || ...
           (car2_x1 <= car1_x2 && car2_x2 >= car1_x1 && car2_y1 <= car1_y2 && car2_y2 >= car1_y1)
            overlap_matrix(i, j) = 1; 
            overlap_matrix(j, i) = 1; 
        end
        end

    end
end
total_overlaps = sum(overlap_matrix(:));
total_possible_overlaps = num_cars * (num_cars - 1) / 2;
overlap_percentage = (total_overlaps / total_possible_overlaps) * 100;