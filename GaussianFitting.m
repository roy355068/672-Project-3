% https://www.mathworks.com/help/optim/ug/lsqcurvefit.html
% Use lsqcurvefit to fit gaussian to find the optimal maxima

function x = GaussianFitting(xData,yData,zData)
    % Condition the data
    [X, Y] = meshgrid(xData,yData);
    XY(:,:,1) = X;  % x coordinate
    XY(:,:,2) = Y;  % y coordinate

    % Objective function in the 17th slide of lecture 10
    gaussian2D = @(x,XY) x(1)*exp(-((X-x(3)).^2/x(2))-((Y-x(4)).^2/x(2)));

    % Set up the startpoint
    A = max(zData(:)); % A is the amplitude.
    [x0, y0] = find(zData == A); % first guess for position at the maximum
    B = 50; % initialize B to an arbitrary number
    StartPoint = [A, B, x0, y0];
    
    % Perform the fitting and find the subpixel with the minimum error
    % The result x will have the same dimension with StartPoint;
    x = lsqcurvefit(gaussian2D, StartPoint, XY, zData);
end