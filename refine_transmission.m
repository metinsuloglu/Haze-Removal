function t = refine_transmission(I, t_tilde, lambda)
%REFINE_TRANSMISSION Calculate the matting Laplacian matrix and
% apply soft matting to improve the transmission map
%
% Metin Suloglu, 2018
% Bahcesehir University

epsilon = 1e-7;
win_size = 3;

[M, N, ~] = size(I);

L = matting_laplacian(I, win_size, epsilon);
t = reshape(((L + lambda * speye(size(L))) \ (lambda * t_tilde(:))), M, N);

end