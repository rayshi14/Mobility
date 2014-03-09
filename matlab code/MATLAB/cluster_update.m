function new_cluster = cluster_update(peer_lists, old_cluster, old_node)
num_nodes = size(peer_lists{old_node}, 2); %length
num_new_nodes = 0; % new nodes count
temp_peer_list = [];
for n = 1:num_nodes
    
end
old_cluster = [old_cluster old_node]; % horizonal adding
new_cluster = old_cluster;
if num_nodes > 0
    for n = 1:num_nodes
        if ~ismember(peer_lists{old_node}(n), new_cluster)
            new_cluster = cluster_update(peer_lists, new_cluster, peer_lists{old_node}(n));
        end
    end
else
    new_cluster = old_cluster;
end