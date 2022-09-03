%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

function [dx,q_gas,pCH4g,pCO2g] = optimalisation_modelv2(~,x,p,o)

%Optimalised values
T=o(1);
q_in=o(2);

%Henry's constants of gas products and water pressure (has to be calculated in this file due to optimalised T value)
K_H_CO2	=0.035*exp(p.deltaH0_KH_co2/(p.R*100)*(1/p.T_baz-1/T));	%mol m^-3 bar^-1
K_H_CH4	=0.0014*exp(p.deltaH0_KH_ch4/(p.R*100)*(1/p.T_baz-1/T)); %mol m^-3 bar^-1
P_H2O     =0.0331*exp(5290*(1/p.T_baz-1/T)); %bar
 
%Pressures of gas products
p_ch4 = x(9)*p.R*T/16; 
p_co2 = x(10)*p.R*T/44; 
p_gas = p_ch4 + p_co2 + P_H2O ; 

%Limiting condition
if p_gas/p.P_atm >  1
q_gas = p.k_p * ( p_gas - p.P_atm) *p_gas/p.P_atm; 
else
    q_gas=0;
end

%Gas streams and percentage content of gas products
q_gas_CH4=p_ch4/p_gas*q_gas;
q_gas_CO2=p_co2/p_gas*q_gas;
pCH4g=q_gas_CH4/q_gas;
pCO2g=q_gas_CO2/q_gas;

% Rate equations for the 1st part of reactor
 
rate(1) = p.k_ch * x(5); 
rate(2) = p.k_pr * x(6); 
rate(3) = p.k_li * x(7); 
rate(4) = p.k_dec * x(8); 
rate(5) = p.k_La*(x(1) -16*(K_H_CH4*p_ch4)); 
rate(6) = p.k_La*(x(2) - 44*(K_H_CO2*p_co2)); 

% Rate equations for the 2nd part of reactor
rate(7) = p.k_ch * x(15); 
rate(8) = p.k_pr * x(16); 
rate(9) = p.k_li * x(17); 
rate(10) = p.k_dec * x(18); 

% Rate equations for the 3rd part of reactor
rate(11) = p.k_ch * x(23); 
rate(12) = p.k_pr * x(24); 
rate(13) = p.k_li * x(25); 
rate(14) = p.k_dec * x(26); 

%Transfer liq-liq between 1st and 2nd part of reactor
rate(15)=p.k_1_2*(x(1)-x(11));
rate(16)=p.k_1_2*(x(2)-x(12));
rate(17)=p.k_1_2*(x(3)-x(13));
rate(18)=p.k_1_2*(x(4)-x(14));
rate(19)=p.k_1_2*(x(5)-x(15));
rate(20)=p.k_1_2*(x(6)-x(16));
rate(21)=p.k_1_2*(x(7)-x(17));
rate(22)=p.k_1_2*(x(8)-x(18));

%Transfer liq-liq between 2nd and 3rd part of reactor 
rate(23)=p.k_2_3*(x(11)-x(19));
rate(24)=p.k_2_3*(x(12)-x(20));
rate(25)=p.k_2_3*(x(13)-x(21));
rate(26)=p.k_2_3*(x(14)-x(22));
rate(27)=p.k_2_3*(x(15)-x(23));
rate(28)=p.k_2_3*(x(16)-x(24));
rate(29)=p.k_2_3*(x(17)-x(25));
rate(30)=p.k_2_3*(x(18)-x(26));

%Transfer liq-liq between 3rd and 1st part of reactor
rate(31)=p.k_3_1*(x(19)-x(1));
rate(32)=p.k_3_1*(x(12)-x(20));
rate(33)=p.k_3_1*(x(13)-x(21));
rate(34)=p.k_3_1*(x(14)-x(22));
rate(35)=p.k_3_1*(x(15)-x(23));
rate(36)=p.k_3_1*(x(16)-x(24));
rate(37)=p.k_3_1*(x(17)-x(25));
rate(38)=p.k_3_1*(x(18)-x(26));

% Process equations summary for each compound in the 1st part of reactor
 
process(1) =  0.24819 * rate(1) +  0.32208 * rate(2) +  0.63928 * rate(3) - rate(5)-rate(15)+p.k_pump*rate(31); 
process(2) =  0.68087 * rate(1) +  0.79543 * rate(2) +  0.58172 * rate(3) - rate(6)-rate(16)+p.k_pump*rate(32); 
process(3) =  -0.02065 * rate(1) +  0.16892 * rate(2) -0.034418 * rate(3)-rate(17)+p.k_pump*rate(33); 
process(4) =  -0.045576 * rate(1) -0.45876 * rate(2) -0.41518 * rate(3)-rate(18)+p.k_pump*rate(34); 
process(5) =  - rate(1) +  0.18 * rate(4)-rate(19)+p.k_pump*rate(35); 
process(6) =  - rate(2) +  0.77 * rate(4)-rate(20)+p.k_pump*rate(36); 
process(7) =  - rate(3) +  0.05 * rate(4)-rate(21)+p.k_pump*rate(37); 
process(8) =  0.13716 * rate(1) +  0.17233 * rate(2) +  0.2286 * rate(3) - rate(4)-rate(22)+p.k_pump*rate(38); 
process(9) =  (p.V_liq/p.V_gas) * rate(5); 
process(10) =  (p.V_liq/p.V_gas) * rate(6); 

