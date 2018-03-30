close all;
I2 = imread('smoothed/smoothed_1.tif');
[DT,x,y] = DelaunayTriangulation(localMin);
newlocalmax = tTestMaxima(DT, x, y, I2, localMax, noiseStd, 4.0);
[centerX, centerY] = Interpolate(newlocalmax,I, noiseMean);

figure('Name', 'Sub-pixel Center'),
imshow(I,[]);
hold on
plot(centerX, centerY,'green+');