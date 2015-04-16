function output=Weight(input)

    if (~isdir(input))
        %assume its a single file name
        fprintf('Processing file: %s\n', input);
        img = polarize(input);
        output = img(:);
        output= -((2*output) - 1);
        return;
    else
        olddir = pwd;
        cd(input);
    
        files = dir('*.jpg');
        
        %init empty matrix
        output = zeros(3072, 1);
        for i=1:length(files)
            filename = files(i).name;
            fprintf('Processing file: %s\n', filename);
            %polarize the image
            img = polarize(filename);
            vect = img(:);
            %img matrix is added to output matrix
            output= (vect .* vect) + output;
            %i=i+1;
        end
    end
    %all img matrices should be added, now averaged
   output= output/i;
   output=output*148;  %skews values for proper threshhold
   output= threshhold(output, 127); %threshhold the avg
   output= -((2*output) - 1);
   
   %output = output(:);
   cd(olddir); 
end
    
    
function output=polarize(img)
    if (ischar(img))
       img = getImage(img);
    end
    
    img = resizeImage(img);
    
    img = rgb2gray(img);
    output = threshhold(img, 230);
end

function img=getImage(filename)
    img = imread(filename);
end

function img=resizeImage(imgIn)
    img=imresize(imgIn, [48, 64], 'bilinear');
    %img = imresize(imgIn, [48, 64]);
end

function output=threshhold(InputMatrix, thresh)
    [w,h,d] = size(InputMatrix);
    for i=1:w
    for j=1:h
       if (InputMatrix(i,j) < thresh)
          output(i,j) = 0;
       else
           output(i,j) = 1;
       end
    end
    end
end
