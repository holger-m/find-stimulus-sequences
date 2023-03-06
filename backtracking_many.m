function [s_mat, scurr] = backtracking_many(N)

rng('shuffle');
scurr = rng;

%% get data

C_full_orig = readmatrix('pot_next_cond_matlab_readin.xlsx');


%% run until filled

s_mat = NaN(size(C_full_orig,1), N);

count_correct = 0;
count_failed = 0;

cont_flag = true;

while cont_flag
    
    try
        
        s = backtracking_random(C_full_orig);
        
        new_flag = true;
        
        if count_correct >= 1
            
            for s_ind = 1:count_correct
                
                s_temp = s_mat(:,s_ind);
                
                if all(s == s_temp)
                    
                    new_flag = false;
                    
                end
                
            end
            
        end
        
        if new_flag
        
            count_correct = count_correct + 1;

            s_mat(:,count_correct) = s;

            disp(['No. of completed attempts: ',num2str(count_correct), ' of ', num2str(N)]);

            if count_correct == N

                cont_flag = false;

            end
        
        else
            
            warning('Sequence discarded; double occurance!');
            
        end
        
    catch
        
        count_failed = count_failed + 1;
        
        disp(['No. of failed attempts: ',num2str(count_failed)]);
        
    end    
    
end

