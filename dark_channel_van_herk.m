function [dc, rgb_dc] = dark_channel_van_herk(I, k)
%DARK_CHANNEL_VAN HERK Calculates the dark channel usng Marcel van Herk's
% fast algorithm
%
% Metin Suloglu, 2018
% Bahcesehir University

[~, N_orig, ~] = size(I);

rgb_dc = min(I, [], 3);
dc = padarray(rgb_dc, [0, k - mod(N_orig, k)], Inf, 'post');

for l = 1:2 % Rows then columns

    [M, N] = size(dc);
    [g, h] = deal(zeros(M, N));

    for i = 1:N
        j = N + 1 - i;

        if mod(i, k) == 1
            g(:, i) = dc(:, i);
        else
            g(:, i) = min(g(:, i - 1), dc(:, i));
        end

        if mod(j, k) == 0
            h(:, j) = dc(:, j);
        else
            h(:, j) = min(h(:, j + 1), dc(:, j));
        end
    end
    offset = k - 1;

    g = padarray(g, [0, offset], Inf, 'post');
    h = padarray(h, [0, offset], Inf, 'pre');

    result = min(g, h);
    dc = result(:, offset/2 + 1:offset/2 + N_orig);

    if l == 1
        dc = dc';
        [~, N_orig] = size(dc);
        dc = padarray(dc, [0, k - mod(N_orig, k)], Inf, 'post');
    end

end

dc = dc';
