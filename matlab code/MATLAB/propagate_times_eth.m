function [x_coord, E_eth] = propagate_times_eth()
% contact times
contact_time_eth = 1;%get_contact_time_eth();
% total number of nodes
node_num_eth = get_node_num_eth();

% feed into the function
x_coord = 1:1:node_num_eth-1;
E_eth = zeros(1, node_num_eth-1);
for d = 1:node_num_eth-1
    if d == 1
        d_temp = 1.1;
    else
        d_temp = d;
    end
    
    nd = (node_num_eth - 2) / (d_temp - 1);
    cf = 0;
    for p = 1:node_num_eth-1
       sp = node_num_eth - p - (node_num_eth - 1 - d_temp) * (1 - 1/nd)^(p-1);
       cf = cf + (node_num_eth - p)/(p * sp);
    end
    E_eth(d) = (1 / (contact_time_eth * (node_num_eth - 1))) * cf;
end