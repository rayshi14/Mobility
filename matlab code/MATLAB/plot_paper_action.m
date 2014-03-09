clear;
clc;
load('eth_action_x1');
load('eth_action_y1');
load('eth_action_x2');
load('eth_action_y2');

y_coord_cmdp2 = y_coord_action;

load('eth_easy_action_x1');
load('eth_easy_action_y1');
load('eth_easy_action_x2');
load('eth_easy_action_y2');
y_coord_cmdp1 = y_coord_action;

figure;
plot(x_coord, y_coord, 'b--o', x_coord, y_coord_cmdp1, 'g-*', x_coord, y_coord_cmdp2, 'r:^');
set(gca,'FontSize',19);
title('ETH Trace');
xlabel('Energy Budget')
ylabel('Probe Interval')
legend('Uni-Scan','CMDP-1', 'CMDP-2');

load('info_action_x1');
load('info_action_y1');
load('info_action_x2');
load('info_action_y2');

y_coord_cmdp2 = y_coord_action;

load('info_easy_action_x1');
load('info_easy_action_y1');
load('info_easy_action_x2');
load('info_easy_action_y2');
y_coord_cmdp1 = y_coord_action;

figure;
plot(x_coord, y_coord, 'b--o', x_coord, y_coord_cmdp1, 'g-*', x_coord, y_coord_cmdp2, 'r:^');
set(gca,'FontSize',19);
title('Haggle Trace');
xlabel('Energy Budget')
ylabel('Probe Interval')
legend('Uni-Scan','CMDP-1', 'CMDP-2');

load('mit_action_x1');
load('mit_action_y1');
load('mit_action_x2');
load('mit_action_y2');

y_coord_cmdp2 = y_coord_action;

load('mit_easy_action_x1');
load('mit_easy_action_y1');
load('mit_easy_action_x2');
load('mit_easy_action_y2');
y_coord_cmdp1 = y_coord_action;

figure;
plot(x_coord, y_coord, 'b--o', x_coord, y_coord_cmdp1, 'g-*', x_coord, y_coord_cmdp2, 'r:^');
set(gca,'FontSize',19);
title('MIT Trace');
xlabel('Energy Budget')
ylabel('Probe Interval')
legend('Uni-Scan','CMDP-1', 'CMDP-2');



