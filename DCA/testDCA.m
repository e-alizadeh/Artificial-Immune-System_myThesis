clear all
clc 

load WTbenchmarkDATA_DeafultRun.mat

DualSensorDATA = FilteredSensors(:,2:3); % w_r sensors
% DualSensorDATA = FilteredSensors(:,8:9); % beta sensors

rDCA = DCA(DualSensorDATA,27);  % w_r sensors
% rDCA = DCA(DualSensorDATA,1);  % beta sensors

figure
plot(rDCA(:,1)), title('Sensor 1 residual')
figure
plot(rDCA(:,2)), title('Sensor 2 residual')




%%============================= Sensor Names =============================%
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