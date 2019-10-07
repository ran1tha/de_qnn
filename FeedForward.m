%This Function calculates the cost of each example in the training set and stores 
%them in an array.

%Huber loss function has been used

%CAUTION: This function is to be used only if the architecture of the ANN is n-nodes-nodes-nodes-1

%Variables:
  % W1,W2,W3,W4 = Weight matrices
  % B1,B2,B3,B4 = Bias matrices
  % NP = population count
  % nodes = nodes in the hidden layer 
  % n = features
  % ex = examples
  % mat_in = input matrix of the examples
  % array_out = output array of the examples 

  
%------------------------------------------------------------------------------%

function [cost_array] = FeedForward (W1,W2,W3,W4,B1,B2,B3,B4,mat_in,array_out,f)


[dummy,ex] = size(mat_in);

[nodes,n,NP] = size(W1);
 
cost_array_a = zeros(1,NP); 
 
  for i = 1:NP
W1_a=W1(1:nodes,1:n,i);
W2_a=W2(1:nodes,1:nodes,i);
W3_a=W3(1:nodes,1:nodes,i);
W4_a=W4(1,1:nodes,i);
B1_a=B1(1:nodes,1:ex,i);
B2_a=B2(1:nodes,1:ex,i);
B3_a=B3(1:nodes,1:ex,i);
B4_a=B4(1,1:ex,i);

%Estimation. We use the ReLU function

A1 = W1_a*mat_in+B1_a;
A2 = W2_a*A1+B2_a;
A3 = W3_a*A2+B3_a;
Theta = W4_a*A3+B4_a;

%Cost Calculation
cost_array_a(i) = huber(Theta , array_out);
i++;

printf('Feed %i on player: %i/%i \n',f,i-1,NP);
endfor

cost_array = cost_array_a;
  
endfunction
