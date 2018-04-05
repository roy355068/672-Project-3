% Find the local bounds (max and min) by comparing the center with its
% (kernelSize ^ 2) - 1 neighbors
function [localMaxs, localMins] = DetectLocalMaxMin(img, kernelSize)
    I = double(img);
    dims = size(I);
    localMins = zeros(dims);
    localMaxs = zeros(dims);
    offset = floor(kernelSize/2);
    for i = 1 + offset:dims(1) - offset
        for j = 1 + offset:dims(2) - offset
            grid = I(i - offset:i + offset, j - offset:j + offset);
            centerVal = I(i, j);
            [ minVal, maxVal ] = bounds(grid(:));
            if centerVal == maxVal
                localMaxs(i, j) = 1;
            elseif centerVal == minVal
                localMins(i, j) = 1;
            end
        end
    end
end