clear;
clc;
in_size_states = 2;
in_e_samples = 20;
in_num_sim = 1;
[out_x_coord1, out_x_coord2, out_y_final1_eff, out_y_final2_eff] = process_new_method_info_easy(in_size_states, in_e_samples, in_num_sim);
[out_x_coord1, out_x_coord3, out_y_final1_eff, out_y_final3_eff] = process_new_method_info(in_e_samples, in_num_sim);
save('info_x1', 'out_x_coord1');
save('info_y1', 'out_y_final1_eff');
save('info_x2', 'out_x_coord2');
save('info_y2', 'out_y_final2_eff');
save('info_x3', 'out_x_coord3');
save('info_y3', 'out_y_final3_eff');