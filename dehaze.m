function J = dehaze(I, patch_size, percentage, w, t0)
%DEHAZE Removes haze from given image
% Image must be of type double with pixel values between 0-1
%
% Metin Suloglu, 2018
% Bahcesehir University

if nargin < 5
    t0 = 0.1; % Lower bound for transmission
end
if nargin < 4
    w = 0.95; % Aerial perspective parameter
end
if nargin < 3
    percentage = 0.001; % Percentage of brightest pixels to select from
end
if nargin == 1
    patch_size = 15; % Percentage of brightest pixels to select from
end

I_dark = dark_channel(I, patch_size);
I_atmos = atmospheric_light(I, I_dark, percentage);
I_trans = transmission(I, I_atmos, patch_size, w);
J = radiance(I, I_atmos, I_trans, t0);

end

