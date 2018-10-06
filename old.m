% % % % VALUE ITERATION % % %
% 
% policy = zeros(1,12);
% utility_new = policy;
% e = 1;
% delta = 1;
% while delta >= e
%     delta = 0;
%     best_action = zeros(12,2);
%     for st = (1:12)
%         maximums = [];
%         action = [];
%         for a = posible_actions(states(:,:,st)).'
%             [end_st, error_st] = end_state(states(:,:,st), a.');
%             i = which_state(end_st, states);
%             i_error = which_state(error_st, states);
%             reward = get_reward(end_st, states);
%             reward_error = get_reward(error_st, states);
%             r = (0.9*reward + 0.1*reward_error);
%             maximum = r + gamma*(0.9* utility(i) + 0.1 *utility(i_error));
%             maximums = [maximums, maximum];
%             action = [action, a];
%         end
%         [new, i_act] = max(maximums);
%         best_action(st,:) = action(:,i_act).';
% 
%         if abs(new-utility(st)) > delta
%             delta = abs(new-utility(st));
%         end
% 
%         utility_new(st) = new;
%     end
%     utility = utility_new
%     best_action
% end
% 
% pi = best_action;


% % % % POLICY ITERATION % % %
% policy = zeros(12,2);
% utility = zeros(12,1);
% utility_new = zeros(12,1);
% utility_non_policy = zeros(12,3);
% change = 1;
% A = zeros(12,12);
% A(9,9)=1;
% B = zeros(12,1);
% 
% % initialization 
% for st = (1:12)
%     acts = posible_actions(states(:,:,st));
%     policy(st,:) = acts(1,:);
% end
% % policy = [1 2; 1 2; 1 3; 3 1; 2 1; 2 3; 2 1; 3 1; 0 0; 3 1; 2 3; 1 3]
% while change ~= 0
%     utility = zeros(12,1);
%     utility_new = zeros(12,1);
%     utility_non_policy = zeros(12,3);
%     change = 0;
%     A = zeros(12,12);
%     A(9,9)=1;
%     B = zeros(12,1);
% 
% %     for the policy
%     for st = (1:12)
%         if st~=9
%             action = policy(st,:);
%             [end_st, error_st] = end_state(states(:,:,st), action);
%             i = which_state(end_st, states);
%             i_error = which_state(error_st, states);
%             reward = get_reward(end_st, states);
%             reward_error = get_reward(error_st, states);
%             
%             r = (0.9*reward + 0.1*reward_error);
%             
%             A(st, st) = 1;
%             A(st, i) = -0.81;
%             A(st, i_error) = -0.09;
%             B(st) = r;
%         end
%     end
%     utility_new = linsolve(A,B);
%     
% %     for actions which are not the policy
%     for st = (1:12)
%         if st~=9
%             j=0;
%             for a = posible_actions(states(:,:,st)).'
%                 if isequal(a, policy(st,:).') == 0
%                     j = j+1;
%                     allactions(st, j, :) = a; 
%                     [end_st, error_st] = end_state(states(:,:,st), a.');
%                     i = which_state(end_st, states);
%                     i_error = which_state(error_st, states);
%                     reward = get_reward(end_st, states);
%                     reward_error = get_reward(error_st, states);
%                     
%                     r = (0.9*reward + 0.1*reward_error);
%                     utility_non_policy(st, j) = r + gamma*(0.9* utility_new(i) + 0.1 *utility_new(i_error));
%                 end
%             end
%         end
%     end
%         
% %     update policy
%     [M, index] = max(abs(utility_non_policy),[],2);
%     for st=1:12
%         if M(st) > utility_new(st)
%             change = 1;
%             policy(st,:) = [allactions(st, index(st),1) allactions(st, index(st),2)];
%         end
%     end
%     policy
% end
