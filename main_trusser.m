clear all
clc

[CoordMat,ConnMat,PropMat]=func_input_data()

for el_no = 1:size(ConnMat,1)
    Ke(:,:,el_no) = func_truss_element(el_no,CoordMat,ConnMat,PropMat)
end

[K]=func_direct_assembly(Ke,CoordMat,ConnMat)