%Uses hamming distance to evaluate which of the centroids in the passed
%centroid matrix is closest the the input vector.
%This function returns the centroid closest to the input vector.
function output=HammingMax(centroidMatrix, inputVector)
    %Use hamming network to get the hamming distance between each centroid
    %and the input vector
    hammingVect = hamming(inputVector, centroidMatrix);
    
    %Find the index of the closest centroid
    maxIndex = maxNet(hammingVect);
    
    %set output to be the centroid that was closest
    output = centroidMatrix(:, maxIndex);
end