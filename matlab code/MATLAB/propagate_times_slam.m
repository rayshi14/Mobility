function [x_coord, E_slam] = propagate_times_slam()
% contact times
contact_time_slam = 1;%get_contact_time_slam();
% total number of nodes
node_num_slam = get_node_num_slam();

% feed into the function
x_coord = 1:1:node_num_slam-1;
E_slam = zeros(1, node_num_slam-1);
for d = 1:node_num_slam-1
    if d == 1
        d_temp = 1.04;
    else
        d_temp = d;
    end
    nd = (node_num_slam - 2) / (d_temp - 1);
    cf = 0;
    for p = 1:node_num_slam-1
        sp = node_num_slam - p - (node_num_slam - 1 - d_temp) * (1 - 1/nd)^(p-1);
        cf = cf + (node_num_slam - p)/(p * sp);
    end
    E_slam(d) = abs((1 / (contact_time_slam * (node_num_slam - 1))) * cf);
end