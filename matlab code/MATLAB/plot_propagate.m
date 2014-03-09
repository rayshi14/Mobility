[x_coord, E_eth] = propagate_times_eth();
% node degrees
load('degree_eth');
degree_eth_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_eth_max = max(degrees(:,2));
degree_eth_min = min(degrees(:,2));
load('degree_eth_variants');
degree_eth_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_eth_variants_max = max(degrees(:,2));
degree_eth_variants_min = min(degrees(:,2));
disp(E_eth(1));
plot(x_coord, E_eth, 'b--o');
yL = get(gca,'YLim');
line([degree_eth_min degree_eth_min],yL,'Color','r');
line([degree_eth_avg degree_eth_avg],yL,'Color','r');
line([degree_eth_max degree_eth_max],yL,'Color','r');
% draw info
figure;
[x_coord, E_info] = propagate_times_info();
% node degrees
load('degree_info');
degree_info_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_info_max = max(degrees(:,2));
degree_info_min = min(degrees(:,2));
load('degree_info_variants');
degree_info_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_info_variants_max = max(degrees(:,2));
degree_info_variants_min = min(degrees(:,2));
disp(E_info(1));
plot(x_coord, E_info, 'b--o');
yL = get(gca,'YLim');
line([degree_info_min degree_info_min],yL,'Color','r');
line([degree_info_avg degree_info_avg],yL,'Color','r');
line([degree_info_max degree_info_max],yL,'Color','r');
% draw mit
figure;
[x_coord, E_mit] = propagate_times_mit();
% node degrees
load('degree_mit');
degree_mit_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_mit_max = max(degrees(:,2));
degree_mit_min = min(degrees(:,2));
load('degree_mit_variants');
degree_mit_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_mit_variants_max = max(degrees(:,2));
degree_mit_variants_min = min(degrees(:,2));
disp(E_mit(1));
plot(x_coord, E_mit, 'b--o');
yL = get(gca,'YLim');
line([degree_mit_min degree_mit_min],yL,'Color','r');
line([degree_mit_avg degree_mit_avg],yL,'Color','r');
line([degree_mit_max degree_mit_max],yL,'Color','r');
% draw hcmm
figure;
[x_coord, E_hcmm] = propagate_times_hcmm();
% node degrees
load('degree_hcmm');
degree_hcmm_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_hcmm_max = max(degrees(:,2));
degree_hcmm_min = min(degrees(:,2));
load('degree_hcmm_variants');
degree_hcmm_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_hcmm_variants_max = max(degrees(:,2));
degree_hcmm_variants_min = min(degrees(:,2));
disp(E_hcmm(1));
plot(x_coord, E_hcmm, 'b--o');
yL = get(gca,'YLim');
line([degree_hcmm_min degree_hcmm_min],yL,'Color','r');
line([degree_hcmm_avg degree_hcmm_avg],yL,'Color','r');
line([degree_hcmm_max degree_hcmm_max],yL,'Color','r');
% draw slam
figure;
[x_coord, E_slam] = propagate_times_slam();
% node degrees
load('degree_slam');
degree_slam_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_slam_max = max(degrees(:,2));
degree_slam_min = min(degrees(:,2));
load('degree_slam_variants');
degree_slam_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_slam_variants_max = max(degrees(:,2));
degree_slam_variants_min = min(degrees(:,2));
disp(E_slam(1));
plot(x_coord, E_slam, 'b--o');
yL = get(gca,'YLim');
line([degree_slam_min degree_slam_min],yL,'Color','r');
line([degree_slam_avg degree_slam_avg],yL,'Color','r');
line([degree_slam_max degree_slam_max],yL,'Color','r');

