A test file named ‘testNSA.m’ is available in the current directory that runs a sample implementation of the NSA (V-detector) for the β1, m1 & β1, m2  measurements. 
Overall, there are four functions that should be implemented in the following order (detail of each one is provided afterwards):

__1. normalization()__

__2. Vdetector_NDim()__

__3. NSA_DetectionPhase()__

__4. SlidingWindow()__

-----------------------------------------------

## 1. [ Ndata, MIN, MAX ] = normalization(DATA, Lower_Limits, Higher_Limits)
*	This function normalizes DATA between [0,1] in case of positive numbers only, and between [-1,1] in case both positive and negative numbers are available. 
*	If the arguments Lower_Limits and Higher_Limits are NOT provided, then the function assigns (and returns) the minimum and maximum of the DATA to MIN and MAX, respectively. 

## 2.	[Detector_Center, Detector_Radius] = Vdetector_NDim(Sample_Data,Detector_Max_Num,Self_Radius,coverage) 

This file performs the generation/censoring phase of the Vdetector algorithm by generating a detector set. 
The necessary input arguments for this function are as follows:
*	Sample_Data : self samples obtained from the simulation runs.
	* Sample_Data should be normalized using the fuction normalization() before passing it to this function.
  * Note that for the Fault Isolation task, self samples consist of the simulation data generated as a result of injecting the particular fault that needs to be isolated. Consequently, the generated detectors will be insensitive to the particular fault.
*	Detector_Max_Num : A stopping criteria for the Vdetector algorithm. It is usually chosen to be a large number such that the algorithm does NOT stop at this criteria.
*	 Self_Radius : A fixed threshold representing the radius of each data sample.
*	Coverage : A stopping criteria that is usually considered for terminating the Vdetector algorithm.
The output arguments are Detector_Center and Detector_Radius that are the centers and radii of the generated detectors in the detector set, respectively.
## 3.	[ResidualSignal, FaultySamples, FaultyDetector] = 
NSA_DetectionPhase(Sample_Data,Detector_Center,Detector_Radius, Self_Radius)
This file performs the monitoring phase of the NSA by checking the new incoming sample data against detectors in the detector set. 
The necessary input arguments for this function are as follows:
*	Sample_Data : Simulation output data that need to be checked if there is an anomaly or not.
	* Similar to Vdetector_NDim(), Sample_Data should be normalized using the fuction normalization() before passing it to this function.
*	Detector_Center & Detector_Radius : centers and radii of detectors in the detectors set that are generated using Vdetector_NDim() function. 
*	Self_Radius : A fixed threshold representing the radius of each data sample (Same as Self_Radius variable used in  Vdetector_NDim()).
The output arguments for this function are as follows:
*	ResidualSignal : The main output argument that is a binary residual signal showing the presence of an anomaly, if ResidualSignal is 1 for a time sample.
*	FaultySamples : This optional output argument returns data samples that have been identified as anomaly in the monitoring phase. 
*	FaultyDetector : This optional output argument returns the indices of detectors that have identified FaultySamples.

## 4. [FilteredResidual] = SlidingWindow(DATA, WindowSize, NumFaultySamp)
*	DATA : This should be ResidualSignal that is main output of NSA_DetectionPhase(). 
*	WindowSize : Size of the moving window.
*	NumFaultySamp : Number of faulty samples in a window above which all samples in the window is set to one.



	
