clear;
clc;
load('eth_x1');
load('eth_y1');
load('eth_x2');
load('eth_y2');
load('eth_x3');
load('eth_y3');


figure;
plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^');
set(gca,'FontSize',19);
xlim([0.05 0.5])
title('ETH trace');
xlabel('Energy Budget')
ylabel('Efficiency')
legend('Uni-Scan','CMDP-1','CMDP-2');



load('info_x1');
load('info_y1');
load('info_x2');
load('info_y2');
load('info_x3');
load('info_y3');
figure;
plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^');
set(gca,'FontSize',19);
xlim([0.05 0.5])
title('Haggle trace');
xlabel('Energy Budget')
ylabel('Efficiency')
legend('Uni-Scan','CMDP-1','CMDP-2');




load('mit_x1');
load('mit_y1');
load('mit_x2');
load('mit_y2');
load('mit_x3');
load('mit_y3');
figure;
plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^');
set(gca,'FontSize',19);
xlim([0.05 0.5])
title('MIT trace');
xlabel('Energy Budget')
ylabel('Efficiency')
legend('Uni-Scan','CMDP-1','CMDP-2');