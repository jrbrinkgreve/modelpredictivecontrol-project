function data_vector = matrix_to_vector(data_matrix)



data_vector = reshape(data_matrix, [numel(data_matrix),1]);
end