% Process equations summary for each compound in the 2nd part of reactor
process(11) =  0.24819 * rate(7) +  0.32208 * rate(8) +  0.63928 * rate(9)-rate(23)+rate(15); 
process(12) =  0.68087 * rate(7) +  0.79543 * rate(8) +  0.58172 * rate(9)-rate(24)+rate(16); 
process(13) =  -0.02065 * rate(7) +  0.16892 * rate(8) -0.034418 * rate(9)-rate(25)+rate(17); 
process(14) =  -0.045576 * rate(7) -0.45876 * rate(8) -0.41518 * rate(9)-rate(26)+rate(18); 
process(15) =  - rate(7) +  0.18 * rate(10)-rate(27)+rate(19); 
process(16) =  - rate(8) +  0.77 * rate(10)-rate(28)+rate(20); 
process(17) =  - rate(9) +  0.05 * rate(10)-rate(29)+rate(21); 
process(18) =  0.13716 * rate(7) +  0.17233 * rate(8) +  0.2286 * rate(9) - rate(10)-rate(30)+rate(22); 

% Process equations summary for each compound in the 3rd part of reactor
process(19) =  0.24819 * rate(11) +  0.32208 * rate(12) +  0.63928 * rate(13)+rate(23)-p.k_pump*rate(31); 
process(20) =  0.68087 * rate(11) +  0.79543 * rate(12) +  0.58172 * rate(13)+rate(24)-p.k_pump*rate(32); 
process(21) =  -0.02065 * rate(11) +  0.16892 * rate(12) -0.034418 * rate(13)+rate(25)-p.k_pump*rate(33); 
process(22) =  -0.045576 * rate(11) -0.45876 * rate(12) -0.41518 * rate(13)+rate(26)-p.k_pump*rate(34); 
process(23) =  - rate(11) +  0.18 * rate(14)+rate(27)-p.k_pump*rate(35); 
process(24) =  - rate(12) +  0.77 * rate(14)+rate(28)-p.k_pump*rate(36); 
process(25) =  - rate(13) +  0.05 * rate(14)+rate(29)-p.k_pump*rate(37); 
process(26) =  0.13716 * rate(11) +  0.17233 * rate(12) +  0.2286 * rate(13) - rate(14)+rate(30)-p.k_pump*rate(38); 

 
% Differential equations for 1st part of reactor
 
dx(1,1) = 3*q_in*(p.S_CH4_1_in - 0)/p.V_liq + process(1); 
dx(2,1) = 3*q_in*(p.S_IC_1_in - 0)/p.V_liq + process(2); 
dx(3,1) = 3*q_in*(p.S_IN_1_in - 0)/p.V_liq + process(3); 
dx(4,1) = 3*q_in*(p.S_H2O_1_in - 0)/p.V_liq + process(4); 
dx(5,1) = 3*q_in*(p.X_Ch_1_in - 0)/p.V_liq + process(5); 
dx(6,1) = 3*q_in*(p.X_Pr_1_in - 0)/p.V_liq + process(6); 
dx(7,1) = 3*q_in*(p.X_Li_1_in - 0)/p.V_liq + process(7); 
dx(8,1) = 3*q_in*(p.X_Bac_1_in - 0)/p.V_liq + process(8); 
dx(9,1) = - x(9) * q_gas / p.V_gas + process(9); 
dx(10,1) = - x(10) * q_gas / p.V_gas + process(10); 

% Differential equations for 2nd part of reactor
dx(11,1) = 3*q_in*(0 )/p.V_liq + process(11); 
dx(12,1) = 3*q_in*(0 )/p.V_liq + process(12); 
dx(13,1) = 3*q_in*(0 )/p.V_liq + process(13); 
dx(14,1) = 3*q_in*(0 )/p.V_liq + process(14); 
dx(15,1) = 3*q_in*(0 )/p.V_liq + process(15); 
dx(16,1) = 3*q_in*(0 )/p.V_liq + process(16); 
dx(17,1) = 3*q_in*(0 )/p.V_liq + process(17); 
dx(18,1) = 3*q_in*(0 )/p.V_liq + process(18); 

% Differential equations for 3rd part of reactor
dx(19,1) = 3*q_in*(0 - x(19))/p.V_liq + process(19); 
dx(20,1) = 3*q_in*(0 - x(20))/p.V_liq + process(20); 
dx(21,1) = 3*q_in*(0 - x(21))/p.V_liq + process(21); 
dx(22,1) = 3*q_in*(0 - x(22))/p.V_liq + process(22); 
dx(23,1) = 3*q_in*(0 - x(23))/p.V_liq + process(23); 
dx(24,1) = 3*q_in*(0 - x(24))/p.V_liq + process(24); 
dx(25,1) = 3*q_in*(0 - x(25))/p.V_liq + process(25); 
dx(26,1) = 3*q_in*(0 - x(26))/p.V_liq + process(26); 
