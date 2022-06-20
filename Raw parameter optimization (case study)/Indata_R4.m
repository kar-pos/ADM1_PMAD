%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

function [p]=Indata_R4
%Physiochemical variables 
%Parameter      Value       Unit
p.R         =0.083145;	%bar m^3 M^-1 K^-1
p.T_baz		=298.15;    %K
p.deltaH0_KH_ch4=-14240;
p.deltaH0_KH_co2=-19410;
p.P_atm		=1.013;     %bar
p.k_3_1		=0.204;     %-
p.k_La     =200;   %d^-1
%Optimalised values of model parameters different for each mixing time
p.k_1_2		=0.1652;    %-
p.k_2_3		=0.8752;    %-
p.k_pump	=0.0427;    %-
p.k_p		=0.1001;    %m^3 d^−1 bar^−1
%Physical values
%Parameter	Value           Unit
p.V_liq		=75;        %dm^3
p.V_gas		=65;        %dm^3 
%Biochemical processes parameters
%Parameter  Value           Unit
p.k_ch     =0.25;       %d^-1
p.k_pr      =0.2;       %d^-1
p.k_li      =0.1;       %d^-1
p.k_dec     =0.02;      %d^-1
%Steady state values
%Parameter	Value           Unit
p.S_CH4_1_in=0;         %kgCOD/m^3
p.S_IC_1_in=0;          %kgCOD/m^3
p.S_IN_1_in=0;          %kgCOD/m^3
p.S_H2O_1_in=956.9610;  %kgCOD/m^3
p.X_Ch_1_in=9.393755;   %kgCOD/m^3
p.X_Pr_1_in=5.344;      %kgCOD/m^3
p.X_Li_1_in=11.68078;   %kgCOD/m^3
p.X_Bac_1_in=0;         %kgCOD/m^3