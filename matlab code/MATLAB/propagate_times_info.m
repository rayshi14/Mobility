function [x_coord, E_info] = propagate_times_info()
% contact times
contact_time_info = 1;%get_contact_time_info();
% total number of nodes
node_num_info = get_node_num_info();

% feed into the function
x_coord = 1:1:node_num_info-1;
E_info = zeros(1, node_num_info-1);
for d = 1:node_num_info-1
    if d == 1
        d_temp = 1.1;
    else
        d_temp = d;
    end
    nd = (node_num_info - 2) / (d_temp - 1);
    cf = 0;
    for p = 1:node_num_info-1
        sp = node_num_info - p - (node_num_info - 1 - d_temp) * (1 - 1/nd)^(p-1);
        cf = cf + (node_num_info - p)/(p * sp);
    end
    E_info(d) = (1 / (contact_time_info * (node_num_info - 1))) * cf;
end