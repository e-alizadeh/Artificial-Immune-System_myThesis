% This file is called by the function DCA() to initialize the parameters
% used in the corresponding function.

%% ------------------------ Initialization ----------------------------- %%
Num_Sensor = 2;
Num_Ag = Num_Sensor;

numDC = Num_Ag;    % Initialize # of cells
DC_store(Num_Sensor) = Num_Ag;

      
% Assignment of Weights for each signal
W_PAMP   = -2;
W_SAFE   = -2;
W_DANGER = 2;


% Initialization of INPUT signals to the DCA
PS = 0;
DS = 0;
SS = 0;

% Finite Memory for online purposes
DC_store = zeros(TimeWindow,Num_Ag);    

% A counter
Num_mDC = 0;   