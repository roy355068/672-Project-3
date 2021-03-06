close all;
clear all;
% 1.1 Calibration of dark noise
% Here we hardcoded the first image in the directory for calibrating noise
filePath = 'images/001_a5_002_t001.tif';
[noiseMean, noiseStd] = DarkNoiseCalibration(filePath);
close all;

if ~exist('smoothed', 'dir')
    % Folder does not exist so create it.
    mkdir('smoothed');
end
% 1.2 Detect local maxima and minima
close all;
% https://stackoverflow.com/questions/22218037/how-to-find-local-maxima-in-image
% Derive sigma based on the parameters provided in the handout

sigma = (0.61 * 515) / (1.4 * 65 * 3);
dirPath = 'images/';
files = dir(strcat(dirPath, '*.tif'));
numFiles = length(files);

% Smooth all files use the smoothed image for particle detection
for fileNo = 1 : numFiles
% Smaller loop for testing, comment this out in the final mode
% for i = 1 : 2
    I = imread(strcat(dirPath, files(fileNo).name));
    image = imgaussfilt(I,sigma);

    f = fullfile('smoothed', strcat('smoothed_', num2str(fileNo), '.tif'));
    imwrite(image, f);

% https://www.mathworks.com/matlabcentral/answers/249649-the-fastest-way-to-find-local-minimum
% https://stackoverflow.com/questions/22218037/how-to-find-local-maxima-in-image
% https://stackoverflow.com/questions/1856197/how-can-i-find-local-maxima-in-an-image-in-matlab

    I2 = image;

    [localMax, localMin] = DetectLocalMaxMin(I2, 5);

% 1.3 Delaunay triangulation
% Use the localMins to form the triangles
    [DT, x, y] = DelaunayTriangulation(localMin);
    % triplot(DT);

    % 1.4 Statistical selection of local maxima
    detectedParticles = tTestMaxima(DT, x, y, I2, localMax, noiseStd, 10 );
    
%     imshow(I, []);
%     hold on;

    dims = size(I2);
    X = [];
    Y = [];
    for i = 1 : dims(1)
        for j = 1 : dims(2)
            if detectedParticles(i, j) == 1
                X = [X, i];
                Y = [Y, j];
            end
        end
    end
    
%     result = plot(Y, X, 'o', 'MarkerEdgeColor','green');

    if ~exist('Detected_Paticles', 'dir')
        % Folder does not exist so create it.
        mkdir('Detected_Paticles');
    end

    index = num2str(fileNo);
    save(strcat('Detected_Paticles/result_', index, '.mat'), 'X', 'Y');
%     hold off;
end
