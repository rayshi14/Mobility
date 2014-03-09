clear;
clc;
% contact times
contact_time_eth = get_contact_time_eth();
contact_time_info = get_contact_time_info();
contact_time_mit = get_contact_time_mit();
contact_time_hcmm = get_contact_time_hcmm();
contact_time_slam = get_contact_time_slam();
% node degrees
load('degree_eth');
degree_eth_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_eth_max = max(degrees(:,2));
degree_eth_min = min(degrees(:,2));
load('degree_eth_variants');
degree_eth_variants_avg = sum(degrees(:,2)) / sum(degrees(:,2)~=0);
degree_eth_variants_max = max(degrees(:,2));
degree_eth_variants_min = min(degrees(:,2));
% total number of nodes
node_num_eth = get_node_num_eth();

% feed into the function
x_coord = 1:1:node_num_eth-1;
E_eth = zeros(1, node_num_eth-1);
for d = 1:node_num_eth-1
    nd = (node_num_eth - 2) / (d - 1);
    cf = 0;
    for p = 1:node_num_eth-1
       sp = node_num_eth - p - (node_num_eth - 1 - d) * (1 - 1/nd)^(p-1);
       cf = cf + (node_num_eth - p)/(p * sp);
    end
    E_eth(d) = (1 / (contact_time_eth * (node_num_eth - 1))) * cf;
end

plot(x_coord, E_eth)