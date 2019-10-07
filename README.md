# Training a Quantized Neural Net with integer weights using Differential Evolution

[octave-5.1.0]

**In this Repository, the QNN_DE.m file is used to train a Quantized Neural Network with 3 hidden layers using Differential Evolution optimization algorithm instead of the widely used backpropagation algorithm. The speciality is all the weights and biases in this network are integer values between -3 and +3.** This integer interval (-3 to +3) has been choosen specifically as it productive in programming low-end embedded devices. The maximum operations that has to be done when multiplying an integer in the range [-3,3] is three. Those are one shift, one addition and one sign change. Additionaly having integer weights and biases in this range reduces the memory usage and results in faster calculations. And due to quantization it reduces the adverse effects due to the precense of noise. Hence, this algorithm is optimal to be used in low-end embedded devices.  

NOTE: To use the backpropagation algorithm the activation function and the cost function should be non-linear (to avoid the vanishing gradient problem). But, if differential evolution is used, the activation and cost functions can be linear as well. Also, during this evolution process weights and biases are replaced without being shaped into improved versions of themselves, which is not practical because we are using integer weights (i.e: 1.5 cannot be used after improving 1. Therefore a diferent population of parameters should be used).

The training examples in the data.txt file were loaded and divided into train/test data into 80:20 ratio. <br/>

The cost function being used is the Huber loss function, with the delta value being the value of the element at the maximum 10% of the absolute error. Values can be adjusted using the huber.m file. <br/>

All the variables including the population count, number of neurons in the hidden layer, number of input features, number of training examples, evolution parameters can be adjusted inside the program <br/>

The activation function has been omitted purposefully for faster calculations (This is not an issue because backpropagation is not being used). <br/>

NOTE: The network performed well for examples having non-decimal values. The network may tend to over-fit for a higher number of generations <br/>

*A real valued version of training a neural network with differential evolution can be found [here](http://github.com/ran1tha/de).*

## References

[1] : Training Neural Networks with 3–bit Integer Weights. V.P. Plagianakos, M.N. Vrahatis.
       https://pdfs.semanticscholar.org/3c8f/5bf9d1feae18557320f4da926fb90373c081.pdf
       
[2] : Least Absolute Deviation And Huber M Cost  
        https://www.youtube.com/watch?v=QV0j4q2gQg0


Ranitha Mataraarachchi, <br/>
Room No: 2234, <br/>
Akbar-Nell Hall, <br/>
Faculty of Engineering, <br/>
University of Peradeniya, <br/>
Peradeniya, Sri Lanka.

(+94)777722662 </br>
ranitha@ieee.org <br/>
[Facebook](https://www.facebook.com/1994ranitha) | [LinkedIn](https://www.linkedin.com/in/ranitha/)
