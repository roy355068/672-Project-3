close all;
clear all;
% 1.1 Calibration of dark noise
% Here we hardcoded the first image in the directory for calibrating noise
filePath = 'images/001_a5_002_t001.tif';
[noiseMean, noiseStd] = DarkNoiseCalibration(filePath);
close all;


% 1.2 Detect local maxima and minima
close all;
% https://stackoverflow.com/questions/22218037/how-to-find-local-maxima-in-image
% Derive sigma based on the parameters provided in the handout

sigma = (0.61 * 515) / (1.4 * 65 * 3);
% disp(sigma);
dirPath = 'images/';
files = dir(strcat(dirPath, '*.tif'));
numFiles = length(files);

if ~exist('smoothed', 'dir')
    % Folder does not exist so create it.
    mkdir('smoothed');
end

% Smooth all files and store them into "smoothed" subdirectory
% for i = 1 : numFiles
% for i = 1 : 2
I = imread(strcat(dirPath, files(1).name));
image = imgaussfilt(I,sigma);
f = fullfile('smoothed', strcat('smoothed_', num2str(1), '.tif'));
imwrite(image, f);
% end


% https://www.mathworks.com/matlabcentral/answers/249649-the-fastest-way-to-find-local-minimum
% https://stackoverflow.com/questions/22218037/how-to-find-local-maxima-in-image
% https://stackoverflow.com/questions/1856197/how-can-i-find-local-maxima-in-an-image-in-matlab

I1 = imread('images/001_a5_002_t001.tif');
I2 = imread('smoothed/smoothed_1.tif');

[localMax, localMin] = DetectLocalMaxMin(I2, 5);
% figure('Name', 'Local Max');
% imshow(localMax, []);
% figure('Name', 'Local Min');
% imshow(localMin, []);


% 1.3 Delaunay triangulation
% Use the localMins to form the triangles
[DT, x, y] = DelaunayTriangulation(localMin);
% triplot(DT);

% 1.4 Statistical selection of local maxima
detectedParticles = tTestMaxima(DT, x, y, I2, localMax, noiseStd, 10 );
imshow(I1, []);
hold on;
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
result = plot(Y, X, 'o', 'MarkerEdgeColor','green');


if ~exist('Detected_Paticles', 'dir')
    % Folder does not exist so create it.
    mkdir('Detected_Paticles');
end

index = num2str(1);
save(strcat('Detected_Paticles/result_', index, '.mat'), 'result');
hold off;