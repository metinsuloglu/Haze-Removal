function g = box_filter(I, r)
%BOX_FILTER Applies the box filter on matrix I
%
% Metin Suloglu, 2018
% Bahcesehir University

[M, N] = size(I);
g = zeros(M, N);
w_size = 2 * r + 1;
w = ones(w_size) / (w_size ^ 2);

I_pad = [repmat(I(1, :), r, 1); I; repmat(I(end, :), r, 1)];
I_pad = [repmat(I_pad(:, 1), 1, r) I_pad repmat(I_pad(:, end), 1, r)];

for i=1:M
   for j = 1:N
       g(i, j) = sum(sum(w .* I_pad(i:i + w_size - 1, j:j + w_size - 1)));
   end
end

end

