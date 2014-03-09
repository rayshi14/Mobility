function contact_time = get_contact_time_hcmm()
load model_hcmm_100_30_1.mat;
% # of nodes is 20
% format: start_time end_time node1 node2
% duplicate contact is recorded
traces = contacts;
contact_time = 0;
for i = 1:size(traces,1) % # of nodes is 20
   contact_time = contact_time + traces(i, 2) - traces(i, 1);
end
contact_time = contact_time / size(traces,1);