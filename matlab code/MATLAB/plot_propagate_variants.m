[x_coord, E_eth] = propagate_times_eth();
% node degrees
load('degree_eth_final');
degree_eth_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_eth_variants_max = max(degrees(:,2));
degree_eth_variants_min = min(degrees(:,2));
disp(E_eth(1));
plot(x_coord, E_eth, 'b--o');
yL = get(gca,'YLim');
line([degree_eth_variants_min degree_eth_variants_min],yL,'Color','r');
line([degree_eth_variants_avg degree_eth_variants_avg],yL,'Color','r');
line([degree_eth_variants_max degree_eth_variants_max],yL,'Color','r');
% draw info
figure;
[x_coord, E_info] = propagate_times_info();
% node degrees
load('degree_info_final');
degree_info_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_info_variants_max = max(degrees(:,2));
degree_info_variants_min = min(degrees(:,2));
disp(E_info(1));
plot(x_coord, E_info, 'b--o');
yL = get(gca,'YLim');
line([degree_info_variants_min degree_info_variants_min],yL,'Color','r');
line([degree_info_variants_avg degree_info_variants_avg],yL,'Color','r');
line([degree_info_variants_max degree_info_variants_max],yL,'Color','r');
% draw mit
figure;
[x_coord, E_mit] = propagate_times_mit();
% node degrees
load('degree_mit_final');
degree_mit_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_mit_variants_max = max(degrees(:,2));
degree_mit_variants_min = min(degrees(:,2));
disp(E_mit(1));
plot(x_coord, E_mit, 'b--o');
yL = get(gca,'YLim');
line([degree_mit_variants_min degree_mit_variants_min],yL,'Color','r');
line([degree_mit_variants_avg degree_mit_variants_avg],yL,'Color','r');
line([degree_mit_variants_max degree_mit_variants_max],yL,'Color','r');
% draw hcmm
figure;
[x_coord, E_hcmm] = propagate_times_hcmm();
% node degrees
load('degree_hcmm_final');
degree_hcmm_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_hcmm_variants_max = max(degrees(:,2));
degree_hcmm_variants_min = min(degrees(:,2));
disp(E_hcmm(1));
plot(x_coord, E_hcmm, 'b--o');
yL = get(gca,'YLim');
line([degree_hcmm_variants_min degree_hcmm_variants_min],yL,'Color','r');
line([degree_hcmm_variants_avg degree_hcmm_variants_avg],yL,'Color','r');
line([degree_hcmm_variants_max degree_hcmm_variants_max],yL,'Color','r');
% draw slam
figure;
[x_coord, E_slam] = propagate_times_slam();
% node degrees
load('degree_slam_final');
degree_slam_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_slam_variants_max = max(degrees(:,2));
degree_slam_variants_min = min(degrees(:,2));
disp(E_slam(1));
plot(x_coord, E_slam, 'b--o');
yL = get(gca,'YLim');
line([degree_slam_variants_min degree_slam_variants_min],yL,'Color','r');
line([degree_slam_variants_avg degree_slam_variants_avg],yL,'Color','r');
line([degree_slam_variants_max degree_slam_variants_max],yL,'Color','r');

