function show_degree_eth_variants()
base_input_filename = 'variants_eth_';
output_filename = 'degree_eth_variants';
num_nodes = 20;
degrees = zeros(num_nodes, 2);
for id = 1:num_nodes % # of nodes is 20
    input_filename = strcat(base_input_filename, int2str(id)); % file name of the processed contact list to be stored
    load(input_filename);
    num_samples = size(variants,1);
    degrees(id, 1) = id;
    degrees(id, 2) = nnz(variants(:,2))/num_samples;
end
disp(degrees);
save(output_filename, 'degrees');