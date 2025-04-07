function output_col = most_likely_player_move(X0, level_vector0)
[Ny, Nx] = size(X0);
score = zeros(1, Nx);
person_index = 1;
MPC_index = 2;
offense = 1;
defense = 2;

for col = 1:Nx
X = X0;
level_vector = level_vector0;
U = zeros(Ny, Nx);
    if (level_vector(col) >= 7)   %need something to deal with a board almost filling up
        score(col) = -inf;   %infeasible moveset
        continue;
    else
        U(level_vector(col), col) = 1;
        U = flip(U,1);
        level_vector(col) = level_vector(col) + 1;
    end

    X = X + person_index * U;
    
    score(col) = offense * eval_board_single_state(X, person_index) - defense * eval_board_single_state(X, MPC_index );
end

    [~, output_col] = max(score);  
    
 
end