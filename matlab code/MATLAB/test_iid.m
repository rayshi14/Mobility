clear;
clc;


% plot_index = 0;
% hFig = figure(1);
% set(hFig, 'Position', [0 0 1000 800]);
%     plot_index = plot_index + 1;
%     x_coord = (0.1:0.1:1);
%     y_coord1 = zeros(1,size(x_coord,2));
%     y_coord2 = zeros(1,size(x_coord,2));
%     y_coord3 = zeros(1,size(x_coord,2));
%     index = 0;
size_actions = 100;
% all considered states are (0,0) (0,X) (X,0) (X,X)
size_states = 2;
num_tests = 6;
P_tests=zeros(size_states, size_states, 6);
P_tests(:,:,1) = [0.9 0.1;0.1 0.9];
P_tests(:,:,2) = [0.9 0.1;0.5 0.5];
P_tests(:,:,3) = [0.9 0.1;0.9 0.1];
P_tests(:,:,4) = [0.5 0.5;0.5 0.5];
P_tests(:,:,5) = [0.5 0.5;0.9 0.1];
P_tests(:,:,6) = [0.1 0.9;0.9 0.1];
x_coord1 = 0.01:0.01:1;
x_coord2 = 0.01:0.01:1;
y_coord1 = zeros(1,100);
y_coord2 = zeros(1,100);
coord_index = 1;
for e_budget = 0.01:0.01:1
    disp(e_budget);
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
    for test_index = 3:3
        % num_samples = num_samples + 1;
        action_space = zeros(1,size_actions);
        % state transition probability matrix (markov matrix)
        P = P_tests(:, :, test_index);
        % get the steady state
        % the starting event is no contact, i.e., contact = 0
        % all considered states are 1=(0,0) 2=(0,X) 3=(X,0) 4=(X,X)
        % state transition matrix is thus 4 times 4
        % current event is 1=(0,0)
        
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
                        e_yj = e_yj + 0.1;
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
        b = - 1/e_budget;
        lb = zeros(1, size_states * size_actions);
        [x,fval,exitflag,output,lambda] = linprog(f,A,b,Aeq,beq,lb);
        
        disp(fval*e_budget);
        
        %         ER_cmdp = ER_cmdp + fval;
        %
        % the optimal probability of taking action a at state y
        u=zeros(size_states, size_actions);
        for y = 1:size_states
            norm = 0;
            for a = 1:size_actions
                u(y,a) = x((y-1) * size_actions + a);
                norm = norm + u(y,a);
            end
            for a = 1:size_actions
                u(y,a) = u(y,a) / norm;
            end
        end
        disp(u);
        % compute the average idle intervals
        
        for y = 1:size_states
            avr_idle = 0;
            for a = 1:size_actions
                avr_idle = avr_idle + a*u(y,a);
            end
            if y == 1
                y_coord1(coord_index) = avr_idle;
            else
                y_coord2(coord_index) = avr_idle;
            end
        end
        
        % compute the average idle intervals
        
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
    end
    %     y_coord1(index) = ER_cmdp / num_samples;%(hit_rate_cmdp/num_scamples)/(scan_rate_cmdp/num_scamples);
    %     y_coord2(index) = ER_uni / num_samples;%(hit_rate_uniform/num_scamples)/(scan_rate_uniform/num_scamples);
    %     %y_coord3(index) = (hit_rate_adpt/num_scamples)/(scan_rate_adpt/num_scamples);
    coord_index = coord_index + 1;
end

plot(x_coord1, y_coord1, 'b--o', x_coord2, y_coord2, 'g');
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
