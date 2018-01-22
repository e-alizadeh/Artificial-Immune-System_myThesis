% This file runs a complete test for the implementation of the NSA.
% The selected inputs in this file are Beta1_m1 & Beta1_m2 measurements. 
% For other output measurements, please check the end of the current file.
% A complete detail of each function used in this file is included in a
% % README file in the current directory.

clear all
clc

load WTbenchamrkDATA_HealthyAndFaulty.mat


data = FilteredSensors_Healthy_Tss(:,8:9);  % Input selection for self data
data_faulty = FilteredSensors_DefaultFaulty_Tss(:,8:9); % Input selection for testing data


% Below two limits are assigned for normalization() & if not provided, the
%%% function itself will return MIN & MAX based on the input DATA.
Lower_Limits = -5; Higher_Limits = 25; % min & max values of pitch angle

Ndata_healthy = normalization(data, Lower_Limits, Higher_Limits); 
Ndata_faulty = normalization(data_faulty, Lower_Limits, Higher_Limits);

% Training Phase 
[DetectorCenter, DetectorRadius] = Vdetector_NDim(Ndata_healthy,10000,0.025,99); 
%%% Detector_Max_Num = 10000, coverage = 99, 
%%% Self_Radius = 0.025; % Self radius in case of pitch angle measurements 


% Monitoring Phase
residual = NSA_DetectionPhase(Ndata_faulty,DetectorCenter, DetectorRadius,0.025); 

% Moving Window Filter
[filteredResidual] = SlidingWindow(residual); 

plot(filteredResidual)

% ===================================================================== %

% pitchSelfRadius = 0.025;
% wrSelfRadius = 0.05;
% wgSelfRadius = 0.05;

% pitchMAX = 25;
% pitchMIN = -5;
% omega_g_MAX = 170;
% omega_g_MIN = 40;
% omega_r_MAX = 2.5;
% omega_r_MIN = 0;


% ============================ Sensor Names ============================= %
% SensorsName     = cell(13,1);
% SensorsName(1)  = {'v_hub_m'};
% SensorsName(2)  = {'Omega_r_m1'};
% SensorsName(3)  = {'Omega_r_m2'};
% SensorsName(4)  = {'Omega_g_m1'};
% SensorsName(5)  = {'Omega_g_m2'};
% SensorsName(6)  = {'Tau_g_m'};
% SensorsName(7)  = {'P_g_m'};
% SensorsName(8)  = {'Beta_1_m1'};
% SensorsName(9)  = {'Beta_1_m2'};
% SensorsName(10) = {'Beta_2_m1'};
% SensorsName(11) = {'Beta_2_m2'};
% SensorsName(12) = {'Beta_3_m1'};
% SensorsName(13) = {'Beta_3_m2'};
%=========================================================================%