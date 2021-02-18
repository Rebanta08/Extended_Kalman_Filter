clear; % Clear variables
datasetNum = 9; % CHANGE THIS VARIABLE TO CHANGE DATASET_NUM9
[sampledData, sampledVicon, sampledTime] = init(datasetNum);
%% How do you want to do this version
Z = sampledVicon(7:9,:);% Set initial condition
uPrev = vertcat(sampledVicon(1:9,1),zeros(6,1)); % Copy the Vicon Initial state
covarPrev = eye(15); % Covariance constant
savedStates = zeros(15, length(sampledTime)); %J ust for saving state his.
prevTime = 0; %last time step in real time
%% Calculate Kalmann Filter
for i = 1:length(sampledTime)
           [t,p]= pred_step(uPrev,covarPrev,sampledData(:,i).omg,sampledData(:,i).acc,sampledTime(i,1)-prevTime);
           [q,r]=upd_step(Z(:,i),t,p);
           uPrev=q;
           covarPrev=r;
           savedStates(:,i)=uPrev;
           disp(savedStates(:,i));
           prevTime=sampledTime(i,1);
end
plotData(savedStates, sampledTime, sampledVicon, 2, datasetNum);