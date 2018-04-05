close all;
imagePath = 'images/001_a5_002_t001.tif';
[noiseMean, noiseStd] = DarkNoiseCalibration(imagePath);
I = imread(imagePath);
I2 = imgaussfilt(I, (0.61 * 515) / (1.4 * 65 * 3));
[localMax, localMin] = DetectLocalMaxMin(I2, 5);

shape = size(localMax);
rawImage = zeros(shape);

for i = 1 : shape(1)
    for j = 1 : shape(2)
        if (localMax(i,j) == 1) 
            rawImage(i,j) = I2(i,j);
        end
    end
end

imshow(rawImage, []);
figure;
% Convolve with a point spread gaussian function
sigma = (0.61 * 515) / (1.4 * 65 * 3);
kernel = fspecial('gaussian', [5 5], sigma);
kernel = kernel/max(kernel(:));
output = filter2(kernel, rawImage);

% Add gaussian random noise
dims = size(rawImage);
noise = noiseMean + noiseStd * randn(dims(1), dims(2));
noise(noise < 0) = 0;
output = output + noise;
figure('Name', 'Synthetic Image');
imshow(output, []);
