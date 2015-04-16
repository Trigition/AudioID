%Expects a matrix with each COLUMN being a centroid
%
function output=ham(inputmatrix)
    [h,w] = size(inputmatrix);
    output = zeros(h, h);
    
    for i=1:w
       output = output + getWeight(inputmatrix(:, i));
    end
    
    %go through and zero out the diagonal
    for i=1:h
       output(i,i) = 0;
    end
    
end

function weightMatrix = getWeight(inputVector)
   transVect = inputVector';
   weightMatrix = inputVector * transVect;
end