# A multi-function activated WASD for time-series neural network
Implementation of a fast 3-layer feed-forward neuronet model for time-series modeling and forecasting problems that is trained using a multi-function activated WASD (weights-and-structure-determination) for time-series algorithm, called MWASDT.
The purpose of this package is to present applications on the Gross Domestic Product (GDP) time-series of United States (U.S.), United Kingdom (U.K.), Italy, France, Greece and India.
Additionally, all GDP datasets were retrieved from FRED at https://fred.stlouisfed.org/

The main article used is the following:
*	S.D.Mourtas, E.Drakonakis and Z.Bragoudakis, "Forecasting the Gross Domestic Product using a weight direct determination neural network", (submitted)


# M-files Description
*	Main_MWASDTN.m: the main function
*	problem.m: input data
*	MWASDT.m: function for finding the optimal ratio between the fitting and validation input sets, the optimal number of inputs (or observation delays), the optimal number of hidden layer neurons, the optimal activation function of each hidden layer neuron, and the weights of the neural network
*	WASD.m: function for creating a WASDP model, retrieved from https://doi.org/10.1016/j.asoc.2021.107767
*	OHLW.m: function for finding the optimal hidden-layer neurons weights of the WASDP, retrieved from https://doi.org/10.1016/j.asoc.2021.107767
*	LSVM.m: function for creating a neural network model based on linear SVM method
*	EGPR.m: function for creating a neural network model based on exponential GPR method
*	EBT.m: function for creating a neural network model based on ensemble bagged trees method
*	Normalization.m: function for normalization
*	Qmatrix.m: function for calculating the input matrix of MWASDT
*	Qmatrix2.m: function for calculating the input matrix of WASDP
*	predictN.m: function for forecasting with the MWASDT neural network
*	predictPFN.m: function for forecasting with the WASDP neural network
*	predictNN.m: function for forecasting with the LSVM, EGPR and EBT neural networks
*	error_pred.m: function for calculating the neural network statistics
*	test_NN.m: a function that prepares input data for use with LSVM, EGPR and EBT
*	testPFN.m: function for testing the optimal hidden-layer neurons weights of the WASDP
*	Problem_figures.m: function for creating the results figures

# Installation
*	Unzip the file you just downloaded and copy the MWASDT directory to a location,e.g.,/my-directory/
*	Run Matlab/ Octave, Go to /my-directory/MWASDT/ at the command prompt
*	run 'Main_MWASDTN' (Matlab/Octave)

# Results
After running the 'Main_MWASDTN.m' file, the package outputs are the following:
*	The optimal ratio between the fitting and validation input sets, optimal number of hidden-layer neurons and the optimal input variables number and activation functions.
*	The models predictions and statistics on the testing samples.
*	The graphic illustration of the training and forecasting performance.

# Environment
The MWASDT package has been tested in Matlab 2022a on OS: Windows 10 64-bit.
