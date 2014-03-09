function show_degree_exp_eth()
load('degree_eth_variants');
load('num_peers_eth');
for i=1:size(degrees, 1)
    degrees(i, 2) = degrees(i, 2) * peers(i, 2);
end
disp(degrees);
save('degree_eth_final', 'degrees');