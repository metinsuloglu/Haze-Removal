function J = radiance(I, A, t, t0)
%RADIANCE Recovers scene radiance
%
% Metin Suloglu, 2018
% Bahcesehir University

if nargin == 3
    t0 = 0.1; % Lower bound for transmission
end

A = reshape(A, 1, 1, 3);

J = (I - A) ./ max(t, t0) + A;

end

