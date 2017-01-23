function [qSol,fSol] = func_matrix_partitioning_solver(K,ConstrMat,F_vec)

% Total number of degrees of freedom
tot_DOF = size(K,1);

% Predefine a vector of zeros for the constrained degrees of freedom
% and create a cumulative set of dof's for the free degrees of freedom
constr_dof_vec = zeros(size(ConstrMat,1),1);
free_dof_vec = cumsum(ones(tot_DOF,1));

% Loop over all the constraints to get the proper dof and the value
for II = 1:size(ConstrMat,1)
    constr_dof_vec(II) = 2*(ConstrMat(II,1)-1)+ConstrMat(II,2);
    qc(II,1) = ConstrMat(II,3);
end

% Delete the dof's which are constrained from the free dof vector
free_dof_vec(constr_dof_vec)=[];

% Partition the stiffness matrix accordingly
Kff=K(free_dof_vec,free_dof_vec);
Kfc=K(free_dof_vec,constr_dof_vec);
Kcf=K(constr_dof_vec,free_dof_vec);
Kcc=K(constr_dof_vec,constr_dof_vec);
    

% compute the force vector for the free dofs
F = F_vec(free_dof_vec);

Kff

% compute the displacements for the free dofs
qf = Kff\(F-Kfc*qc);

% compute the reactions at the constrained dofs
R = Kcf*qf + Kcc*qc;

% recompile the q and f vectors in order
qSol = zeros(tot_DOF,1);
qSol(free_dof_vec) = qf;
qSol(constr_dof_vec) = qc;

fSol = zeros(tot_DOF,1);
fSol(free_dof_vec) = F;
fSol(constr_dof_vec) = R;
