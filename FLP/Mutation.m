function mutated_chromosome = Mutation(chromosome, mutation_probability)
    % Generate a random number between [0, 1]
    r = rand;
    
    % Check if the random number is less than the mutation probability
    if r < mutation_probability
        % Select a random gene to mutate
        gene_index = randi(length(chromosome));
        
        % Mutate the selected gene with a random value
        mutated_chromosome = chromosome;        
        mutated_chromosome(gene_index) = chromosome(floor(randi([1 (length(chromosome)-1)])));
    else
        % No mutation is performed
        mutated_chromosome = chromosome;
    end
end
%awesome edit
%needed============================================================
