A test file named ‘testNSA.m’ is available in the current directory that runs a sample implementation of the NSA (V-detector) for the β1, m1 & β1, m2  measurements. 
Overall, there are four functions that should be implemented in the following order (detail of each one is provided afterwards):

__1. normalization()__

__2. Vdetector_NDim()__

__3. NSA_DetectionPhase()__

__4. SlidingWindow()__

-----------------------------------------------

## 1. [ Ndata, MIN, MAX ] = normalization(DATA, Lower_Limits, Higher_Limits)
*	This function normalizes _DATA_ between [0,1] in case of positive numbers only, and between [-1,1] in case both positive and negative numbers are available. 
*	If the arguments _Lower_Limits_ and _Higher_Limits_ are **_NOT_** provided, then the function assigns (and returns) the minimum and maximum of the _DATA_ to _MIN_ and _MAX_, respectively. 

## 2.	[Detector_Center, Detector_Radius] = Vdetector_NDim(Sample_Data,Detector_Max_Num,Self_Radius,coverage) 

This file performs the generation/censoring phase of the Vdetector algorithm by generating a detector set. 
The necessary input arguments for this function are as follows:
*	_Sample_Data_ : self samples obtained from the simulation runs.
	* _Sample_Data_ should be normalized using the function normalization() before passing it to this function.
	* Note that for the Fault Isolation task, self samples consist of the simulation data generated as a result of injecting the particular fault that needs to be isolated. Consequently, the generated detectors will be insensitive to the particular fault.
*	_Detector_Max_Num_ : A stopping criteria for the Vdetector algorithm. It is usually chosen to be a large number such that the algorithm does **_NOT_** stop at this criteria.
*	 _Self_Radius_ : A fixed threshold representing the radius of each data sample.
*	_Coverage_ : A stopping criteria that is usually considered for terminating the Vdetector algorithm.

The output arguments are _Detector_Center_ and _Detector_Radius_ that are the centers and radii of the generated detectors in the detector set, respectively.

## 3.	[ResidualSignal, FaultySamples, FaultyDetector] = NSA_DetectionPhase(Sample_Data,Detector_Center,Detector_Radius, Self_Radius)
This file performs the monitoring phase of the NSA by checking the new incoming sample data against detectors in the detector set. 
The necessary input arguments for this function are as follows:
*	_Sample_Data_ : Simulation output data that need to be checked if there is an anomaly or not.
	* Similar to __Vdetector_NDim()__, _Sample_Data_ should be normalized using the function __normalization()__ before passing it to this function.
*	_Detector_Center_ & _Detector_Radius_ : centers and radii of detectors in the detectors set that are generated using __Vdetector_NDim()__ function. 
*	_Self_Radius_ : A fixed threshold representing the radius of each data sample (Same as _Self_Radius_ variable used in  __Vdetector_NDim()__).

The output arguments for this function are as follows:
*	_ResidualSignal_ : The **_main_** output argument that is a binary residual signal showing the presence of an anomaly, if _ResidualSignal_ is 1 for a time sample.
*	_FaultySamples_ : This **_optional_** output argument returns data samples that have been identified as anomaly in the monitoring phase. 
*	_FaultyDetector_ : This **_optional_** output argument returns the indices of detectors that have identified _FaultySamples_.

## 4. [FilteredResidual] = SlidingWindow(DATA, WindowSize, NumFaultySamp)
*	_DATA_ : This should be the _ResidualSignal_ that is main output of __NSA_DetectionPhase()__. 
*	_WindowSize_ : Size of the moving window.
*	_NumFaultySamp_ : Number of faulty samples in a window above which all samples in the window is set to one.



	
