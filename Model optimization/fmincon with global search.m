%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

%reproductivity set as default
rng default

%import of objectivity function
fun=@objectivity;

%Global search function 
gs = GlobalSearch('Display','iter');
opcje=optimset('Display','iter');

%initial condition
o0=[0.0403,0.337,0.249,1];

%problem definition
problem = createOptimProblem('fmincon','x0',o0,'objective',fun,'lb',[0, 0, 0,0], 'ub', [1, 1, 1, 10])

%Optimalisation algorithm with time measurement
tic
[o,fval] = run(gs,problem)
toc

%Diagram option
%o=[0.0403,0.337,0.249];
%p=Indata_R4;
%y0=[0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;0.3148;0.7805;
    %0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;
    %0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693];
%[t,solution]= ode15s(@(t,x) sensitivity_m(t,x,p,o), [0, 57], y0);
%[~,q_gas,pCH4g,pCO2g]=cellfun(@(t,x) sensitivity_m(t,x,p,o),num2cell(t),num2cell(solution,2),'uni',0);
%q_gas=cell2mat(q_gas); q_gas=q_gas(end);
%pCH4g=cell2mat(pCH4g); plot(t,pCH4g); 