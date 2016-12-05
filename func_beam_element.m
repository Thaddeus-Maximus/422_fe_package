function [ke] = func_beam_element(x1,y1, x2,y2, E, A, I)
  l = sqrt((x1-x2)^2+(y1-y2)^2);
  
  ke = E*I/l^3* [ 12 6*l -12 6*l; 6*l 4*l^2 -6*l 2*l^2; -12 -6*l 12 -6*l; 6*l 2*l^2 -6*l 4*l^2];