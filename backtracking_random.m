function [s] = backtracking_random(C_full_orig)

%% set i_root and C_full at random

i_root = randi(size(C_full_orig,1));

C_full = NaN(size(C_full_orig));

for i = 1:size(C_full_orig,1)
    
    permvec = randperm(size(C_full_orig,2));
    
    C_temp = C_full_orig(i,:);
    
    C_rand = C_temp(:,permvec);
    
    C_full(i,:) = C_rand;
    
end

clear i
clear permvec
clear C_temp
clear C_rand


%% initialize recursion

C_dyn = C_full;

s = i_root;

C_dyn(C_dyn == s) = NaN;

% state: valid sequence s and C_dyn with NaNs

[~, ~, s] = backtracking_rec(C_full, C_dyn, s);


%% sanity checks

if size(unique(s),1) ~= size(C_full_orig,1)
    
    error('Something has gone horribly wrong!');
    
end

if s(1,1) ~= i_root
    
    error('Something has gone horribly wrong!');
    
end

for i = 2:size(C_full_orig,1)
    
    s_last = s(i-1,1);
    
    s_curr = s(i,1);
    
    subnode_vec = C_full_orig(s_last,:);
    
    if all(subnode_vec ~= s_curr)
        
        error('Something has gone horribly wrong!');
    
    end
    
end