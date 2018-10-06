clear;
clc;

gamma = 0.9;

states = [[1; 2], zeros(2,2)];
states(:,:,2) = [[2; 1], zeros(2, 2)];
states(:,:,3) = [[zeros;2], [zeros; 1], zeros(2, 1)];
states(:,:,4) = [[zeros;2], zeros(2, 1), [zeros; 1]];

states(:,:,5) = [zeros(2, 1), [1; 2], zeros(2, 1)];
states(:,:,6) = [zeros(2, 1), [2; 1], zeros(2, 1)];
states(:,:,7) = [[zeros; 1], [zeros; 2], zeros(2, 1)];
states(:,:,8) = [zeros(2, 1), [zeros; 2], [zeros; 1]];

states(:,:,9) = [zeros(2, 2), [1; 2]];  %final
states(:,:,10) = [zeros(2, 2), [2; 1]];
states(:,:,11) = [zeros(2, 1), [zeros; 1], [zeros; 2]];
states(:,:,12) = [[zeros; 1], zeros(2, 1), [zeros; 2]];

actions = [[1, 2]; ...
    [1, 3]; ...
    [2, 3]; ...
    [2, 1]; ...
    [3, 1]; ...
    [3, 2]; ...
    [0, 0]];

% % % % Q-LEARNING % % % %

% initialization
Q = zeros(12, 7);   % quality(state, action)
Q_old = ones(12,7);
lamda = ones(12, 7);

% while Q - Q_old
    s = states(:,:,1);
    si = 1;
    pi = zeros(12,2);
    while isequal(s, states(:,:,9)) == 0
        s
        acts = posible_actions(s);
        acts = acts(randperm(size(acts,1)),:)
        Qs = acts(:,1).';
        for act = acts.'
            act = act.';
            index = which_act(act, actions);
            Qs(index) = Q(si, index);
        end
        
        [maxQ, index] = max(Qs);
        ai = which_act(acts(index,:), actions);
        pi(si,:) = actions(ai,:)
        
        [end_s, error_s] = end_state(s, pi(si,:));
        prob = rand(1);
        if prob > 0.9
            next_s = error_s;
        else
            next_s = end_s;
        end
        next_s
        r = get_reward(next_s, states);
        

        acts = posible_actions(next_s);
        Qs = acts(:,1).';
        for act = acts.'
            act = act.';
            index = which_act(act, actions);
            si_new = which_state(next_s, states);
            Qs(index) = Q(si_new, index);
        end
        maxQnew = max(Qs);
        
        Q(si, ai) = Q(si, ai) + lamda(si, ai) *(r + gamma*maxQnew - Q(si, ai));
        lamda(si, ai) = 1/(1/lamda(si, ai) +1);
        
        s = next_s;
        si = si_new;
    end
    Q_old = Q;
% end


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

function [index] = which_act(action, actions)
for i = (1:7)
    if isequal(action,actions(i,:))
        index = i;
    end
end
end

