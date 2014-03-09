load('info_x1');
load('info_y1');
load('info_x2');
load('info_y2');
load('info_x3');
load('info_y3');

plot(out_x_coord1, out_y_final1_eff, 'b--o', out_x_coord2, out_y_final2_eff, 'g-*', out_x_coord3, out_y_final3_eff, 'r:^');
xlabel('Energy Constraint')
ylabel('Scan Efficiency')
legend('Uni-Scan','CMDP-1','CMDP-2');