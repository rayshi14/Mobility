function contact_time = get_contact_time_eth()
filename = 'connections.txt';
% # of nodes is 20
% format: start_time end_time node1 node2
% duplicate contact is recorded
traces=importdata(filename);
contact_time = 0;
for i = 1:size(traces,1) % # of nodes is 20
   contact_time = contact_time + traces(i, 2) - traces(i, 1);
end
contact_time = contact_time / size(traces,1);