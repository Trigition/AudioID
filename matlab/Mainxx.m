%function takes a sample vector (c1, c2, or c3 or etc.)
%each existing vector is loaded and turned into a centroid and each
%centroid added into a single trgt matrix, then hamming/max tested returns
%classification with lowest hamming distance 

function output= Mainxx(test_vect)
%load each vector representing a track sample
    c1='c1.mat';
    c2='c2.mat';
    c3='c3.mat';
    c4='c4.mat';
    c5='c5.mat';
    d1='d1.mat';
    d2='d2.mat';
    d3='d3.mat';
    d4='d4.mat';
    d5='d5.mat';
    r1='r1.mat';
    r2='r2.mat';
    r3='r3.mat';
    r4='r4.mat';
    r5='r5.mat';

    %construct centroids for each class C, D, and R (for genres)
    centC= centroidcnstrct(c1, c2, c3, c4, c5);
    centD= centroidcnstrct(d1, d2, d3, d4, d5);
    centR= centroidcnstrct(r1, r2, r3, r4, r5);
    
    %construct the target matrix to determine hamming distance against
    centMatrix = classMatrix(centC, centD, centR);
    
    %determine the hamming dist. (hamming layer)
    HammingVector = hamming(test_vect, centMatrix);
    
    %Pass Hamming Vector to MaxNet Function    
    ResultIndex = maxNet(HammingVector);
    
    %Grab index (a column) of the centroid Matrix
    output = centMatrix(ResultIndex,:);


end