%This function will create a centroid matrix with 3 centroids
function centroid = classMatrix(classOne, classTwo, classThree)

    %Find Length of each class name
    LengthOne = length(classOne);
    LengthTwo = length(classTwo);
    LengthThree = length(classThree);
    MaxLength = max([LengthOne, LengthTwo, LengthThree]);
    diff = MaxLength - LengthOne;
    %Ensure that all class vectors are of the same length
    %This will append 'spaces' to any vector less than the max length
    fprintf('Max Length: %d\n',MaxLength);
    while (diff > 0)
       classOne(LengthOne + 1) = ' ';
       LengthOne = length(classOne);
       diff = diff - 1;
    end
    diff = MaxLength - LengthTwo;
    while (diff > 0)
       classTwo(LengthTwo + 1) = ' ';
       LengthTwo = length(classTwo);
       diff = diff - 1;
    end
    diff = MaxLength - LengthThree;
    while (diff > 0)
       classThree(LengthThree + 1) = ' ';
       LengthThree = length(classThree);
       diff = diff - 1;
    end
    fprintf('%s', classOne);
    centroid = [classOne; classTwo; classThree];
end