function q = guided_filter(I, p, r, epsilon)
%GUIDED_FILTER Computes guided filter q of p with respect to guidance image I
% Algorithm taken from the paper titled "Fast Guided Filter" by He et al.
% 
% Metin Suloglu, 2018
% Bahcesehir University

mu_I = box_filter(I, r);
mu_p = box_filter(p, r);
corr_I = box_filter(I .* I, r);
corr_Ip = box_filter(I .* p, r);

var_I = corr_I - mu_I .* mu_I;
cov_Ip = corr_Ip - mu_I .* mu_p;

a = cov_Ip ./ (var_I + epsilon);
b = mu_p - a .* mu_I;

mu_a = box_filter(a, r);
mu_b = box_filter(b, r);

q = mu_a .* I + mu_b;

end

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

