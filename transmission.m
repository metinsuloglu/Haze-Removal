function t = transmission(I, A, patch_size, w)
%TRANSMISSION Estimates the transmission map of the input image
%
% Metin Suloglu, 2018
% Bahcesehir University

if nargin < 4
    w = 0.95; % Aerial perspective parameter
end
if nargin == 2
    patch_size = 15;
end

A = reshape(A, 1, 1, 3);

img_norm = I ./ A; % Normalize each color channel
img_dc_norm = dark_channel_van_herk(img_norm, patch_size); % Dark channel of normalized image
t = 1 - w * img_dc_norm;

end

