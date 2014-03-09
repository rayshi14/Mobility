function [x_coord, E_hcmm] = propagate_times_hcmm()
% contact times
contact_time_hcmm = 1;%get_contact_time_hcmm();
% total number of nodes
node_num_hcmm = get_node_num_hcmm();

% feed into the function
x_coord = 1:1:node_num_hcmm-1;
E_hcmm = zeros(1, node_num_hcmm-1);
for d = 1:node_num_hcmm-1
    if d == 1
        d_temp = 1.04;
    else
        d_temp = d;
    end
    nd = (node_num_hcmm - 2) / (d_temp - 1);
    cf = 0;
    for p = 1:node_num_hcmm-1
        sp = node_num_hcmm - p - (node_num_hcmm - 1 - d_temp) * (1 - 1/nd)^(p-1);
        cf = cf + (node_num_hcmm - p)/(p * sp);
    end
    E_hcmm(d) = abs((1 / (contact_time_hcmm * (node_num_hcmm - 1))) * cf);
end