function [s] = backtracking_rec(C, i_max, j_max, s, i_curr, j_curr, j_next, j_vec)

% s comes in correctly
% next extension to test is at i_curr+1, j_next (or, if i_curr == i_max, then return)

verbose_flag = false;

if i_curr < i_max
        
    s_ext = [s; C(i_curr + 1, j_next)];

    validity_flag = size(unique(s_ext),1) == i_curr + 1;

    if validity_flag  % successful extension

        s = s_ext;

        i_curr = i_curr + 1;

        j_curr = j_next;
        
        j_vec = [j_vec; j_next];

        j_next = 1;
        
        if verbose_flag
        
            disp(' ');
            disp(num2str(s'));
            disp('valid');
        
        end

        s = backtracking_rec(C, i_max, j_max, s, i_curr, j_curr, j_next, j_vec);

    else

        if j_next < j_max

            j_next = j_next + 1;
            
            if verbose_flag
            
                disp(' ');
                disp(num2str(s_ext'));
                disp('invalid, count j_next up');
            
            end

            s = backtracking_rec(C, i_max, j_max, s, i_curr, j_curr, j_next, j_vec);

        else  % continue here with j_vec
            
            if all(j_vec == 8*ones(size(j_vec,1),1))   % search complete
                
                s = NaN;
                
                if verbose_flag
                
                    disp(' ');
                    disp(num2str(s_ext'));
                    disp('invalid, j_vec all 8');
                
                end
                
                return;
                
            else
                
                i_free_ind_vec = find(j_vec < 8);
                
                i_free_ind_max = i_free_ind_vec(end,1);
                
                i_curr = i_free_ind_max;
                
                j_curr = j_vec(i_curr,1) + 1;
                
                s = [s(1:i_curr-1); C(i_curr,j_curr)];
                
                j_vec = [j_vec(1:i_curr-1); j_curr];
                
                j_next = 1;
                
                if verbose_flag
                
                    disp(' ');
                    disp(num2str(s_ext'));
                    disp('invalid, go back');
                
                end
                
                s = backtracking_rec(C, i_max, j_max, s, i_curr, j_curr, j_next, j_vec);
                
            end            

        end
        
    end
    
else
    
    if verbose_flag
        
        disp(' ');
        disp('all valid');
    
    end
    
    return;  % Input s already correct
    
end