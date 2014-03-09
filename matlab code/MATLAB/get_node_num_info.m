function node_num = get_node_num_info()

filename = 'info.txt';
% # of nodes is 20
% format: start_time end_time node1 node2
% duplicate contact is recorded
traces=importdata(filename);
nodes = [];
for i = 1:size(traces)
    if ~ismember(traces(i, 3), nodes) && traces(i, 3) < 42
        nodes = [nodes; traces(i, 3)];
    end
    if ~ismember(traces(i, 4), nodes) && traces(i, 4) < 42
        nodes = [nodes; traces(i, 4)];
    end
end
node_num = size(nodes, 1);
