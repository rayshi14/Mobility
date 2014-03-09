function contact_time = get_contact_time_slam()
load model_slaw_100_30.mat;
traces = contacts;
% # of nodes is 20
% format: start_time end_time node1 node2
% duplicate contact is recorded
contact_time = 0;
for i = 1:size(traces,1) % # of nodes is 20
   contact_time = contact_time + traces(i, 2) - traces(i, 1);
end