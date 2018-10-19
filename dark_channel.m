function dc = dark_channel(I, patch_size)
%DARK_CHANNEL Returns dark channel of the image
% using the specified patch size
%
% Metin Suloglu, 2018
% Bahcesehir University

if nargin == 1
    patch_size = 15;
end

[M, N, ~] = size(I);
dc = zeros(M, N);

patch_radius = floor(patch_size/2);
padded = [Inf(patch_radius, N + 2*patch_radius, 3);...
    Inf(M, patch_radius, 3) I Inf(M, patch_radius, 3);...
    Inf(patch_radius, N + 2*patch_radius, 3)];

for i = 1:M
    for j = 1:N
        patch = padded(i:i+patch_size-1, j:j+patch_size-1, :);
        dc(i, j) = min(patch(:));
    end
end

end

