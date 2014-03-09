load('slam_x1');
load('slam_y1');
load('slam_x2');
load('slam_y2');
load('slam_x3');
load('slam_y3');
plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^');
xlabel('Energy Budget')
ylabel('Scan Efficiency')
legend('Uni-Scan','CMDP-1','CMDP-2');