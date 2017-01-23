clear all
clc

%clear CoordMat ConnMat PropMat 


% calls the input function
[CoordMat,ConnMat,PropMat,ConstrMat,LoadMat]=func_input_data();

% compute the number of elements
nNode = size(CoordMat,1);
nElem = size(ConnMat,1);

% compiles a 3D array of element stiffness matrices
for II = 1:nElem
    [ke] = func_truss_element(II,CoordMat,ConnMat,PropMat);
    Ke(:,:,II) = ke;
    clear ke
end

% assembles the element stiffnesses into a global stiffness matrix
[KG] = func_direct_assembly(Ke,CoordMat,ConnMat);

% assembles the load vector
[F] = func_load_vector(LoadMat,nNode);

% solves the system using Matrix Partitioning Method
[qSol,fSol] = func_matrix_partitioning_solver(KG,ConstrMat,F);

% computes stress and strain
[stress,strain] = func_postprocessing(qSol,CoordMat,ConnMat,PropMat);

fprintf('Reaction at 1: x: %.5f y: %.5f N\nReaction at 4: x: %.5f y: %.5f N\n', fSol(1),fSol(2), fSol(2*4-1),fSol(2*4));

fprintf('Strain in element 6: %.10f\n', strain(6));
fprintf('Stress in element 1: %.5f Pa\n', stress(1));