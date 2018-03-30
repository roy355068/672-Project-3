I2 = imread('smoothed/smoothed_1.tif');
di=size(I2);
ro=di(1);
co=di(2);

% Finished
[DT,x,y] = DelaunayTriangulation(localMin);
newlocalmax = tTestMaxima(DT, x, y,I2, localMax, noiseStd, 4.0 );  % Q = 4.0
[ num, centerX, centerY ] = interp(newlocalmax,I, noiseMean);

figure('Name', 'Sub-pixel Center'),
imshow(I,[]);
hold on
plot(centerX, centerY,'green+');