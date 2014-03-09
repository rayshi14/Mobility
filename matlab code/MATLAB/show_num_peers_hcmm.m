function show_num_peers_hcmm()
base_input_filename = 'contacts_hcmm_';
output_file = 'num_peers_hcmm';
num_node = 100;
peers = zeros(num_node, 2);
for id = 1:num_node % # of nodes is 20
    peer_list = [];
    input_filename = strcat(base_input_filename, int2str(id)); % file name of the processed contact list to be stored
    load(input_filename);
    traces = contacts; % load the contact list into the traces
    trace_len = size(traces,1);
    for i=1:trace_len
        if ~ismember(traces(i,4), peer_list)
            peer_list = [peer_list;traces(i,4)];
        end
    end
    peers(id, 1) = id;
    peers(id, 2) = size(peer_list, 1);
end
disp(peers);
save(output_file, 'peers');