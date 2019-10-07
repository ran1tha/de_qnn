%This is the cost function. Modify this to have a desired cost function.
%We have used Huber loss function here.

%Variables:
  % Theta =  Approximations of the output values as a matrix
  % y_val = Output array
  % cost = Mean Squared Error 
  
 %delta value is the value of the element at the maximum 10% of the absolute error
%------------------------------------------------------------------------------%

function [cost] = huber(Theta,y_val)
  
  
  temp=0;
  
  len=length(Theta);
  ab = abs(Theta-y_val);
  ab = sort(ab);
  
  %delta value is the value of the element at the maximum 10% of the absolute error
  %Change the 0.9 below to adjust this
  
  delta_index = round(0.9*len);
  delta = ab(delta_index);
  
  for i=1:len
    if abs(Theta(i)-y_val(i))<delta
      temp=temp+0.5*(Theta(i)-y_val(i))^2;
    else
      temp=temp+delta*(abs(Theta(i)-y_val(i))-0.5*delta);
    endif
  endfor
  temp=temp/len;
  cost=temp;
endfunction
