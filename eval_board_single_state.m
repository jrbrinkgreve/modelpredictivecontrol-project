
function score = eval_board_single_state(X, player)
score = 0;


%these change the behaviour of the controller
count_parameter = 10 * [10 100 10000];

centering_parameter = 1;

gradient_parameter = 1; %gradient adds score to altering sequences which is favourable




% Get the size of the board
    [rows, cols] = size(X);
    
    % Initialize counts
    count2 = 0;
    count3 = 0;
    count4 = 0;
    
    % Check horizontal sequences
    for r = 1:rows
        for c = 1:cols-1
            seq = X(r, c:min(c+3, cols)) == player;
            [c2, c3, c4] = count_sequences(seq);
            count2 = count2 + c2;
            count3 = count3 + c3;
            count4 = count4 + c4;
        end
    end
    
    % Check vertical sequences
    for c = 1:cols
        for r = 1:rows-1
            seq = X(r:min(r+3, rows), c) == player;
            [c2, c3, c4] = count_sequences(seq);
            count2 = count2 + c2;
            count3 = count3 + c3;
            count4 = count4 + c4;
        end
    end
    
    % Check diagonal sequences (/ direction)
    for r = 1:rows-1
        for c = 1:cols-1
            seq = diag(X(r:min(r+3, rows), c:min(c+3, cols))) == player;
            [c2, c3, c4] = count_sequences(seq);
            count2 = count2 + c2;
            count3 = count3 + c3;
            count4 = count4 + c4;
        end
    end
    
    % Check diagonal sequences (\ direction)
    for r = 4:rows
        for c = 1:cols-1
            seq = diag(flipud(X(r-3:r, c:min(c+3, cols)))) == player;
            [c2, c3, c4] = count_sequences(seq);
            count2 = count2 + c2;
            count3 = count3 + c3;
            count4 = count4 + c4;
        end
    end
    
    
    
%below here space for cost function additions
    
    
%connected-pieces score
score = score + count_parameter * [count2; count3; count4];



%centering score
centering_matrix =  [2 4 6 8 10 12]' *   [1 2 3 4 3 2 1]; %just plot this thing you see its purpose
player_specific_X = X; %player-specific matrix
player_specific_X(X ~= player) = 0;
player_specific_X(X == player) = 1;
score = score + centering_parameter * sum(sum(player_specific_X .* centering_matrix));



%cross-interaction: 'putting entries in path of enemy's attack lines'
score = score + gradient_parameter * (     sum(sum(abs(diff(X, 1, 1)))) + sum(sum(abs(diff(X, 1, 2))))     );



%anything we want can go here!



%(...)











%... up to here
end





%needed for connected-pieces score
function [count2, count3, count4] = count_sequences(seq)
    count2 = sum(conv(double(seq), [1 1], 'valid') == 2);
    count3 = sum(conv(double(seq), [1 1 1], 'valid') == 3);
    count4 = sum(conv(double(seq), [1 1 1 1], 'valid') == 4);
end



%notes
%{
we have:
- forming lines-score
- blocking enemy score
- go to center-score
- (add anything!)












%}
