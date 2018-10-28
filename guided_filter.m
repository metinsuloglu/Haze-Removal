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

