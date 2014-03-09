function show_degree_mit_variants()
base_input_filename = 'variants_mit_';
output_filename = 'degree_mit_variants';
num_nodes = 46;
degrees = zeros(num_nodes, 2);
for id = [6, 7, 8, 11, 12, 14, 17, 18, 19, 20, 21, 22, 23, 24, 28, 29, 30, 31, 33, 35, 37, 39, 42, 46] % # of nodes is 20
    input_filename = strcat(base_input_filename, int2str(id)); % file name of the processed contact list to be stored
    load(input_filename);
    num_samples = size(variants,1);
    degrees(id, 1) = id;
    degrees(id, 2) = nnz(variants(:,2))/num_samples;
end
disp(degrees);
save(output_filename, 'degrees');