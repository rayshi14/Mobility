clear;
clc;

base_filename = 'variants_hcmm_';
% controlled var
size_actions = 100;
size_states = 4;
% num of energy constraint samples
e_samples = 20;
e_precision = 1/e_samples;
% controlled var

% plot_index = 0;
% hFig = figure(1);
% set(hFig, 'Position', [0 0 1000 800]);
%     plot_index = plot_index + 1;
%     x_coord = (0.1:0.1:1);
%     y_coord1 = zeros(1,size(x_coord,2));
%     y_coord2 = zeros(1,size(x_coord,2));
%     y_coord3 = zeros(1,size(x_coord,2));
%     index = 0;

% all considered states are (0,0) (0,X) (X,0) (X,X)

x_coord1 = e_precision:e_precision:1;
x_coord2 = e_precision:e_precision:1;
x_coord3 = e_precision:e_precision:1;
x_coord4 = e_precision:e_precision:1;
x_coord = e_precision:e_precision:1;
y_coord = 1./x_coord;
y_coord1 = zeros(1,e_samples);
y_coord2 = zeros(1,e_samples);
y_coord3 = zeros(1,e_samples);
y_coord4 = zeros(1,e_samples);
%         index = index + 1;
%         hit_rate_cmdp = 0;
%         scan_rate_cmdp = 0;
%         hit_rate_uniform = 0;
%         scan_rate_uniform = 0;
%         hit_rate_adpt = 0;
%         scan_rate_adpt = 0;
%         num_samples = 0;
%         ER_cmdp = 0;
%         ER_uni = 0;
for data_file = 7:7
    % num_samples = num_samples + 1;
    input_filename = strcat(base_filename, int2str(data_file));
    % actions
    action_space = zeros(1,size_actions);
    % state transition probability matrix (markov matrix)
    P = zeros(size_states);
    % get the steady state
    load(input_filename);
    % # of time samples (scans) in the contact list
    num_samples = size(variants,1);
    % # of transition from state i to state j in the matrix
    transition = zeros(size_states);
    % the starting event is no contact, i.e., contact = 0
    % all considered states are 1=(0,0) 2=(0,X) 3=(X,0) 4=(X,X)
    % states 2 and 4 are interesting states, i.e., new contacts appear
    % state transition matrix is thus 4 times 4
    % current event is 1=(0,0)
    cur_event = 1;
    for i = 1:num_samples
        event = variants(i,2);
        if event > 0 % if new contacts appear
            switch cur_event
                case 1 % from 1=(0,0) to 2=(0,X)
                    transition(1, 2) = transition(1, 2) + 1;
                    cur_event = 2;
                case 2 % from 2=(0,X) to 4=(X,X)
                    transition(2, 4) = transition(2, 4) + 1;
                    cur_event = 4;
                case 3 % from 3=(X,0) to 2=(0,X)
                    transition(3, 2) = transition(3, 2) + 1;
                    cur_event = 2;
                case 4 % from 4=(X,X) to 4=(X,X)
                    transition(4, 4) = transition(4, 4) + 1;
                    cur_event = 4;
                otherwise
            end
        else % if nothing interesting happens
            switch cur_event
                case 1 % from 1=(0,0) to 1=(0,0)
                    transition(1, 1) = transition(1, 1) + 1;
                    cur_event = 1;
                case 2 % from 2=(0,X) to 3=(X,0)
                    transition(2, 3) = transition(2, 3) + 1;
                    cur_event = 3;
                case 3 % from 3=(X,0) to 1=(0,0)
                    transition(3, 1) = transition(3, 1) + 1;
                    cur_event = 1;
                case 4 % from 4=(X,X) to 3=(X,0)
                    transition(4, 3) = transition(4, 3) + 1;
                    cur_event = 3;
                otherwise
            end
        end
    end
    
    states_share = zeros(1, size_states);
    for i = 1:size_states
        states_share(i) = sum(transition(i,:))/sum(sum(transition));
    end
    
    % cal the transition probability matrix P
    for i=1:size_states
        for j=1:size_states
            P(i,j) = transition(i,j) / sum(transition(i,:));
        end
    end
    % get the steady state
    
    % set the transition matrix with different actions (wait interval)
    Pk = zeros(size_states, size_states, size_actions);
    for i= 1:size_actions,
        action_space(i) = i;
        Pk(:,:,i) = P^i;
    end
    % set the transition matrix
    
    % the index array of the objective function
    f = zeros(size_states * size_actions, 1);
    % get the cost function c(y,a)
    % P_k_e is the array of probabilities of states transitions with k
    % the maximum
    P_k_e = zeros(1, size_states);
    % get c(y,a)
    for y = 1:size_states
        % first fix y
        for a = 1:size_actions
            % fix a
            % Pa is the transition matrix with a steps transition
            % used to compute (P^a)(y,j)
            Pa = Pk(:,:,a);
            for j = 1:size_states
                % fix j
                e_yj = 0;
                % compute the aggregate state estimation error (e^a)(y,j)
                for t = 1:a-1
                    % (P^t)(y,k)
                    Pt = Pk(:,:,t);
                    Pat = Pk(:,:,a-t);
                    % find the max probability
                    for k = 1:size_states
                        P_k_e(k) = Pt(y,k)*Pat(k,j)/Pa(y,j);
                    end
                    Pk_max = max(P_k_e);
                    % the error (e^a)(y,j)
                    e_yj = e_yj + 1 - Pk_max;
                end
                % sum over j and thus the cost c(y,a)
                f((y-1) * size_actions + a) = f((y-1) * size_actions + a) + Pa(y,j)*e_yj;
            end
        end
    end
    % get the cost function
    
    % build the LP matrix
    Aeq = zeros(size_states + 1, size_states * size_actions);
    for x = 1:size_states
        % compute the coefficient for p(y,a)
        for y = 1:size_states
            for a = 1:size_actions
                Pa = Pk(:,:,a);
                % the delta function
                if y == x
                    Aeq(x, (y-1) * size_actions + a) = 1 - Pa(y,x);
                else
                    Aeq(x, (y-1) * size_actions + a) = - Pa(y,x);
                end
            end
        end
    end
    % the last equation is = 1
    Aeq(size_states + 1,:) = ones(1, size_states * size_actions);
    beq = [zeros(size_states,1);1];
    % the inequity matrix part
    % Ax <= b
    A = zeros(1, size_states * size_actions);
    for y = 1:size_states
        for a = 1:size_actions
            A((y-1) * size_actions + a) = - a;
        end
    end
    lb = zeros(1, size_states * size_actions);
    coord_index = 1;
    for e_budget = e_precision:e_precision:1
        disp(e_budget);
        
        b = - 1/e_budget;
        
        [x,fval,exitflag,output,lambda] = linprog(f,A,b,Aeq,beq,lb);
        
        % disp(fval*e_budget);
        
        %         ER_cmdp = ER_cmdp + fval;
        %
        % the optimal probability of taking action a at state y
        decision_matrix=zeros(size_states, size_actions);
        for y = 1:size_states
            norm = 0;
            for a = 1:size_actions
                decision_matrix(y,a) = x((y-1) * size_actions + a);
                norm = norm + decision_matrix(y,a);
            end
            for a = 1:size_actions
                decision_matrix(y,a) = decision_matrix(y,a) / norm;
            end
        end
        
        % decision matrix, with each entry the idle interval under different states
        
