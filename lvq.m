%Constructs, trains, and returns a lvq network given the passed parameters
function output=lvq(trainingMatrix, targetMatrix)
    [h,w,d] = size(targetMatrix);

    output = lvqnet(w * 2);
    
    output = train(output, trainingMatrix, targetMatrix);
    
end