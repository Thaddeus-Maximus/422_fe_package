function [F] = func_load_vector(LoadMat,numNode)
    F=zeros(2*numNode,1);
    
    for i = 1:size(LoadMat,1)
        dof = 2*(LoadMat(i,1)-1)+LoadMat(i,2);
        
        F(dof) = LoadMat(i,3);
end