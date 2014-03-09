function [x_coord, E_mit] = propagate_times_mit()
% contact times
contact_time_mit = 1;%get_contact_time_mit();
% total number of nodes
node_num_mit = get_node_num_mit();

% feed into the function
x_coord = 1:1:node_num_mit-1;
E_mit = zeros(1, node_num_mit-1);
for d = 1:node_num_mit-1
    if d == 1
        d_temp = 1.05;
    else
        d_temp = d;
    end
    nd = (node_num_mit - 2) / (d_temp - 1);
    cf = 0;
    for p = 1:node_num_mit-1
        sp = node_num_mit - p - (node_num_mit - 1 - d_temp) * (1 - 1/nd)^(p-1);
        cf = cf + (node_num_mit - p)/(p * sp);
    end
    E_mit(d) = (1 / (contact_time_mit * (node_num_mit - 1))) * cf;
end