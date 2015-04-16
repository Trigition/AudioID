function output=ImageMatrix(input)
    

    if (~isdir(input))
        %assume its a single file name
        fprintf('Processing file: %s\n', input);
        img = polarize(input);
        output = img(:);
        output = output';
        return;
    else
        olddir = pwd;
        cd(input);
    
        files = dir('*.jpg');
        
        %init empty matrix
        output = zeros(3072, length(files));
        for i=1:length(files)
            filename = files(i).name;
            fprintf('Processing file: %s\n', filename);
            
            %polarize the image
            img = polarize(filename);
            
             %get image as a 1 x n vector
            vect = img(:);

            %transpose so it's a column vector
            vect = vect';

            %set the i'th COL to be the same as our vector
            output(:,i) = vect;
            i = i + 1;
            
        end
    end
    
    %return to the old directory
    cd(olddir);

end

function output=polarize(img)
    if (ischar(img))
       img = getImage(img);
    end
    
    img = resizeImage(img);
    
    output = rgb2gray(img);
    output = threshhold(output);
end

function img=getImage(filename)
    img = imread(filename);
end

function img=resizeImage(imgIn)
    img=imresize(imgIn, [48, 64]);
end

function output=threshhold(InputMatrix)
    [w,h,d] = size(InputMatrix);
    for i=1:w
    for j=1:h
       if (InputMatrix(i,j) < 128)
          output(i,j) = -1;
       else
           output(i,j) = 1;
       end
    end
    end
end
