states = [[1; 2], nan(2,2)];
states(:,:,2) = [[2; 1], nan(2, 2)];
states(:,:,3) = [[nan;1], [nan; 2], nan(2, 1)];
states(:,:,4) = [[nan;1], nan(2, 1), [nan; 2]];
states(:,:,5) = [nan(2, 1), [1; 2], nan(2, 1)];
states(:,:,6) = [nan(2, 1), [2; 1], nan(2, 1)];
states(:,:,7) = [[nan; 2], [nan; 1], nan(2, 1)];
states(:,:,8) = [nan(2, 1), [nan; 1], [nan; 2]];
states(:,:,9) = [nan(2, 2), [1; 2]];
states(:,:,10) = [nan(2, 2), [2; 1]];
states(:,:,11) = [nan(2, 1), [nan; 2], [nan; 1]];
states(:,:,12) = [[nan; 2], nan(2, 1), [nan; 1]];

actions = [[1, 2], ...
    [1, 3], ...
    [2, 3], ...
    [2, 1], ...
    [3, 1], ...
    [3, 2]];

current_state = states(:, :, 1);



function posible_actions(current_state)
pos_actions = [];



end