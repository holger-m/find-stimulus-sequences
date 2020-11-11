function [C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s)

if size(s,1) == size(C_full,1)
    
    disp('sequence complete');
    
    return
    
end

s_last = s(end,1);

subnode_vec = C_dyn(s_last,:);

subnode_vec(:,isnan(subnode_vec)) = [];

if isempty(subnode_vec)   

    s = s(1:end-1);
    
    if isempty(s)
        
        disp('search complete, sequence incomplete');
        
        return;
        
    else
        
        C_dyn(C_full == s_last) = s_last;

        C_dyn(s(end,1), C_dyn(s(end,1),:) == s_last) = NaN;
        
        [C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s);
    
    end
    
else
    
    s_ext = subnode_vec(1,1);
    
    C_dyn(C_dyn == s_ext) = NaN;
    
    s = [s; s_ext];
    
    [C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s);
    
end
