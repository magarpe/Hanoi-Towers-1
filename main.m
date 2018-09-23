clear;
clc;

gamma = 0.9;

states = [[1; 2], zeros(2,2)];
states(:,:,2) = [[2; 1], zeros(2, 2)];
states(:,:,3) = [[zeros;1], [zeros; 2], zeros(2, 1)];
states(:,:,4) = [[zeros;1], zeros(2, 1), [zeros; 2]];
states(:,:,5) = [zeros(2, 1), [1; 2], zeros(2, 1)];
states(:,:,6) = [zeros(2, 1), [2; 1], zeros(2, 1)];
states(:,:,7) = [[zeros; 2], [zeros; 1], zeros(2, 1)];
states(:,:,8) = [zeros(2, 1), [zeros; 1], [zeros; 2]];
states(:,:,9) = [zeros(2, 2), [1; 2]];
states(:,:,10) = [zeros(2, 2), [2; 1]];
states(:,:,11) = [zeros(2, 1), [zeros; 2], [zeros; 1]];
states(:,:,12) = [[zeros; 2], zeros(2, 1), [zeros; 1]];

utility = zeros(1,12);
utility_new = utility;
pi = zeros(12,2);

actions = [[1, 2]; ...
    [1, 3]; ...
    [2, 3]; ...
    [2, 1]; ...
    [3, 1]; ...
    [3, 2]; ...
    [0, 0]];

e = 1;
delta = 1;
% while delta >= e
    delta = 0;
    best_action = zeros(12,2);
    for st = (1:12)
        maximums = [];
        action = [];
        for a = posible_actions(states(:,:,st)).'
            [end_st, error_st] = end_state(states(:,:,st), a.');
            i = which_state(end_st, states);
            i_error = which_state(error_st, states);
            reward = get_reward(end_st, states);
            reward_error = get_reward(error_st, states);
            r = (0.9*reward + 0.1*reward_error);
            maximum = r + gamma*(0.9* utility(i) + 0.1 *utility(i_error));
            maximums = [maximums, maximum];
            action = [action, a];
        end
        [new, i_act] = max(maximums);
        best_action(st,:) = action(:,i_act).';

        if abs(new-utility(st)) > delta
            delta = abs(new-utility(st));
        end

        utility_new(st) = new;
    end
    utility = utility_new
    best_action
% end

pi = best_action;


function [pos_act] = posible_actions(current_st)
if isequal(current_st, [zeros(2, 2), [1; 2]])
    pos_act = [0,0];
else
    init_st = find(current_st(2,:));
    end_st = find(current_st(1,:)==0);
    comb = combvec(init_st, end_st);
    pos_act = comb(:,comb(1,:)~=comb(2,:)).';
end
end

function [end_st, error_st] = end_state(current_st, action)
if isequal(action, [0,0])
    end_st = current_st;
    error_st = current_st;
else
    
    end_st = current_st;
    init = action(:,1);
    if current_st(1,init) ~= 0
        disc = end_st(1,init);
        end_st(1,init) = 0;
    else
        disc = end_st(2,init);
        end_st(2,init) = 0;
    end
    
    error_st = end_st;
    final = action(:,2);
    if final~=1 && init ~=1
        final_error = 1;
    elseif final~=2 && init ~=2
        final_error = 2;
    elseif final~=3 && init ~=3
        final_error = 3;
    end
    if current_st(1,final_error) == 0
        if current_st(2,final_error) == 0
            error_st(2,final_error) = disc;
        else
            error_st(1,final_error) = disc;
        end
    end
    
    if current_st(1,final) == 0
        if current_st(2,final) == 0
            end_st(2,final) = disc;
        else
            end_st(1,final) = disc;
        end
    end
end
end

function [reward] = get_reward(state, states)
% global states;
if isequal(state,states(:,:,9))
    reward = 100;
elseif isequal(state, states(:,:,2))|| isequal(state, states(:,:,6)) || isequal(state, states(:,:,10))
    reward = -10;
else
    reward = -1;
end
end

function [index] = which_state(state, states)
for i = (1:12)
    if isequal(state,states(:,:,i))
        index = i;
    end
end
end
