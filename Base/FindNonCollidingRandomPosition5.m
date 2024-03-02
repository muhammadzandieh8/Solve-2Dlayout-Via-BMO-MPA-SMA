function [x, y, Orientation] = FindNonCollidingRandomPosition5(Map, width, length)
    [rows, cols] = size(Map);
    valid_positions = [];
    Orientation = randi([0, 3], 1, 1);
    Theta = (pi / 2) * Orientation;
    newLength = floor(abs(length * cos(Theta)) + abs(width * sin(Theta)))+2;
    NewWidth = floor(abs(width * cos(Theta)) + abs(length * sin(Theta)))+2;
    
    for i = 1:rows
        for j = 1:cols
            if Map(i, j) == 1
                if i + ceil(NewWidth/2) < rows && j + ceil(newLength/2) < cols && i - ceil(NewWidth/2) > 1 && j - ceil(newLength/2) > 1
                    % Check if the area is clear for the car
                    if all(all(Map(i - ceil(NewWidth/2):i + ceil(NewWidth/2), j - ceil(newLength/2):j + ceil(newLength/2)) == 1))
                        valid_positions = [valid_positions; j, i, Orientation];
                    end
                end
            end
        end
    end
    
    [num_valid_positions, ~] = size(valid_positions);
    
    if num_valid_positions > 0
        random_index = randi(num_valid_positions);
        x = valid_positions(random_index, 1);
        y = valid_positions(random_index, 2);
        Orientation = valid_positions(random_index, 3);
    else
        x = -1;
        y = -1;
    end
end
