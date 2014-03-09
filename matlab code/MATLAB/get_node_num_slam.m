function node_num = get_node_num_slam()

load model_slaw_100_30.mat;
traces = contacts;
nodes = [];
for i = 1:size(traces)
    if ~ismember(traces(i, 3), nodes)
        nodes = [nodes; traces(i, 3)];
    end
    if ~ismember(traces(i, 4), nodes)
        nodes = [nodes; traces(i, 4)];
    end
end
node_num = size(nodes, 1);
