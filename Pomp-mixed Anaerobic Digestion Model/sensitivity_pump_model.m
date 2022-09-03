%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

clear all
close all
%import data
p=Indata_R4;

%initial conditions for ODE
y0=[0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;0.3148;0.7805;
    0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693;
    0.0910;0.5081;0.9439;956.9610;9.39;5.34;11.680;2.5693];

%number of parameters taken into consideration for sensitivity analysis
n_parametr=14;

var=ones(1,n_parametr);
gas_ref=calculate_mean_gas(p,y0);
sens_vec=zeros(1,n_parametr);
ref_vec=ref_value(p,n_parametr);
diff_vec=sens_vec;

%Loop for changing each parameter's value by 1%
for i=1:n_parametr
    i
    var(i)=1.01;
    p=change_value(p,var);
    gas_new=calculate_mean_gas(p,y0);
    sens_vec(i)=(gas_new-gas_ref)/(0.01*ref_vec(i));
    diff_vec(i)=(gas_new-gas_ref);
    var(i)=1;
    p=Indata_R4;
    
   end 

%Bar graph for analysis 
bfigure=figure;
bar(abs(sens_vec));
grid on
set(get(bfigure,'Child'),'XTick',[10 20 30 40 50 60 70])
set(get(bfigure,'Child'),'XTickLabel',{'10' '20' '30' '40' '50' '60' '70'})
set(get(bfigure,'Child'),'Yscale','log')
title('Model sensitivity analysis','fontsize',30)
bar(abs(diff_vec))
set(get(bfigure,'Child'), 'XTick', [10 20 30 40 50 60 70])
set(get(bfigure,'Child'), 'XTickLabel', {'10' '20' '30' '40' '50' '60' '70'})
title('Model sensitivity analysis', 'fontSize', 20)
xlabel('Parameter', 'fontSize', 10)
ylabel('|f(x * 1.01)−f(x)|','interp','latex', 'fontSize', 10)
grid on

%Calculating new biogas value
function mean_gas = calculate_mean_gas(p,y0)
options=odeset('Reltol',1e-10,'AbsTol',1e-10);
[t,solution]=ode15s(@(t,y) pump_model(t,y,p),[0 100],y0,options);

%Gas products ODE solutions
s.S_CH4g=solution(:,9);
s.S_CO2g=solution(:,10);

%Gas pressures
P_gas_CH4=(s.S_CH4g)*p.R*p.T/16;
P_gas_CO2=(s.S_CO2g)*p.R*p.T/44;
P_gas=P_gas_CH4+P_gas_CO2+p.P_H2O;

%Limiting condition
if P_gas/p.P_atm >  1
    q_gas=p.k_p*(P_gas-p.P_atm).*P_gas/p.P_atm;
else
    q_gas=0;
end

%Methane stream
q_gas_CH4=P_gas_CH4./P_gas.*q_gas;
mean_gas = mean(q_gas_CH4(end-100:end)); 

end

%Function for changing each parameters value by 1%
function [p] = change_value(p,var)
p.T=p.T*var(1);
p.P_atm=p.P_atm*var(2);
p.P_H2O=p.P_H2O*var(3);
p.k_1_2=p.k_1_2*var(4);
p.k_2_3=p.k_2_3*var(5);
p.k_3_1=p.k_3_1*var(6);
p.k_pump=p.k_pump*var(7);
p.k_La=p.k_La*var(8);
p.k_p=p.k_p*var(9);
p.k_ch=p.k_ch*var(10);
p.k_pr=p.k_pr*var(11);
p.k_li=p.k_li*var(12);
p.k_dec=p.k_dec*var(13);
p.q_in=p.q_in*var(14);
end

%New values positions
function [position] = ref_value(p,n_parametr)
position = zeros(1,n_parametr);
position(1)=p.T;
position(2)=p.P_atm;
position(3)=p.P_H2O;
position(4)=p.k_1_2;
position(5)=p.k_2_3;
position(6)=p.k_3_1;
position(7)=p.k_pump;
position(8)=p.k_La;
position(9)=p.k_p;
position(10)=p.k_ch;
position(11)=p.k_pr;
position(12)=p.k_li;
position(13)=p.k_dec;
position(14)=p.q_in;
end