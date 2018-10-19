function [dc, rgb_dc] = dark_channel_van_herk(I, k)
%DARK_CHANNEL_VAN_HERK Calculates the dark channel using Marcel van Herk's
% fast algorithm
%
% Metin Suloglu, 2018
% Bahcesehir University

[M_orig, N_orig, ~] = size(I);
offset = (k - 1);

rgb_dc = min(I, [], 3);

% Extend columns to be a multiple of k
extended = [rgb_dc Inf(M_orig, k - mod(N_orig, k))];

for l = 1:2 % Rows then columns

    [M, N] = size(extended);
    
    %Add extra columns since g and h will be shifted 
    [g, h] = deal(Inf(M, N + offset));

    for i = 1:N
        j = N + 1 - i;

        if mod(i, k) == 1
            g(:, i) = extended(:, i);
        else
            g(:, i) = min(g(:, i - 1), extended(:, i));
        end

        if mod(j, k) == 0
            h(:, j + offset) = extended(:, j);
        else
            h(:, j + offset) = min(h(:, j + 1 + offset), extended(:, j));
        end
    end

    result = min(g, h);
    
     % Remove extra columns
    result = result(:, floor(offset/2) + 1:floor(offset/2) + N_orig);

    % Prepare to re-loop
    if l == 1
        result = result';
        [M_orig, N_orig] = size(result);
        extended = [result Inf(M_orig, k - mod(N_orig, k))];
    end

end

dc = result';
