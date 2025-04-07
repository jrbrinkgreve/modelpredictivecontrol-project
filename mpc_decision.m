function [x_input] = mpc_decision(X, level_vector, Ny, Nx, horizon)
tic
N = Ny * Nx;

if (N - nnz(X)) < 2 * horizon  %make sure horizon does not exceed game limits
horizon = floor((N - nnz(X)) / 2);
end


%here starts the optimizer %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Create a cell array to hold the ndgrid outputs
gridInputs = repmat({1:Nx}, 1, horizon);

% Preallocate cell array to store ndgrid outputs
inputs = cell(1, horizon);

% Call ndgrid with dynamic input
[inputs{:}] = ndgrid(gridInputs{:});

% Convert the outputs into a sequence matrix
sequences = cell2mat(cellfun(@(x) x(:), inputs, 'UniformOutput', false));

score_array = zeros(1, max(size(sequences)));



parfor counter = 1:max(size(sequences))

input_sequence = sequences(counter, :);
%counter
    score_array(counter) = calc_score(input_sequence, X, level_vector);
end
   [~, best_input_index] = max(score_array);
   best_input_sequence = sequences(best_input_index, :)
   x_input = best_input_sequence(1); %only take first input
   toc
end