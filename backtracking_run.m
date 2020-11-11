function [C_full, C_dyn, s] = backtracking_run(i_root)

C_full = readmatrix('pot_next_cond_matlab_readin.xlsx');
%C_full = readmatrix('test_table.xlsx');

C_dyn = C_full;

s = i_root;

C_dyn(C_dyn == s) = NaN;

% state: valid sequence s and C_dyn with NaNs

[C_full, C_dyn, s] = backtracking_rec(C_full, C_dyn, s);

