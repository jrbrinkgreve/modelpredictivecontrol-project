function data_matrix = vector_to_matrix(data_vector, Ny, Nx)
    data_matrix = reshape(data_vector, [Ny, Nx]);
end
