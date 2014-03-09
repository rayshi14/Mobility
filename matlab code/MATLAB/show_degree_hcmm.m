function show_degree_hcmm()
scanning_interval = 120; % scanning interval = 300 seconds
base_input_filename = 'contacts_hcmm_';
output_filename = 'degree_hcmm';
num_nodes = 100;
degrees = zeros(num_nodes, 2);
for id = 1:num_nodes % # of nodes is 20
    input_filename = strcat(base_input_filename, int2str(id)); % file name of the processed contact list to be stored
    load(input_filename);
    current_degree = 0; % degree of contacts of current node
    traces = contacts; % load the contact list into the traces
    end_of_contact = traces(size(traces,1),2); % time of the ending of the list
    current_time = 0; % time index of the simulation, will increase till the end of the list
    degree_count = 0;
    while current_time <= end_of_contact
        trace_len = size(traces,1);
        if trace_len > 0
            current_contacts = []; % record peer id of current contacts
            i = 1;
            % loop controlled by i
            while true
                trace_len = size(traces,1);
                if i > trace_len
                    break;
                end
                if traces(i,1) < current_time && current_time < traces(i,2)
                    current_contacts = [current_contacts, traces(i,4)]; % record the contact if there is contact during the scan
                elseif current_time < traces(i,1)
                    break; % if start time of the row is bigger than current scanning time, finish this scan
                elseif current_time > traces(i,2)
                    traces(i,:) = []; % if the end time of the row is smaller than the current scanning time, remove the row
                    i = i - 1;
                end
                i = i + 1;
            end
            % loop controlled by i
            current_degree = current_degree + size(current_contacts, 2); % average over previous average and current num of contacts
            degree_count = degree_count + 1;
        else
            break; % if traces matrix is empty, quit the loop
        end
        current_time = current_time + scanning_interval; % step through the time span
    end
    degrees(id, 1) = id;
    degrees(id, 2) = current_degree / degree_count;
end
save(output_filename, 'degrees');