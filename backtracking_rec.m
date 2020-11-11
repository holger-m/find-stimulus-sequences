function [C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s)

if size(s,1) == size(C_full,1)
    
    disp('sequence complete');
    
    return
    
end

s_last = s(end,1);

subnode_vec = C_dyn(s_last,:);

subnode_vec(:,isnan(subnode_vec)) = [];

if isempty(subnode_vec)
    
    if size(s,1) == 1
        
        disp('search complete, sequence incomplete');
        
        return;
        
    else
        
        s = s(1:end-1);
        
        restore_bin = C_full == s_last;
        
        restore_bin(s,:) = false;
        
        C_dyn(restore_bin) = s_last;
        
        [C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s);
    
    end
    
else
    
    s_ext = subnode_vec(1,1);
    
    remove_bin = C_dyn == s_ext;
    
    remove_bin(s(1:end-1,1),:) = false;
    
    C_dyn(remove_bin) = NaN;
    
    s = [s; s_ext];
    
    [C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s);
    
end
