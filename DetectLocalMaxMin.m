%% TODO!!!
function [localMaxs, localMins] = DetectLocalMaxMin(img, kernelSize)
    I = double(img);
    dimensions = size(I);
    localMins = zeros(dimensions);
    localMaxs = zeros(dimensions);
    offset = floor(kernelSize/2);
    rows = dimensions(1)
    cols = dimensions(2);
    for i = 1+offset:rows-offset
        for j = 1+offset:cols-offset
            submatrix = I(i-offset:i+offset, j-offset:j+offset);
            cpoint = I(i,j);
            submatrix = submatrix(:);
            if cpoint == max(submatrix)
                localMaxs(i,j) = 1;
            elseif cpoint == min(submatrix)
                localMins(i,j) = 1;
            end
        end
    end
end