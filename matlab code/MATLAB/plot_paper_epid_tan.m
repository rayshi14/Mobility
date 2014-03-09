% draw eth
load('epid_eth_x');
load('epid_eth_y');
load('degree_eth_final');
norm_eth = size(x_eth, 2);
degree_eth_variants_avg = (sum(degrees(:,2)) / sum(degrees(:,2)~=0))/ norm_eth;
degree_eth_variants_max = max(degrees(:,2)) / norm_eth;
degree_eth_variants_min = min(degrees(:,2)) / norm_eth;
% draw info
load('epid_info_x');
load('epid_info_y');
load('degree_info_final');
norm_info = size(x_info, 2);
degree_info_variants_avg = (sum(degrees(:,2)) / sum(degrees(:,2)~=0))/ norm_info;
degree_info_variants_max = max(degrees(:,2)) / norm_info;
degree_info_variants_min = min(degrees(:,2)) / norm_info;
% draw mit
load('epid_mit_x');
load('epid_mit_y');
load('degree_mit_final');
norm_mit = size(x_mit, 2);
degree_mit_variants_avg = (sum(degrees(:,2)) / sum(degrees(:,2)~=0))/ norm_mit;
degree_mit_variants_max = max(degrees(:,2)) / norm_mit;
degree_mit_variants_min = min(degrees(:,2)) / norm_mit;
% draw hcmm
load('epid_hcmm_x');
load('epid_hcmm_y');
load('degree_hcmm_final');
norm_hcmm = size(x_hcmm, 2);
degree_hcmm_variants_avg = (sum(degrees(:,2)) / sum(degrees(:,2)~=0))/ norm_hcmm;
degree_hcmm_variants_max = max(degrees(:,2)) / norm_hcmm;
degree_hcmm_variants_min = min(degrees(:,2)) / norm_hcmm;
% draw slaw
%figure;
load('epid_slaw_x');
load('epid_slaw_y');
load('degree_slam_final');
norm_slaw = size(x_slaw, 2);
degree_slaw_variants_avg = (sum(degrees(:,2)) / sum(degrees(:,2)~=0))/ norm_slaw;
degree_slaw_variants_max = max(degrees(:,2)) / norm_slaw;
degree_slaw_variants_min = min(degrees(:,2)) / norm_slaw;
sec_eth = [0.09877 0.5591];
sec_info = [0.1013 0.2071];
sec_mit = [0.009609 1];
sec_hcmm = [0.6774 0.009066];
sec_slaw = [0.3787 0.01171];
plot(x_eth, y_eth, 'm--^', x_info, y_info, 'b-.o', x_mit, y_mit, 'k:x', x_hcmm, y_hcmm, 'g-*', x_slaw, y_slaw, 'r-');
hold on;
set(gca,'FontSize',15);
plot(sec_eth(1), sec_eth(2), 'ko', 'MarkerFaceColor','r');
lstart = [sec_eth(1) sec_eth(1) + 0.2];
lend = [sec_eth(2) sec_eth(2) + 0.05];
line(lstart,lend, 'LineStyle', '-.');
text(lstart(2)+0.01 ,lend(2)+0.01, 'ETH');

plot(sec_info(1), sec_info(2), 'ko', 'MarkerFaceColor','r');
lstart = [sec_info(1) sec_info(1) + 0.3];
lend = [sec_info(2) sec_info(2) + 0.2];
line(lstart,lend, 'LineStyle', '-.');
text(lstart(2)+0.01 ,lend(2)+0.01, 'Haggle');

plot(sec_mit(1), sec_mit(2), 'ko', 'MarkerFaceColor','r');
lstart = [sec_mit(1) sec_mit(1) + 0.3];
lend = [sec_mit(2) sec_mit(2) - 0.1];
line(lstart,lend, 'LineStyle', '-.');
text(lstart(2)+0.01 ,lend(2)+0.01, 'MIT');

plot(sec_hcmm(1), sec_hcmm(2), 'ko', 'MarkerFaceColor','r');
lstart = [sec_hcmm(1) sec_hcmm(1) + 0.1];
lend = [sec_hcmm(2) sec_hcmm(2) + 0.2];
line(lstart,lend, 'LineStyle', '-.');
text(lstart(2)+0.01 ,lend(2)+0.01, 'HCMM');

plot(sec_slaw(1), sec_slaw(2), 'ko', 'MarkerFaceColor','r');
lstart = [sec_slaw(1) sec_slaw(1) + 0.2];
lend = [sec_slaw(2) sec_slaw(2) + 0.3];
line(lstart,lend, 'LineStyle', '-.');
text(lstart(2)+0.01 ,lend(2)+0.01, 'SLAW');
% draw 45 degree tangent line
line([0 0.11],[0.11 0], 'LineStyle', ':');
line([0 0.12],[0.12 0], 'LineStyle', ':');
line([0 0.29],[0.29 0], 'LineStyle', ':');
line([0 0.42],[0.42 0], 'LineStyle', ':');

title('Message Spreading Delay');
xlabel('Contact Density')
ylabel('Delay')
legend('Epidemic-ETH','Epidemic-Haggle','Epidemic-MIT', 'Epidemic-HCMM', 'Epidemic-SLAW');

%, x_info, y_info, 'g-.o', sec_info(1), sec_info(2), 'ko', x_mit, y_mit, 'k:x', sec_mit(1), sec_mit(2), 'ko', x_hcmm, y_hcmm, 'm-*', sec_hcmm(1), sec_hcmm(2), 'ko', x_slaw, y_slaw, 'b--', sec_slaw(1), sec_slaw(2), 'ko');

%yL = get(gca,'YLim');

%line([degree_eth_variants_min degree_eth_variants_min],yL,'Color','r');

%line([degree_eth_variants_max degree_eth_variants_max],yL,'Color','r');
%line(sec_eth,yL,'Color','r');
%line(sec_info,yL,'Color','g');
%line(sec_mit,yL,'Color','k');
%line(sec_hcmm,yL,'Color','m');
%line(sec_slaw,yL,'Color','b');
%line([degree_info_variants_min degree_info_variants_min],yL,'Color','g');
%line([degree_info_variants_avg degree_info_variants_avg],yL,'Color','g');
%line([degree_info_variants_max degree_info_variants_max],yL,'Color','g');

%line([degree_mit_variants_min degree_mit_variants_min],yL,'Color','k');
%line([degree_mit_variants_avg degree_mit_variants_avg],yL,'Color','k');
%line([degree_mit_variants_max degree_mit_variants_max],yL,'Color','k');

%line([degree_hcmm_variants_min degree_hcmm_variants_min],yL,'Color','m');
%line([degree_hcmm_variants_avg degree_hcmm_variants_avg],yL,'Color','m');
%line([degree_hcmm_variants_max degree_hcmm_variants_max],yL,'Color','m');

%line([degree_slaw_variants_min degree_slaw_variants_min],yL,'Color','b');
%line([degree_slaw_variants_avg degree_slaw_variants_avg],yL,'Color','b');
%line([degree_slaw_variants_max degree_slaw_variants_max],yL,'Color','b');
