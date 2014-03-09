function show_degree_exp_info()
load('degree_info_variants');
load('num_peers_info');
for i=1:size(degrees, 1)
    degrees(i, 2) = degrees(i, 2) * peers(i, 2);
end
disp(degrees);
save('degree_info_final', 'degrees');