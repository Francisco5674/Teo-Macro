function [Assets, ConsuptionCTI] = simulate(Ap, Cti, shocks, A)
% with the panel of assets/shocks and the shocks of each subject we can 
% simulate the agents. (In the begging, agents have nothing, A0 = 0)
Assets = [];
ConsuptionCTI = [];
pos = ones(1,size(shocks, 1));
for j = 1:size(shocks, 2)
    shock = shocks(:, j);
    index = sub2ind(size(Ap), shock', pos);
    pos = Ap(index);
    Copt = Cti(index);
    Aopt = A(pos);
    Assets = [Assets Aopt'];
    ConsuptionCTI = [ConsuptionCTI Copt'];
end
end

