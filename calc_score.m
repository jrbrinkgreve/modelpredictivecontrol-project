function score = calc_score(input_sequence, X, level_vector)
offensive_param = 1;  %1
defensive_param = 2;  %3 or 2

%mapping from a single input sequence to a total score for this sequence.
[Ny, Nx] = size(X);
score = 0;
person_index = 1;
MPC_index = 2;

for x_input = input_sequence
U = zeros(Ny, Nx);

    if (level_vector(x_input) == 7)   %need something to deal with a board almost filling up
        score = -inf;   %infeasible moveset
        break
    else
        U(level_vector(x_input), x_input) = 1;
        U = flip(U,1);
        level_vector(x_input) = level_vector(x_input) + 1;
    end

    %next board state
    X = X + MPC_index * U;

    %evaluate state
    score = score + offensive_param * eval_board_single_state(X, MPC_index);
    score = score - defensive_param * eval_board_single_state(X, person_index);
    

    U = zeros(Ny, Nx); %reset U for person
    %do most likely player move

    
    
    
    col = most_likely_player_move(X, level_vector);
    

    U(level_vector(col), col) = 1;
        U = flip(U,1);
        level_vector(col) = level_vector(col) + 1;
    


    X = X + person_index * U;
    


    %evaluate state
    score = score + offensive_param * eval_board_single_state(X, MPC_index);     %score = score + eval_board_single_state(X, MPC_index);
    score = score - defensive_param * eval_board_single_state(X, person_index);
end

