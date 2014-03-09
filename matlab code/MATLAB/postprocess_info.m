scanning_interval = 120; % scanning interval = 300 seconds
base_input_filename = 'contacts_haggle_';
base_output_filename = 'variants_haggle_';
for id = 1:30 % # of nodes is 20
    input_filename = strcat(base_input_filename, int2str(id)); % file name of the processed contact list to be stored
    load(input_filename);
    traces = contacts; % load the contact list into the traces
    current_time = 20000; % time index of the simulation, will increase till the end of the list
    end_of_contact = traces(size(traces,1),2); % time of the ending of the list
    previous_contacts = []; % record peer id of previous contacts
    % mat used to store the variants of the contacts
    variants = [];
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
        else
            break; % if traces matrix is empty, quit the loop
        end
        
        % find new contacts in the current_contacts list
        new_contact = [];
        current_contacts_num = size(current_contacts, 2);
        previous_contacts_num = size(previous_contacts, 2);
        if current_contacts_num > 0
            % loop controlled by j
            if previous_contacts_num > 0
                for j = 1:current_contacts_num
                    for k = 1:previous_contacts_num
                        if current_contacts(j) == previous_contacts(k)
                            break;
                        end
                        if k == previous_contacts_num
                            new_contact = [new_contact, current_contacts(j)];
                        end
                    end
                end
            else
                new_contact = current_contacts;
            end
        end
        variants = [variants;[current_time, size(new_contact, 2)]];
        previous_contacts = current_contacts;
        current_time = current_time + scanning_interval; % step through the time span
    end
    output_file = strcat(base_output_filename, int2str(id)); % filename to output the variants
    save(output_file, 'variants');
end