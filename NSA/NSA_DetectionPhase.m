function [ResidualSignal, FaultySamples, FaultyDetector] = NSA_DetectionPhase(Sample_Data, Detector_Center, Detector_Radius, Self_Radius)

% This function works in accordance with 'Vdetector_NDim.m'
% This function implements the Detection (Monitoring) Phase of the Negative Selection
% Algorithm.


format long

epsilon = 0.01; 
% epsilon is introduced for MATLAB implementation only to avoid the False
% Alarms at the boundary between the Self and the Non-Self Regions due to
% calculation errors.

Self_Radius = Self_Radius - epsilon*Self_Radius;

% Make sure that Columns are the Dimension of the data and the Detectors
if length(Sample_Data(:,1)) < length(Sample_Data(1,:))
    Sample_Data = Sample_Data';
end

if length(Detector_Center(:,1)) < length(Detector_Center(1,:))
    Detector_Center = Detector_Center';
end


flag = false; % A boolean variable used to break nested loops. 

FaultySamples = [];
FaultyDetector = [];

% Check All Data Samples with each Detector
tic;
for i=1:length(Sample_Data)        % for every sample 
    
    for j=1:length(Detector_Center)     % for every detector
        
        Distance = norm(Sample_Data(i,:) - Detector_Center(j,:));
    
        if Distance - Detector_Radius(j) < Self_Radius
            flag = true; 
            FaultySamples = [FaultySamples i]; 
            FaultyDetector = [FaultyDetector j]; 
            break;            
        end  
    end
    
    %---------------------------------------------------------------------
    % Showing the Progress of the loop
    if mod(i,1000) == 0
        ProgressPercent = 100* (1 - (length(Sample_Data)-i)/length(Sample_Data));
        X = sprintf('Progress: %4.2f %%',ProgressPercent);
        disp(X)
    end
    
end
toc


ResidualSignal = zeros(1,length(Sample_Data));

for i=1:length(FaultySamples)
    ResidualSignal(FaultySamples(i)) = 1;
end




