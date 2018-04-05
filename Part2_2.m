close all;
filePath = 'images/001_a5_002_t001.tif';
I = imread(filePath);
I2 = imread('smoothed/smoothed_1.tif');
[noiseMean, noiseStd] = DarkNoiseCalibration(filePath);
[localMax, localMin] = DetectLocalMaxMin(I2, 5);

[DT,x,y] = DelaunayTriangulation(localMin);
newlocalmax = tTestMaxima(DT, x, y, I2, localMax, noiseStd, 4.0);
[centerX, centerY] = Interpolate(newlocalmax,I, noiseMean);

figure('Name', 'Sub-pixel Particles Detection'),
imshow(I,[]);
hold on
plot(centerX, centerY,'xg');