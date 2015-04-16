%Constructs a ham network based on the passed centroids and then
%tries to classify the passed input vector. 
%HamNet(centroidMatrix, inputVector)
%centroidMatrix - Matrix of centroids. Each COL is a centroid
%inputVector - Vector to classify. this should be a single Column
%delta - how small the average distance between the current and last
%       iteration should be before considering the system converged.
%       numbers are from 0 to 1, so a delta of .01 to .1 is best
%This function takes the classification and then uses a HAMMING MAX
%to figure out which centroid it's closest to and returns that instead of
%the raw classification vector.
function output = HamNet(centroidMatrix, inputVector, delta)
    weightMatrix = ham(centroidMatrix);
    
    [h, w, d] = size(weightMatrix);
    
    fprintf('Starting HAM classification!\n');
    
    d = 1;
    sens = 25;
    index = 1;
    oldIn = inputVector;
    while (d > delta)
       %to avoid seeming-deadlock, we report that the program is still
       %iterating. To avoid spamming, we increase iterations between
       %reports by doubling the distance
       if (index == sens)
          fprintf('Beginning iteration %d. Previous Delta: %d\n', index, d);
          sens = sens * 2;
       end
       
       %fetch the current iteration's classification
       classification = weightMatrix * oldIn;
       
       %apply theshhold function to classification
       classification = threshhold(classification);
       
       %find average absolute distance between iterations
       d = 0;
       for i=1:h
            %sum all differences up
            d = d + (abs(oldIn(i, 1) - classification(i, 1)));
       end
       d = d / h;
       index = index + 1;
       oldIn = classification;
    end
    
    %we have the finished vector classification. Now which is it closest
    %to?
    %We use a hamming function here even though it's not conventionally
    %part of the network because this is soft computing and classification
    %can be iffy
    hammingVect = hamming(oldIn', centroidMatrix)
    pause;
    
    hammingIndex = maxNet(hammingVect);
    
    output = centroidMatrix(:, hammingIndex);
    fprintf('Converged in %d iterations.\n', index);
end

function output=threshhold(InputMatrix)
    [w,h,d] = size(InputMatrix);
    for i=1:w
    for j=1:h
       if (InputMatrix(i,j) < 0)
          output(i,j) = 0;
       else
           output(i,j) = 1;
       end
    end
    end
end