function victory = victory_check(X, U)

[Ny, Nx] = size(X);

%pad grid with zeros
%check 8 possibilities around last entry
% X = four in a row state
% U is last input matrix


    [Ny, Nx] = size(X);
    victory = 0;
    
    % Find the last move
    [row, col] = find(U, 1); % Get row and col where last move was made
    if isempty(row) || isempty(col)
        return;
    end
    player = X(row, col);
    
    if player == 0
        return;
    end
    
    % Check all four directions
    directions = [
        1, 0;  % Vertical
        0, 1;  % Horizontal
        1, 1;  % Diagonal (
        1, -1  % Diagonal (/)
    ];
    
    for d = 1:size(directions, 1)
        dr = directions(d, 1);
        dc = directions(d, 2);
        count = 1;
        
        % Check forward direction
        r = row + dr;
        c = col + dc;
        while r >= 1 && r <= Ny && c >= 1 && c <= Nx && X(r, c) == player
            count = count + 1;
            r = r + dr;
            c = c + dc;
        end
        
        % Check backward direction
        r = row - dr;
        c = col - dc;
        while r >= 1 && r <= Ny && c >= 1 && c <= Nx && X(r, c) == player
            count = count + 1;
            r = r - dr;
            c = c - dc;
        end
        
        % Check if four in a row is achieved
        if count >= 4 
            victory = player;
            return;
        end
    end
end



