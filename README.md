# Training a Quantized Neural Net with integer weights using Differential Evolution

[octave-5.1.0]

In this Repository, the QNN_DE.m file is used to train a Quantized Neural Network with 3 hidden layers using Differential Evolution optimization algorithm instead of the widely used backpropagation algorithm. To use the backpropagation algorithm the activation function and the cost function should be non-linear (to avoid the vanishing gradient problem). But, if differential evolution is used, the activation and cost functions can be linear as well.

The training examples in the data.txt file were loaded and divided into train/test data into 80:20 ratio. 

The cost function being used is the Huber loss function, with the delta value being the value of the element at the maximum 10% of the absolute error. Values can be adjusted using the huber.m file.

All the variables including the population count, number of neurons in the hidden layer, number of input features, number of training examples, evolution parameters can be adjusted inside the program

The activation function has been omitted purposefully for faster calculations (This is not an issue because backpropagation is not being used).

NOTE: The network performed well for examples having non-decimal values. The network may tend to over-fit for a higher number of generations

# References

[1] : Training Neural Networks with 3–bit Integer Weights. V.P. Plagianakos, M.N. Vrahatis.
       https://pdfs.semanticscholar.org/3c8f/5bf9d1feae18557320f4da926fb90373c081.pdf
       
[2] : Least Absolute Deviation And Huber M Cost  
        https://www.youtube.com/watch?v=QV0j4q2gQg0
