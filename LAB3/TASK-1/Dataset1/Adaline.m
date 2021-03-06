% Implemetation of Adaline - Online Algorithm

function w = Adaline1(X,Y,eta0,etaf)

N = size(X,1);  %Number of training examples 
M = size(X,2);  %Number of feature vectors  + 1

w = rand(1,M);  %initialize random initial weights

flag = -1;  %for while loop termination. Loop terminates when flag = 0.
maxIter = 2000;  %Emergency/Forced stop.
maxMSE = 0.2;   % Maximum value of mean squared error
maxMSEPerc = 0.01; %Maximum mean squared error allowed (percentage change in MSE). 
nIter = 0;  %count number  
mse = 0; % Mean squared error

% delta update rule - online
while(flag==-1 && nIter<=maxIter)
    msePrev = mse;  %record previous weight. Used for stopping criteria
    mse = 0;    % Mean squared error.
    
    eta = (eta0 - etaf)*((maxIter - nIter)/(maxIter-1)) + etaf; %Update learning rate
    for i=1:N   %for all training data
    
        e = (Y(i) - w*X(i,:)');
        w = w + 2*eta*e*X(i,:);  %update step - online
        
        mse = mse + e.^2;   %Calculate mean square error
    end
       mse = mse/N; % Take mean of the total error over all training examples.
      
    %Check performance 
    pred = zeros(N,1);
    for i= 1:N
        if(w*X(i,:)'>= 0)   %prediction made by current solution
            pred(i) = 1;
        else
            pred(i) = -1;
        end
    end

   errors = 0.5*sum(abs(pred - Y(:,1)));    %Number of classification errors  
       
       
   if (  mse<= maxMSE && (abs(mse - msePrev)/mse)*100<=maxMSEPerc) % || errors == 0)
       flag = 0;
   end
    
   nIter = nIter + 1;
end


if (nIter >= maxIter)
    fprintf('***** Adaline ***** \n\r- Failure.  \n Process did not converge. \n No of Iterations = %d MSE = %5.5f \n\r',nIter,mse)
else 
    fprintf('***** Adaline ***** \n\r- Success. \n Process converged found weight vactor. \n Iterations = %d \n  MSE = %5.5f \n\r',nIter,mse);
end

end
