function [ke] = func_rod_element(x1,y1,x2,y2,E,A,I)
    l = sqrt((x1-x2)^2+(y1-y2)^2);
    
    ke = E*A/l*[1 -1;-1 1];
    
