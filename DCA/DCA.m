function rDCA = DCA(DualSensorDATA, IC, TimeWindow, MigrationThreshold, Threshold)

% -------------------------------------------------------------------------
if ~exist('IC','var')
    IC = 1;
end

if ~exist('TimeWindow','var')
    TimeWindow = 10;
end

if ~exist('MigrationThreshold','var')
    MigrationThreshold = 1.0;
end

if ~exist('Threshold','var')
    Threshold = 8;
end
% -------------------------------------------------------------------------

Antigen = DualSensorDATA;   % Assigning Sensor Values to the Antigen
numAg_instances = length(Antigen);

DCA_initialization %  Initializing & Loading DCA parameters 

% Initialization of output vector 
rDCA = zeros(numAg_instances+TimeWindow,numDC); 


%% ===================================================================== %%
tic;    % start of the clock for calculating the runtime of the loop

for t = 2:numAg_instances+TimeWindow   
    if (t == numAg_instances)
        break; % Avoid the counter to go beyond max number of sensor instances  
    end

    for counterDC = 1:numDC 
        
        DC(1) = Antigen(t,1); % storing Antigen 'Ag' in the specified DC
        DC(2) = Antigen(t,2);

        % Below steps should be done for each DC
        % calculate PAMP, Danger and Safe signals 
        % Input Selection for PAMP Signal 'PS'.
        switch(counterDC)
            case 1
                PS = Antigen(t-1,counterDC) - Antigen(t-1,counterDC+1);
            case 2
                PS = Antigen(t-1,counterDC) - Antigen(t-1,counterDC-1);
        end

        DS = Antigen(t,counterDC) - Antigen(t-1,counterDC);
        SS = Antigen(t,counterDC) - Antigen(t-1,counterDC);

        % calculate DC output signal
        DC_out = 0.5*(1 + IC)*((W_PAMP * PS) + (W_SAFE * SS) + (W_DANGER * DS))/(W_PAMP + W_SAFE + W_DANGER);

        if DC_out < MigrationThreshold   % this 1 is very important
            DC(counterDC) = 0;   % DC is matured to semi-mature state
        else
            DC(counterDC) = 1;   % DC is matured to mature state
        end
        
        
        
        Num_mDC = 0;
        
       
        for counterTimeWindow = 1:TimeWindow    
                      % Storing the DC into DC_store
            DC_store(counterTimeWindow,counterDC) = DC(counterDC);
            
            % Replace the oldest content of DC_store
            if t > TimeWindow
                DC_store(end-TimeWindow+1,counterDC) = DC_out; 
            end
    
   %%%%%%%%
            if DC_store(counterTimeWindow,counterDC) == 1
                Num_mDC = Num_mDC + 1;
            end

            if Num_mDC > Threshold
               DC_store(:,counterDC) = 1;  
            end
            
             rDCA(t,counterDC) = DC_store(counterTimeWindow,counterDC);

        end     % end of the loop over the TimeWindow
      
        
    end         % end of the loop DCs
    
   
    
    %---------------------------------------------------------------------
    % Showing the Progress of the loop
    if mod(t,10000) == 0
        ProgressPercent = 100* (1 - (numAg_instances-t)/numAg_instances);
        X = sprintf('Progress: %4.2f %%',ProgressPercent);
        disp(X)
    end   
       
end     % end of the loop over the whole data (should be removed in case of online FDI)

toc     % Prints the Elapsed Time for running the loop