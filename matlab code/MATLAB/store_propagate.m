[x_coord, E_eth] = propagate_times_eth();
% node degrees
x_eth = x_coord / max(x_coord);
y_eth = E_eth / max(E_eth);
save('epid_eth_x', 'x_eth');
save('epid_eth_y', 'y_eth');

[x_coord, E_info] = propagate_times_info();
% node degrees
x_info = x_coord / max(x_coord);
y_info = E_info / max(E_info);
save('epid_info_x', 'x_info');
save('epid_info_y', 'y_info');

[x_coord, E_mit] = propagate_times_mit();
% node degrees
x_mit = x_coord / max(x_coord);
y_mit = E_mit / max(E_mit);
save('epid_mit_x', 'x_mit');
save('epid_mit_y', 'y_mit');

[x_coord, E_hcmm] = propagate_times_hcmm();
% node degrees
x_hcmm = x_coord / max(x_coord);
y_hcmm = E_hcmm / max(E_hcmm);
save('epid_hcmm_x', 'x_hcmm');
save('epid_hcmm_y', 'y_hcmm');

[x_coord, E_slaw] = propagate_times_slam();
% node degrees
x_slaw = x_coord / max(x_coord);
y_slaw = E_slaw / max(E_slaw);
save('epid_slaw_x', 'x_slaw');
save('epid_slaw_y', 'y_slaw');
