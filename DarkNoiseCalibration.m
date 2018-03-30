%% Finished 
%1.1 Calibration of dark noise
function [mean, std] = DarkNoiseCalibration(filePath)

    % use the first image to get the background for calibration
    preImage = imread(filePath);
    imshow(preImage, [])
    rect = imrect;
    position = rect.getPosition;
    croppedImage = imcrop(preImage, position);
    % calculate mean and std
    mean = mean2(croppedImage);
    std = std2(croppedImage);

end