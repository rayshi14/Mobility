filename = 'connections.txt';
% # of nodes is 20
% format: start_time end_time node1 node2
% duplicate contact is recorded
traces=importdata(filename);
base_filename = 'contacts_eth_';
for id = 1:20 % # of nodes is 20
    contacts = []; % matrix for storing contact list for id = i
    contact_filename = strcat(base_filename, int2str(id)); % file name of the processed contact list to be stored
    for i = 1:size(traces)
        if traces(i,3) == id
            contacts = [contacts; traces(i,:)];
        end
    end
    contacts = sortrows(contacts,1);
    save(contact_filename, 'contacts');
end