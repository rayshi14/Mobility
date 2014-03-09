function show_degree_exp_slam()
load('degree_slam_variants');
load('num_peers_slam');
for i=1:size(degrees, 1)
    degrees(i, 2) = degrees(i, 2) * peers(i, 2);
end
disp(degrees);
save('degree_slam_final', 'degrees');