%------------------------------------------------------------------------------%
%%%%%% Training a Quantized Neural Network using Differential Evolution %%%%%%
%------------------------------------------------------------------------------%

%%% Author: Ranitha Mataraarachchi
%%% Date: 03.10.2019

%------------------------------------------------------------------------------%


%In this Matlab file we have used differential evolution optimization to train an
%Artificial Neural Network with the architecture (n-nodes-ndoes-nodes-1). We have trained a simple
%regression problem. The speacial case here is all the weights and biases are integer
%values between -3 and +3



clc 
clear all
close all
%------------------------------------------------------------------------------%
%%%Load Train/Test Data%%%
data = csvread('data.txt');
inputs = data(:, 1); outputs = data(:, 2);

%Number of examples
m = length(outputs); 
inputs = inputs';
outputs = outputs';

%Number of features
[n,dummy] = size(inputs);

%Seperate train/test input/output matrices
%split the data in any ratio. Here we have splitted 0.8 for train and 0.2 for test
tr = round(0.8*m);
ts = m-tr;

train_in = inputs(1:n,1:tr);
test_in = inputs(1:n,(tr+1):m);
train_out = outputs(1:tr);
test_out = outputs((tr+1):m);


%------------------------------------------------------------------------------%
%%%Randomly Initialize Weights and Biases Population%%%


%Random Initiation of weights and biases
%There are 4 weight matrices W1,W2,W3,W4 and 4 biase matrices B1,B2,B3,B4

%Initialize a population of NP players ready to be optimized. Here the
% weight/bias matrices are considered as players and they get updated each generation.
%Generally a value between 2N to 4N is used as NP. N is the total weights and biases
NP = 400;

%Number of nodes in the hidden layer
nodes = 9;

%Randomly initialize W1,W2,W3,W4 as 3D matrices as the 3rd dimension represents 
%the player identity. The weights and biases are quantized. i.e: Inter values from -3 to 3

W1 = randi(4,nodes,n,NP)-randi(4,nodes,n,NP);
W2 = randi(4,nodes,nodes,NP)-randi(4,nodes,nodes,NP);
W3 = randi(4,nodes,nodes,NP)-randi(4,nodes,nodes,NP);
W4 = randi(4,1,nodes,NP)-randi(4,1,nodes,NP);

B1_col = randi(4,nodes,1,NP)-randi(4,nodes,1,NP);
B1 = B1_col;
for j = 1:(tr-1)
  B1 = [B1,B1_col];
endfor

B2_col = randi(4,nodes,1,NP)-randi(4,nodes,1,NP);
B2 = B2_col;
for j = 1:(tr-1)
  B2 = [B2,B2_col];
endfor

B3_col = randi(4,nodes,1,NP)-randi(4,nodes,1,NP);
B3 = B3_col;
for j = 1:(tr-1)
  B3 = [B3,B3_col];
endfor

B4_col = randi(4,1,1,NP)-randi(4,1,1,NP);
B4 = B4_col;
for j = 1:(tr-1)
  B4 = [B4,B4_col];
endfor


%------------------------------------------------------------------------------%
%%%Evolution Process%%%

%Number of generations to pass
gen = 25;

%store cost and substitution data for analysis
avg_cost = zeros(1,gen);
tot_sub = zeros(1,gen);

%The main loop
for g = 1:gen


%Initial Feed Forward
%Initial cost array
initial_cost=zeros(1,NP);

%Pass to Feed Forward function specially designed to this architecture
initial_cost = FeedForward(W1,W2,W3,W4,B1,B2,B3,B4,train_in,train_out,1); 

%Retrieve the best player in that generation
[M,Index] = min(initial_cost);

%Calculate Mutation Matrices and check cross over
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 1/8] \n+++ \n',g);
W1_mut = mutation(W1,Index);
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 2/8] \n+++ \n',g);
W2_mut = mutation(W2,Index);
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 3/8] \n+++ \n',g);
W3_mut = mutation(W3,Index);
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 4/8] \n+++ \n',g);
W4_mut = mutation(W4,Index);
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 5/8] \n+++ \n',g);
B1_mut = mutation(B1,Index);
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 6/8] \n+++ \n',g);
B2_mut = mutation(B2,Index);
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 7/8] \n+++ \n',g);
B3_mut = mutation(B3,Index);
printf('+++ \nGeneration %i is Mutating and Crossing Over... [phase 8/8] \n+++ \n',g);
B4_mut = mutation(B4,Index);


%Secondary Feed Forward
%Secondary cost array
second_cost=zeros(1,NP);

%Pass to Feed Forward function specially designed to this architecture
second_cost = FeedForward(W1_mut,W2_mut,W3_mut,W4_mut,B1_mut,B2_mut,B3_mut,B4_mut,train_in,train_out,2); 


%Selection into next generation

sub=0;

for r = 1:NP
  if second_cost(r)<initial_cost(r)
    
    
    W1(1:nodes,1:n,r)=W1_mut(1:nodes,1:n,r);
    W2(1:nodes,1:nodes,r)=W2_mut(1:nodes,1:nodes,r);
    W3(1:nodes,1:nodes,r)=W3_mut(1:nodes,1:nodes,r);
    W4(1,1:nodes,r)=W4_mut(1,1:nodes,r);
    B1(1:nodes,1:tr,r)=B1_mut(1:nodes,1:tr,r);
    B2(1:nodes,1:tr,r)=B2_mut(1:nodes,1:tr,r);
    B3(1:nodes,1:tr,r)=B3_mut(1:nodes,1:tr,r);
    B4(1,1:tr,r)=B4_mut(1,1:tr,r);
    
    sub=sub+1;
  endif
endfor

% Print Summary of the current generation
printf('++++++++++++++++++++++++++++ \n');
printf('Generation: %i/%i \n',g,gen);
printf('Avg cost: %f \n',mean(initial_cost));
printf('Substituted players: %i \n',sub);
printf('++++++++++++++++++++++++++++ \n');

%Plots
avg_cost(g) = mean(initial_cost);
tot_sub(g) = sub;

avg_cost_temp = zeros(1,g);

for s = 1:g
  avg_cost_temp = avg_cost(1,1:g);
endfor

plot(avg_cost_temp);
title('Generation vs Cost')
xlabel('Generation') 
ylabel('Cost')
grid on

 
g++;
endfor

%------------------------------------------------------------------------------%
%%%Testing Process%%%

%We find the Accuracy of the Neural Network by feeding the test data which the
%network has never seen before

%We use the same cost function as above
%We make predictions with the best player in the last generation
[minimum,best_player] = min(second_cost);

%Final weights and biases
W1_final=W1(1:nodes,1:n,best_player);
W2_final=W2(1:nodes,1:nodes,best_player);
W3_final=W3(1:nodes,1:nodes,best_player);
W4_final=W4(1,1:nodes,best_player);
B1_final=B1(1:nodes,1:ts,best_player);
B2_final=B2(1:nodes,1:ts,best_player);
B3_final=B3(1:nodes,1:ts,best_player);
B4_final=B4(1,1:ts,best_player);

%Estimation. We use the ReLU function

A1_f = W1_final*test_in+B1_final;
A2_f = W2_final*A1_f+B2_final;
A3_f = W3_final*A2_f+B3_final;
Estimation = W4_final*A3_f+B4_final;

%Cost Calculation and display
final_cost = cost(Estimation , test_out);
printf('Final cost for %i test examples after %i generations: %f \n',ts,g-1,final_cost);


