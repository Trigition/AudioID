%new weight matrix creator
function output=Weightf()
    output= c1 .* c1;
    output= (c2 .* c2) + output;
    output= (c3 .* c3) + output;
    output= (c4 .* c4) + output;
    output= (c5 .* c5) + output;
    output= output/5;


end