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

actions = [[1, 2]; ...
    [1, 3]; ...
    [2, 3]; ...
    [2, 1]; ...
    [3, 1]; ...
    [3, 2]];

states_t = states(:,:,1);
best_actions = [];

% current_st = states(:,:,1);

for i = posible_actions(states_t(:,:,end)).'
    [end_st, error_st] = end_state(states_t(:,:,end), i.')
end
    

function [pos_act] = posible_actions(current_st)
init_st = find(current_st(2,:));
end_st = find(current_st(1,:)==0);
comb = combvec(init_st, end_st);
pos_act = comb(:,comb(1,:)~=comb(2,:)).';
end

function [end_st, error_st] = end_state(current_st, action)
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
    

% (action(1,:),
% end

% value iteration


% each state, action
% mean + gamma *(sume(probability*reward))
% chose action which gives the bigest

