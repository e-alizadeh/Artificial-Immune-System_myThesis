function [Detector_Center, Detector_Radius] = Vdetector_NDim(Sample_Data,Detector_Max_Num,Self_Radius,coverage)

% Vector Sample_Data is the normal samples got from running a normal test.
% Dimension(Sample_Data) = # of row(Sample_Data)
% # of Samples = # of column(Sample_Data) 
% Detector_Max_Num is the maximum number of detectors

format long

% Make sure that Rows are the Dimension of the data
if length(Sample_Data(:,1)) > length(Sample_Data(1,:))
    Sample_Data = Sample_Data';
end


Dimension = length(Sample_Data(:,1));
Num_Sample = length(Sample_Data(1,:));


% A flag 'randFLAG' is introduced to decide whether the candidate detector 
%%% (with radius [R_1,R_2,...,R_n]) should be randomly generated 
%%% within [-1,1]^n OR [0,1]^n.  

% if(abs(min(Sample_Data')+1) < 1e-3)  % tolerance = 1e-3
if(min(Sample_Data') < 0)  % tolerance = 1e-3
    randFLAG = 1; % [-1,1]^n
else
    randFLAG = 0; % [0,1]^n
end


% Pre-assumption in case the last two arguments are not given.
switch nargin 
    case 2
        Self_Radius = 0.1;        % Self Radius
        coverage = 90;            % coverage  
    case 3
        coverage = 90;            % coverage       
end

coverage = coverage / 100;   % scale down from percentage to [0,1]

max_coverage = 0.999;      % Default value is 99.99%


% Detector set 
Detector_Center = zeros(Dimension,1);
Detector_Radius(1) = 0;    % radius of the detector stored with the detector center

flag = false;   % A boolean variable used to break the nested loops.

tic;
while (length(Detector_Center(1,:)) <= Detector_Max_Num)    
    
    p = 0;      % A variable used to estimate the coverage
    T = 0;
    Radius = inf;      % Radius of the detector initially is infinite.

    % ----------------------- [-1,1]^n OR [0,1]^n ----------------------- %
    switch(randFLAG)
        case 0
            detector = rand(Dimension,1);
        case 1
            detector = -1 + 2*rand(Dimension,1);
    end
    % ------------------------------------------------------------------- %
    
    
%     Detector_Distance = 0;     
   
    for i= 1:length(Detector_Center(1,:))      % for every detector
        
        Detector_Distance = norm(Detector_Center(:,i) - detector);     
        
        if Detector_Distance <= Detector_Radius(i)
            p = p + 1;
            if p >= ( 1 / (1-coverage) )
                flag = true;
                break   % Get out of the inner FOR loop(for i=1:length(Detector_Center(1,:))
            end    
        end
    end
    
    if flag
        break   % Get out of the WHILE loop
    end
    
    for j= 1:Num_Sample     % for every sample
        
        Distance = norm(Sample_Data(:,j) - detector);
        
        if (Distance - Self_Radius)  < Radius
            Radius = Distance - Self_Radius;
        end    
        
    end
    
    
    if Radius > 0   % it is used to be Radius > Self_Radius
        Detector_Center = [Detector_Center detector];
        Detector_Radius = [Detector_Radius Radius];
    else
        T = T + 1;
    end
    
    if T > ( 1 / (1 - max_coverage))
        break
    end    
    
end
toc

disp('Detector generation/censoring phase is completed.')

%%% Removing the first detector (actually a point -> Radius=0) that was
%%% generated to initiate the calculation
if Detector_Radius(1) == 0
    Detector_Center(:,1) = [];
    Detector_Radius(1) = [];
end

% # of Samples = # of Rows  &  # of Dimensions = # of Columns
Detector_Center = Detector_Center';
Detector_Radius = Detector_Radius'; 

end

%*************************************************************************%
%****************** Real-Valued NSA: V-detector (ver. 1) *****************%
% The above code is written based on the Detector Generation Algorithm of %
% V-detector proposed in "Real-Valued Negative Selection Algorithm with   %
% Variable Sized Detectors" by Zhou Ji and Dipankar Dasgupta              %
%-------------------------------------------------------------------------%
%******************** Done by: Esmaeil Abbas AliZadeh ********************%
%*************************** Copyright © 2016 ****************************%
%*************************************************************************%





