function output=hamming(InputVector, WeightMatrix)
i=0;
%get dimensions of the weightmatrix
[w,h] = size(WeightMatrix)
%allocate output array to store hamming dist
output= zeros(1,h);

%iterates through each column vector of weightmatrix, computes hamming
%distance between inputvector and iteration's vector
for i= 1:h
    b=InputVector;
    a=WeightMatrix(:, i);
    hammingDist = @(a,b)sum( a(:)~= b(:));
    %stores hammingdist in output
    output(i)= hammingDist(a,b);
end

