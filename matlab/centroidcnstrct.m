%feed 5 vectors originating from csv's (c1-5, d1-5, and r1-5) will return
%the average of all 5 leaving a class centroid. push centroids to
%centroidMatrix or classMatrix to craft the trgt matrix
function centroid = centroidcnstrct(v1, v2, v3, v4, v5)
    centroid = v1 + v2 + v3 + v4 + v5;
    centroid = centroid/5;
end