function output= Main( test_vector )
%Our Main Function. Yaaay
    %These are the directory paths to our encodings
    BatchOne = 'proj2out/i/';
    BatchTwo = 'proj2out/ii/';
    BatchThree = 'proj2out/iii/';
    %Collect the Weight Matrix returned by the Data Function
    WeightMatrixOne = vectorization(BatchOne);
    WeightMatrixOne = WeightMatrixOne';
    %WeightMatrixTwo = Data(BatchTwo);
    %WeightMatrixThree = Data(BatchThree);
    %Pass Weight Matrix and Vector to Hamming Function
    
    
    
    HammingVector = hamming(test_vector, WeightMatrixOne);
    
    %Pass Hamming Vector to MaxNet Function
    
    ResultIndex = maxNet(HammingVector);
    
    %Grab index (a column) of the Weight Matrix
    output = WeightMatrixOne(ResultIndex,:);
    
end

