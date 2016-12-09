function [K] = func_direct_assembly(Ke,CoordMat,ConnMat)
  [K] = zeros(size(CoordMat,1)*2,size(CoordMat,1)*2);
  for el_no = 1:size(Ke,3)
      node1 = ConnMat(el_no,2);
      node2 = ConnMat(el_no,3);
      
      K(2*node1-1 : 2*node1,2*node1-1 : 2*node1) = ...
            K(2*node1-1 : 2*node1,2*node1-1 : 2*node1) + Ke(1 : 2,1 : 2, el_no);
      K(2*node2-1 : 2*node2,2*node1-1 : 2*node1) = ...
            K(2*node2-1 : 2*node2,2*node1-1 : 2*node1) + Ke(3 : 4,1 : 2, el_no);
      K(2*node1-1 : 2*node1,2*node2-1 : 2*node2) = ...
            K(2*node1-1 : 2*node1,2*node2-1 : 2*node2) + Ke(1 : 2,3 : 4, el_no);
      K(2*node2-1 : 2*node2,2*node2-1 : 2*node2) = ...
            K(2*node2-1 : 2*node2,2*node2-1 : 2*node2) + Ke(3 : 4,3 : 4, el_no);
  end