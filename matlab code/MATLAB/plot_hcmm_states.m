clear;
clc;
in_size_states = 2;
in_e_samples = 20;
in_num_sim = 1;
[out_x_coord1, out_x_coord2, out_y_final1_eff, out_y_final2_eff] = process_new_method_hcmm_easy(in_size_states, in_e_samples, in_num_sim);
[out_x_coord1, out_x_coord3, out_y_final1_eff, out_y_final3_eff] = process_new_method_hcmm_easy(in_size_states, in_e_samples, in_num_sim);
[out_x_coord1, out_x_coord4, out_y_final1_eff, out_y_final4_eff] = process_new_method_hcmm_easy(in_size_states, in_e_samples, in_num_sim);

plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^', out_x_coord3, out_y_final3_eff, 'b-d');
xlabel('Energy Budget')
ylabel('Scan Efficiency')
legend('Uni-Scan','CMDP-1(2 states)','CMDP-1(3 states)','CMDP-1(4 states)');
