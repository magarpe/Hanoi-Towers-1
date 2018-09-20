clear;

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

% actions = [[1, 2]; ...
%     [1, 3]; ...
%     [2, 3]; ...
%     [2, 1]; ...
%     [3, 1]; ...
%     [3, 2]];


function [pos_act] = posible_actions(current_st)
% pos_actions = [];

% current_st = states(:, :, 3);
init_st = find(current_st(2,:));
end_st = find(current_st(1,:)==0);
comb = combvec(init_st, end_st);
pos_act = comb(:,comb(1,:)~=comb(2,:)).';
end

function [end_st] = end_state(current_st, action)


end