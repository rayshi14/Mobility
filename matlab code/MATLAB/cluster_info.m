function [clusters, cluster_count] = cluster_info()
% find the clusters of the node (connected node clusters)
base_input_filename = 'contacts_haggle_';
%output_file = 'peer_list_eth';
num_node = 41;
peer_lists = cell(num_node, 1);
% get peer list
for id = 1:num_node % # of nodes is 20
    peer_list = [];
    input_filename = strcat(base_input_filename, int2str(id)); % file name of the processed contact list to be stored
    load(input_filename);
    traces = contacts; % load the contact list into the traces
    trace_len = size(traces,1);
    for i=1:trace_len
        if ~ismember(traces(i,4), peer_list) && traces(i,4) < 42
            peer_list = [peer_list traces(i,4)];
        end
    end
    peer_lists{id} = peer_list;
end
cluster_count = 0;
clusters = cell(num_node, 1);
for id = 1:num_node
    new_cluster = true;
    for c = 1:cluster_count
        if ismember(id, clusters{c})
            % existing cluster
            if new_cluster
                new_cluster = false;
            else
                disp('error');
            end
        end
    end
    if new_cluster % it is a new cluster
        cluster_count = cluster_count + 1;
        clusters{cluster_count} = cluster_update(peer_lists, [], id);
    end
end
%save(output_file, 'peers');