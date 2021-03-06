

function [spec,sens,spec1,sens1,i,j] = sequential (N,target_dataset,X)



%training set, n=number of patterns in the training set

error=0;
tar_trainset = target_dataset(N+1:end,:); 
new_target=zeros(N,1);
tar_testset = target_dataset(1:N,:);
 for i=1:N
     
  new_target(i,1) = nn(X(i,:),X(N+1:end,:),tar_trainset); 
  
  if new_target(i,1)~=target_dataset(i,1)
     error = error+1; 
  end
  
end

 
correct=N-error;
accuracy=correct*100/(N);
error_freq=error*100/(N);

fprintf('\n\rUsing Test set =%d \n\r',N);
fprintf('No of correct %d\n\r',correct);
fprintf('No of Errors %d\n\r',error);
fprintf('Error Frequency %2.2f Percent\n\r',error_freq);

% 
% 
%Confusion matrix: conf
conf=zeros(10,10);

for i=0:9
    for j=0:9
        for b=1:N
            if(new_target(b)==i && tar_testset(b)==j)
               conf(i+1,j+1)=conf(i+1,j+1)+1;
            end
        end
     end
end
% 
% 
% 
d=diag(conf);
best=max(d);
worst=min(d);
i=find(d==max(d));
i = i(1);
j=find(d==min(d));
j = j(1); 
% For the Best performance
 p00=conf(i(1),i(1));  % True Positive 
 p01=sum(conf(i(1),:))-p00; % False Nagative
 p10=sum(conf(:,i(1)))-p00; % False Positive
 p11=sum(sum(conf))+p00-p10-p01;% True Negative 
%  
 spec=p11/(p11+p10);
 sens=p00/(p00+p01);
% For worst Performance 
 q00=conf(j(1),j(1));
 q01=sum(conf(j(1),:))-q00;
 q10=sum(conf(:,j(1)))-q00;
 q11=sum(sum(conf))+q00-q10-q01;
%  
 spec1=q11/(q11+q10);
 sens1=q00/(q00+q01);
end