% This function computes stresses and strains in each truss member.

function [stress,strain] = func_postprocessing(qSol,CoordMat,ConnMat,PropMat)
    for element=1:size(ConnMat,1)
        % Get elements
        node1=ConnMat(element, 2);
        node2=ConnMat(element, 3);
        
        % Compute initial length of the element
        l0 = norm(CoordMat(node1,2:3)-CoordMat(node2,2:3));
        % Compute final length of the element
        lf = norm(CoordMat(node1,2:3)+qSol(node1*2-1:node1*2)'-CoordMat(node2,2:3)-qSol(node2*2-1:node2*2)');
        
        % Strain is change in length over original length
        strain(element)=(lf-l0)/l0;
        % Stress is strain times elastic modulus
        stress(element)=strain(element)*PropMat(element,2);
    end