function show_degree_exp_mit()
load('degree_mit_variants');
load('num_peers_mit');
for i=1:size(degrees, 1)
    degrees(i, 2) = degrees(i, 2) * peers(i, 2);
end
disp(degrees);
save('degree_mit_final', 'degrees');