function A = atmospheric_light(I, dc, percentage)
%ESTIMATE_AIRLIGHT Estimates airlight from the given image and dark channel
%Brightest pixels from the dark channel are selected
% and pixel values with highest intensity (euclidian norm)
% in hazy image returned as atmospheric light
%
% Metin Suloglu, 2018
% Bahcesehir University

assert(size(I, 1) == size(dc, 1) & size(I, 2) == size(dc, 2),... 
    "Image sizes must be equal");

if nargin == 2
    percentage = 0.001;
end

[M, N, C] = size(I);
n_pixels = M * N;
dc = dc(:);
I = reshape(I, [n_pixels, 1, 3]);

k = ceil(n_pixels * percentage);

[~, indeces] = sort(dc(:), 'descend');
img_sub = zeros(1, k, C);
for rgb = 1:C
    I_rgb = I(:, :, rgb);
    img_sub(:, :, rgb) = I_rgb(indeces(1:k));
end

[~, max_index] = max(vecnorm(img_sub, 2, 3));

A = img_sub(1, max_index, :);

end

