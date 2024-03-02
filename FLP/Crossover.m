function [child1, child2] = Crossover (parent1, parent2, crossover_probability)
    % Check if crossover should be performed
    if rand < crossover_probability
        % Select a random crossover point
        crossover_point = randi(numel(parent1));
        % Create the children by swapping the tails of the parents
        child1 = [parent1(1:crossover_point) parent2(crossover_point+1:end)];
        child2 = [parent2(1:crossover_point) parent1(crossover_point+1:end)];
    else
        % No crossover is performed
        child1 = parent1;
        child2 = parent2;
    end
end