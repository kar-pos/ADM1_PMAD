%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

%Parameter import
p=Indata_R4;
%initial conditions for ODE
y0=[0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;0.3148;0.7805;
    0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;
    0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693];

%ODE solver with time measurement
tic
[t,solution]= ode15s(@(t,x) pump_model(t,x,p), [0, 100], y0);
toc

% solutions of ODE equations
s.S_CH4_1=solution(:,1);
s.S_IC_1=solution(:,2);
s.S_IN_1=solution(:,3);
s.S_H2O_1=solution(:,4);
s.X_Ch_1=solution(:,5);
s.X_Pr_1=solution(:,6);
s.X_Li_1=solution(:,7);
s.X_Bac_1=solution(:,8);
s.S_CH4g=solution(:,9);
s.S_CO2g=solution(:,10);
s.S_CH4_2=solution(:,11);
s.S_IC_2=solution(:,12);
s.S_IN_2=solution(:,13);
s.S_H2O_2=solution(:,14);
s.X_Ch_2=solution(:,15);
s.X_Pr_2=solution(:,16);
s.X_Li_2=solution(:,17);
s.X_Bac_2=solution(:,18);
s.S_CH4_3=solution(:,19);
s.S_IC_3=solution(:,20);
s.S_IN_3=solution(:,21);
s.S_H2O_3=solution(:,22);
s.X_Ch_3=solution(:,23);
s.X_Pr_3=solution(:,24);
s.X_Li_3=solution(:,25);
s.X_Bac_3=solution(:,26);

%Gas products' pressures
s.P_gas_CH4=s.S_CH4g*p.R*p.T/16;
s.P_gas_CO2=s.S_CO2g*p.R*p.T/44;
s.P_gas=s.P_gas_CO2+s.P_gas_CH4+p.P_H2O;

%Streams of gas products
s.q_gas=p.k_p*(s.P_gas-p.P_atm).*s.P_gas/p.P_atm;
s.q_gas_CH4=s.P_gas_CH4./s.P_gas.*s.q_gas;
s.q_gas_CO2=s.P_gas_CO2./s.P_gas.*s.q_gas;

%Percentage content of gas products
pCH4g=100*s.q_gas_CH4./s.q_gas;
pCO2g=100*s.q_gas_CO2./s.q_gas;

%Plot of biogas stream
plot(t,s.q_gas,t,s.q_gas_CH4,t,s.q_gas_CO2)
title('Pump mixed anaerobic digestion model')
legend('Biogas stream','CH4','CO2')
xlabel('Time [d]')
ylabel('Gas volume [dm3]')
xlim([10 100])
ylim([0 550])


