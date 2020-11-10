function [s_all] = backtracking_run(file_str)

C = readmatrix(file_str);

[i_max, j_max] = size(C);
    
i_curr = 1;
j_curr = 1;
j_next = 1;
j_vec = j_curr;

s = C(i_curr,j_curr);

count = 0;

count_limit = 2^24;

s_all = zeros(i_max, count_limit, 'uint8');

go_on_flag = true;

while go_on_flag

    s = backtracking_rec(C, i_max, j_max, s, i_curr, j_curr, j_next, j_vec);
    
    if ~any(isnan(s))
        
        count = count + 1;
        
        if mod(count, 1e5) == 0
        
            disp(' ');
            disp(num2str(s'));
            disp(num2str(count));
        
        end
        
        s_all(:,count) = s;
        
        [row,col]  = find(C == repmat(s,1,j_max));
        
        [~,sort_index] = sort(row);
        
        j_vec = col(sort_index);
        
        i_free_ind_vec = find(j_vec < 8);
        
        i_free_ind_max = i_free_ind_vec(end,1) - 1;
        
        if i_free_ind_max >= 1
        
            i_curr = i_free_ind_max;

            j_curr = j_vec(i_curr,1);

            j_next = j_vec(i_curr+1,1) + 1;

            s = s(1:i_curr);

            j_vec = j_vec(1:i_curr);
        
        else  % set new root
            
            i_curr = 1;
            
            j_curr = j_vec(i_curr,1) + 1;
            
            j_next = 1;
            
            j_vec = j_curr;
            
            s = C(i_curr,j_curr);
            
        end
        
    else
        
        disp(' ');
        disp('search complete!');
        
        go_on_flag = false;
        
    end
    
    if count == count_limit
        
        disp(' ');
        disp('count limit reached!');
        
        go_on_flag = false;
        
    end

end




