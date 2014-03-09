function show_degree_exp_hcmm()
load('degree_hcmm_variants');
load('num_peers_hcmm');
for i=1:size(degrees, 1)
    degrees(i, 2) = degrees(i, 2) * peers(i, 2);
end
disp(degrees);
save('degree_hcmm_final', 'degrees');