function csv2vect()
%batch style processing dogg
    %batch directories----CURRENT finalprojout/*.cvs are samples
    classical='finalprojout/classical.csv';
    wubdub= 'finalprojout/wubdub.csv';
    reggae= 'finalprojout/reggae.csv';
    
    %convert cvs to matrix, vectorize each row, repeat for each cvs   
    classicalMatrix = csvread(classical);
    c1 = classicalMatrix(1, :);
    c2 = classicalMatrix(2, :);
    c3 = classicalMatrix(3, :);
    c4 = classicalMatrix(4, :);
    c5 = classicalMatrix(5, :);
    
    wubdubMatrix = csvread(wubdub);
    d1 = wubdubMatrix(1, :);
    d2 = wubdubMatrix(2, :);
    d3 = wubdubMatrix(3, :);
    d4 = wubdubMatrix(4, :);
    d5 = wubdubMatrix(5, :);
    
    reggaeMatrix = csvread(reggae);
    r1 = reggaeMatrix(1, :);
    r2 = reggaeMatrix(2, :);
    r3 = reggaeMatrix(3, :);
    r4 = reggaeMatrix(4, :);
    r5 = reggaeMatrix(5, :);
    
    %transpose each row vector, save to file
    c1=transpose(c1);
    c2=transpose(c2);
    c3=transpose(c3);
    c4=transpose(c4);
    c5=transpose(c5);
    d1=transpose(d1);
    d2=transpose(d2);
    d3=transpose(d3);
    d4=transpose(d4);
    d5=transpose(d5);
    r1=transpose(r1);
    r2=transpose(r2);
    r3=transpose(r3);
    r4=transpose(r4);
    r5=transpose(r5);
    save('c1', 'c1');
    save('c2', 'c2');    
    save('c3', 'c3');
    save('c4', 'c4');
    save('c5', 'c5');
    save('d1', 'd1');
    save('d2', 'd2');    
    save('d3', 'd3');
    save('d4', 'd4');
    save('d5', 'd5');
    save('r1', 'r1');
    save('r2', 'r2');    
    save('r3', 'r3');
    save('r4', 'r4');
    save('r5', 'r5');
end