%         % first get the # of all available events
%         num_all_events = 0;
%         for i = 1:num_samples
%             if variants(i,2) > 0
%                 num_all_events = num_all_events + 1;
%             end
%         end
%         
%         % then check how many events the algorithm gets
%         i = 1;
%         while i <= num_samples
%             cur_event = variants(i,2);
%             cur_event_action = 
%         end
%         
%         % simulate the contacts using the decision matrix
        
        % disp(u);
        % compute the average idle intervals
        
        for y = 1:size_states
            avr_idle = 0;
            for a = 1:size_actions
                avr_idle = avr_idle + a*decision_matrix(y,a);
            end
            switch y
                case 1
                    y_coord1(coord_index) = avr_idle;
                case 2
                    y_coord2(coord_index) = avr_idle;
                case 3
                    y_coord3(coord_index) = avr_idle;
                case 4
                    y_coord4(coord_index) = avr_idle;
            end
        end
        
        %         u_prob=zeros(size_states, size_actions);
        %         for y = 1:size_states
        %             for a = 1:size_actions
        %                 u_prob(y,a) = sum(u(y,1:a));
        %             end
        %         end
        %
        %
        %         sum_events = 0;
        %         sum_hits = 0;
        %         sum_scans = 0;
        %         interval = 1;
        %         for i = 1:num_samples
        %             event = variants(i,2);
        %             if event > 0
        %                 sum_events = sum_events + 1;
        %             end
        %             interval = interval - 1;
        %             if interval == 0
        %                 sum_scans = sum_scans + 1;
        %                 if event >= size_states - 1
        %                     y = size_states;
        %                     sum_hits = sum_hits + 1;
        %                 elseif event == 0
        %                     y = 1;
        %                 else
        %                     y = event + 1;
        %                     sum_hits = sum_hits + 1;
        %                 end
        %
        %                 r = rand(1);
        %                 for ua = 1:size(u_prob,2)
        %                     if r < u_prob(y,ua)
        %                         interval = ua;
        %                         break;
        %                     end
        %                 end
        %             end
        %         end
        %         hit_rate_cmdp = hit_rate_cmdp + sum_hits/sum_events;
        %         scan_rate_cmdp = scan_rate_cmdp + sum_scans/num_samples;
        %
        %
        %         %uniform
        %         I = floor(1/e_budget);
        %         miu = ceil(1/e_budget) - 1/e_budget;
        %
        %         A_uniform = zeros(size_states);
        %         P_i = Pk(:,:,I);
        %         P_i1 = Pk(:,:,I+1);
        %         for i=1:size_states
        %             for j=1:size_states
        %                 if i==j
        %                     A_uniform(i,j) = 1 - miu*P_i(j,i) - (1 - miu)*P_i1(j,i);
        %                 else
        %                     A_uniform(i,j) = - miu*P_i(j,i) - (1 - miu)*P_i1(j,i);
        %                 end
        %             end
        %         end
        %         A_uniform(size_states,:) = ones(1, size_states);
        %         b_uniform = [zeros(size_states-1,1);1];
        %         p_uniform = A_uniform \ b_uniform;
        %
        %         Er = 0;
        %         P_u_k_e = zeros(1, size_states);
        %         for i = 1:size_states
        %             for j = 1:size_states
        %                 e_ij_i = 0;
        %                 for t = 1:I-1
        %                     Pt = Pk(:,:,t);
        %                     Pat = Pk(:,:,I-t);
        %                     for k = 1:size_states
        %                         P_u_k_e(k) = Pt(i,k)*Pat(k,j)/P_i(i,j);
        %                     end
        %                     Pk_max = max(P_u_k_e);
        %                     e_ij_i = e_ij_i + 1 - Pk_max;
        %                 end
        %                 e_ij_i1 = 0;
        %                 for t = 1:I
        %                     Pt = Pk(:,:,t);
        %                     Pat = Pk(:,:,I+1-t);
        %                     for k = 1:size_states
        %                         P_u_k_e(k) = Pt(i,k)*Pat(k,j)/P_i1(i,j);
        %                     end
        %                     Pk_max = max(P_u_k_e);
        %                     e_ij_i1 = e_ij_i1 + 1 - Pk_max;
        %                 end
        %                 Er = Er + p_uniform(i) * (miu * P_i(i,j)*e_ij_i + (1 - miu)*P_i1(i,j)*e_ij_i1);
        %             end
        %         end
        %
        %         ER_uni = ER_uni + Er;
        %
        %         sum_events = 0;
        %         sum_hits = 0;
        %         sum_scans = 0;
        %         interval = floor(1/e_budget);
        %         for i = 1:num_samples
        %             event = variants(i,2);
        %             if event > 0
        %                 sum_events = sum_events + 1;
        %             end
        %             interval = interval - 1;
        %             if interval == 0
        %                 sum_scans = sum_scans + 1;
        %                 if event > 0
        %                     sum_hits = sum_hits + 1;
        %                 end
        %                 interval = floor(1/e_budget);
        %
        %             end
        %         end
        %         hit_rate_uniform = hit_rate_uniform + sum_hits/sum_events;
        %         scan_rate_uniform = scan_rate_uniform + sum_scans/num_samples;
        %
        %
        %         %additive/multiplicative
        %         sum_events = 0;
        %         sum_hits = 0;
        %         sum_scans = 0;
        %         interval = 1;
        %         cur_interval = 1;
        %         for i = 1:num_samples
        %             event = variants(i,2);
        %             if event > 0
        %                 sum_events = sum_events + 1;
        %             end
        %             interval = interval - 1;
        %             if interval == 0
        %                 sum_scans = sum_scans + 1;
        %                 if event > 0
        %                     interval = cur_interval + 1;
        %                     sum_hits = sum_hits + 1;
        %                 else
        %                     interval = max(floor(cur_interval/2),1);
        %                 end
        %                 cur_interval = interval;
        %             end
        %         end
        %         hit_rate_adpt = hit_rate_adpt + sum_hits/sum_events;
        %         scan_rate_adpt = scan_rate_adpt + sum_scans/num_samples;
        coord_index = coord_index + 1;
    end
    %     y_coord1(index) = ER_cmdp / num_samples;%(hit_rate_cmdp/num_scamples)/(scan_rate_cmdp/num_scamples);
    %     y_coord2(index) = ER_uni / num_samples;%(hit_rate_uniform/num_scamples)/(scan_rate_uniform/num_scamples);
    %     %y_coord3(index) = (hit_rate_adpt/num_scamples)/(scan_rate_adpt/num_scamples);
    plot(x_coord1, states_share(1)*y_coord1 + states_share(2)*y_coord2 + states_share(3)*y_coord3 + states_share(4)*y_coord4, 'b--o', x_coord, y_coord, 'r');
    % plot(x_coord1, y_coord1, 'b--o', x_coord2, y_coord2, 'g', x_coord3, y_coord3, 'b.', x_coord4, y_coord4, 'r', x_coord, y_coord, 'y--o');
    disp(P);
end

% sbplot = subplot(2,2,plot_index);
% %     plot(x_coord, y_coord1, '-.r*', x_coord, y_coord2, '--mo',x_coord, y_coord3, ':bs');
% plot(x_coord, y_coord1, '-.r*', x_coord, y_coord2, '--mo');
% ylim([0 0.5]);
% hleg1 = legend('CMDP','uniform');
% %     hleg1 = legend('CMDP','uniform','additive/multiplicative');
% xlabel('energy budget');
% ylabel('E[R]');
% %     ylabel('efficiency(captured events/energy consumption)');
% text = strcat('ETH trace, number of states:', num2str(size_states));
% title(text);
