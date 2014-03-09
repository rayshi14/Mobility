clear;
clc;
load('eth_states_x0');
load('eth_states_y0');
load('eth_states_x1');
load('eth_states_y1');
load('eth_states_x2');
load('eth_states_y2');
load('eth_states_x3');
load('eth_states_y3');

figure;
plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^', out_x_coord3, out_y_final3_eff, 'b-d');
xlim([0.05 0.5])
title('ETH Trace');
xlabel('Energy Budget')
ylabel('Scan Efficiency')
legend('Uni-Scan','CMDP-1(2 states)','CMDP-1(3 states)','CMDP-1(4 states)');



load('info_states_x0');
load('info_states_y0');
load('info_states_x1');
load('info_states_y1');
load('info_states_x2');
load('info_states_y2');
load('info_states_x3');
load('info_states_y3');

figure;
plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^', out_x_coord3, out_y_final3_eff, 'b-d');
xlim([0.05 0.5])
title('Haggle Trace')
xlabel('Energy Budget')
ylabel('Scan Efficiency')
legend('Uni-Scan','CMDP-1(2 states)','CMDP-1(3 states)','CMDP-1(4 states)');



load('mit_states_x0');
load('mit_states_y0');
load('mit_states_x1');
load('mit_states_y1');
load('mit_states_x2');
load('mit_states_y2');
load('mit_states_x3');
load('mit_states_y3');
figure;
plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^', out_x_coord3, out_y_final3_eff, 'b-d');
xlim([0.05 0.5])
title('MIT Trace');
xlabel('Energy Budget')
ylabel('Scan Efficiency')
legend('Uni-Scan','CMDP-1(2 states)','CMDP-1(3 states)','CMDP-1(4 states)');