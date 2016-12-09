function [ke] = func_truss_element(el_no,CoordMat,ConnMat,PropMat)
    node1 = ConnMat(el_no,2);
    node2 = ConnMat(el_no,3);

    % Geometry to get displacements because those are what actually matter
    dx = CoordMat(node2,2)-CoordMat(node1,2);
    dy = CoordMat(node2,3)-CoordMat(node1,3);
    % Determine length of element
    l = sqrt((dx)^2+(dy)^2);
    
    % Transformation matrix. sin(theta) is dx/l, cos(theta) is dy/l
    L = [dx/l dy/l 0 0; 0 0 dx/l dy/l];
    
    E = PropMat(el_no,2);
    A = PropMat(el_no,3);
    
    % Local stiffness matrix
    ke = E*A/l*[1 -1;-1 1];
    
    % Transformed, globalized matrix
    ke = L'*ke*L;
