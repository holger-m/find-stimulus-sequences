function [C_full, C_dyn, s] = backtracking_run(i_root)

C_full = readmatrix('pot_next_cond_matlab_readin.xlsx');
%C_full = readmatrix('test_table.xlsx');

C_dyn = C_full;

s = i_root;

C_dyn(C_dyn == s) = NaN;

% state: valid sequence s and C_dyn with NaNs

[C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s);


%% sanity checks

if size(unique(s),1) ~= size(C_full,1)
    
    error('Something has gone horribly wrong!');
    
end

if s(1,1) ~= i_root
    
    error('Something has gone horribly wrong!');
    
end

for i = 2:size(C_full,1)
    
    s_last = s(i-1,1);
    
    s_curr = s(i,1);
    
    subnode_vec = C_full(s_last,:);
    
    if all(subnode_vec ~= s_curr)
        
        error('Something has gone horribly wrong!');
    
    end
    
end

