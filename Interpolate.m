function [ centerX, centerY ] = Interpolate( localMax, I, noiseMean )
    % vector to store the x and y coordinate of the center 
    centerX = [];
    centerY = [];
    shape = size(localMax);
    X=[];
    Y=[];

    % Append the local max points into X and Y vectors for further usage
    num = 0;
    for i = 1 : shape(1)
        for j = 1 : shape(2)
            if localMax(i, j) == 1
                X = [X j];
                Y = [Y i];
                num = num+1;
            end
        end
    end
    
    for k = 1 : num
        % Up-sampling
        [Xq, Yq] = meshgrid(X(k)-0.4:0.2:X(k)+0.4, Y(k)-0.4:0.2:Y(k)+0.4);
        XX = [X(k) - 2, X(k) - 1, X(k), X(k)+1, X(k) + 2];
        YY = [Y(k) - 2, Y(k) - 1, Y(k), Y(k)+1, Y(k) + 2];
        V = zeros(5);
        for i = -2:1:2
            for j = -2:1:2
                V(i + 3,j + 3) = I(Y(k) + i, X(k) + j) - noiseMean;
            end
        end
        
%         zi = interp2(XX, YY, V, Xq, Yq, 'cubic');
        zi = interp2(XX, YY, V, Xq, Yq);
        % Fit the image
        result = GaussianFitting(1:5,1:5,zi);
        % The result format is [amp, b, x0, y0]
        x0 = (X(k) - 0.4 + (result(3) - 1) * 0.2); % the absolute x-coordinate of the center
        y0 = (Y(k) - 0.4 + (result(4) - 1) * 0.2); % the absolute y-coordinate of teh center
        centerX = [centerX x0];
        centerY = [centerY y0];
    end
end