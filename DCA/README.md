A test file named ‘testDCA.m’ is available in the current directory that runs a sample implementation of the DCA algorithm. 
There is only one function DCA(). This function calls an m-file DCA_initialization.m that is needed to initialize the parameters of the DCA algorithm.
The detail of the function is provided below.
### [rDCA] =  DCA(DualSensorDATA, IC, TimeWindow, MigrationThreshold, Threshold) 
The necessary input arguments for this function are as follows:
* DualSensorDATA : Redundant measurements data.
*	IC: Inflammatory signal that is ignored in most cases. If not provided, IC = 1.
*	TimeWindow: Size of the time window of DCstore that is used to indicate the status of the DC at previous time samples.  If not provided, TimeWindow = 10.
*	MigrationThreshold: The threshold that determines the maturation of a DC based on the DC output (main equation). By default, MigrationThreshold = 1. There is no need to change this variable, unless there is a strong justification.
*	Threshold : A variable against which the number of matured DC (NummDC) is checked. This variable can be changed in order to improve the performance. If not provided, Threshold = 8.
The only output argument of this function is rDCA that consists of residuals for both sensors. 
