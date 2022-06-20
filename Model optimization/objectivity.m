%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

function Z=objectivity(o)

%Data import
p=Indata_R4;

%Initial conditions for ODE
y0=[0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;0.3148;0.7805;
    0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;
    0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693];

%ODE solver
[t,solution]= ode15s(@(t,x) optimalisation_model(t,x,p,o), [0, 57], y0);
[~,q_gas,pCH4g,pCO2g]=cellfun(@(t,x) optimalisation_model(t,x,p,o),num2cell(t),num2cell(solution,2),'uni',0);

%Taking steady state values of biogas stream and gas products percentage content for objectivity function 
q_gas=cell2mat(q_gas); q_gas=q_gas(end);
pCH4g=cell2mat(pCH4g); pCH4g=pCH4g(end)*100;
pCO2g=cell2mat(pCO2g); pCO2g=pCO2g(end)*100;

%Input of experimental data for each mixing time
q_gas_ex=32.35;
pCH4g_ex=66.36;
pCO2g_ex=27.45;

%Relative error between theoretical and experimental values as an objectivity function
Z=sum(abs((q_gas-q_gas_ex)/q_gas_ex)+abs((pCH4g-pCH4g_ex)/pCH4g_ex)+abs((pCO2g-pCO2g_ex)/pCO2g_ex));
end