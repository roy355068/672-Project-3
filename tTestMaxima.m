%% Finished
function detectedParticles = tTestMaxima(DT, x, y, image, localMax, sigma, Q )

    shape = size(localMax);
    detectedParticles = zeros(shape);
    for i = 1 : shape(1)
        for j = 1 : shape(2)
            if (localMax(i,j) == 1) 
                bgMean = BackgroundMean(i, j,DT,x,y,image);
                T = image(i,j) - bgMean;
                if(T >= Q*sigma)
                    detectedParticles(i,j) = 1;
                end
            end
        end
    end
end