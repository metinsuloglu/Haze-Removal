function g = apply_filter(img,w)

[M,N] = size(img);
[m,n] = size(w);

g = zeros(M, N);
rowRadius = floor(m/2);
columnRadius = floor(n/2);

img = padarray(img, [rowRadius, columnRadius]);

for i=1:M
   for j = 1:N
       g(i, j) = sum(sum(w.*img(i:i+m-1, j:j+n-1)));
   end
end
end

