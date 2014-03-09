% # of nodes is 100
% format: start_time end_time node1 node2
% no duplicate contact recorded
load model_slaw_100_30.mat;
traces = contacts;
base_filename = 'contacts_slam_';
for id = 1:100 % # of nodes is 97
    contacts = []; % matrix for storing contact list for id = i
    contact_filename = strcat(base_filename, int2str(id)); % file name of the processed contact list to be stored
    for i = 1:size(traces)
        if traces(i,3) == id
            contacts = [contacts; traces(i,:)];
        elseif traces(i,4) == id
            trace = [traces(i,1), traces(i,2), traces(i,4), traces(i,3)];
            contacts = [contacts; trace];
        end
    end
    contacts = sortrows(contacts,1);
    save(contact_filename, 'contacts');
end