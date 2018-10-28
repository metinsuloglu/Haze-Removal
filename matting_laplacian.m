function L = matting_laplacian(I, win_size, epsilon)
%MATTING_LAPLACIAN Computes the matting laplacian matrix for an RGB image I
%
% Metin Suloglu, 2018
% Bahcesehir University

if nargin < 3
    epsilon = 1e-7;
end
if nargin == 1
    win_size = 3;
end

[M, N, ~] = size(I);
img_size = M * N;

% Store linear indices of image to access from window
img_indices = reshape(1:img_size, M, N);

% These will be used to create the sparse matrix L
row_indices = zeros(win_size ^ 2 * img_size, 1);
column_indices = zeros(win_size ^ 2 * img_size, 1);
values = zeros(win_size ^ 2 * img_size, 1);
s_len = 0;

win_radius = (win_size - 1) / 2;
U = eye(3);

f = waitbar(0, 'Computing the matting Laplacian matrix...');

for k = 1:img_size
    
    [rk, ck] = ind2sub([M, N], k);
    
    % Lower and upper corners of window
    [lrw_k, lcw_k, urw_k, ucw_k] = deal(max(1, rk - win_radius),...
        max(1, ck - win_radius), min(M, rk + win_radius),...
        min(N, ck + win_radius));
    
    % Window k of image I
    w_k = I(lrw_k:urw_k, lcw_k:ucw_k, :);
    
    win_indices = img_indices(lrw_k:urw_k, lcw_k:ucw_k);
    [Mw, Nw, ~] = size(w_k);
    n_pixels = Mw * Nw;
    extent = n_pixels ^ 2;
    w_k = reshape(w_k, n_pixels, 3);
    
    mu_k = mean(w_k, 1);
    Sigma_k = cov(w_k, 1);
    
    w_k = w_k - mu_k;
    
    L_ij = (1 + w_k * ((Sigma_k + epsilon / n_pixels * U) \ w_k')) / n_pixels;
    
    win_indices = repmat(win_indices(:), 1, n_pixels);
    row_indices(s_len + 1:s_len + extent) = win_indices(:);
    win_indices = win_indices';
    column_indices(s_len + 1:s_len + extent) = win_indices(:);
    values(s_len + 1:s_len + extent) = L_ij(:);
    
    s_len = s_len + n_pixels ^ 2;
    
    waitbar(k * 0.95 / img_size);
    
end

% Create sparse matrix L
% Row i of L sums up to the number of pixels in window k when k = i
L = sparse(row_indices(1:s_len), column_indices(1:s_len),...
    values(1:s_len), img_size, img_size);
% Negate all elements, add to L(i, i) the number of pixels in window k = i
L = spdiags(sum(L, 2), 0, img_size , img_size) - L;

waitbar(1);
close(f);

end

