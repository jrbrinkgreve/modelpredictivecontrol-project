%the main game 
player = 1; %player 1 / 2 is MPC
victory = 0;
Nx = 7;
Ny = 6;
N = Ny * Nx;
level_vector = ones(Nx, 1);  %gives the available values / indices for u
X = zeros(Ny, Nx);   %state matrix for visualisation
horizon = 4; %MPC horizon, complexity follows 


close all



while victory == 0

U = zeros(Ny, Nx); %input matrix for visualisation



[xgrid, ygrid] = meshgrid(1:Nx, 1:Ny); %create grid coordinates

scatter(xgrid(:), ygrid(:), 2000, X(:), 'filled'); %plot circles, size 2000
colormap(jet); %colormap

axis equal;
set(gca, 'XTick', 1:Nx, 'YTick', 1:Ny, 'YDir', 'reverse', 'FontSize', 16); % Keep grid structure



if player == 2
    x_input = mpc_decision(X, level_vector, Ny, Nx, horizon); %MPC
else
    prompt = "Enter Column";
    x_input = input(prompt);
    while level_vector(x_input) == 7
        disp('col full, try another!')
        x_input = input(prompt);
    end
end



U(level_vector(x_input), x_input) = 1;
U = flip(U,1);
u = matrix_to_vector(U);  % control vector, to be calculated
level_vector(x_input) = level_vector(x_input) + 1;

X = X + player * U;


disp(X)



[xgrid, ygrid] = meshgrid(1:Nx, 1:Ny); %create grid coordinates
scatter(xgrid(:), ygrid(:), 2000, X(:), 'filled'); %plot circles, size 2000
colormap(jet); %colormap

axis equal;
set(gca, 'XTick', 1:Nx, 'YTick', 1:Ny, 'YDir', 'reverse', 'FontSize', 16);



victory = victory_check(X, U); %victory checking
if victory ~= 0
    disp(['Player ', num2str(victory), ' has won!'])
end



%player swapping
    if(player == 1)
    player = 2;
    
    elseif (player == 2)
    player = 1;
    end




end 

% NOTES

