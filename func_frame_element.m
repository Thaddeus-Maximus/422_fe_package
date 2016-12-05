function [ke] = func_truss_element(x1,y1, x2,y2, E, A, I)
  rod = func_rod_element(x1,y1, x2,y2, E, A, I);
  beam = func_beam_element(x1,y1, x2,y2, E, A, I);
  ke = zeros(6,6);
  ke(1,1) = rod(1,1);
  ke(1,4) = rod(1,2);
  ke(4,1) = rod(2,1);
  ke(4,4) = rod(2,2);
  ke(2:3,2:3)=beam(1:2,1:2);
  ke(5:6,2:3)=beam(3:4,1:2);
  ke(2:3,5:6)=beam(1:2,3:4);
  ke(5:6,5:6)=beam(3:4,3:4);