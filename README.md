# ADM1 PMAD
Matlab implementations of Pomp-Mixed Anaerobic Digestion in [R4 simplifications of Anaerobic Digestion Model No. 1 (ADM1)](https://github.com/soerenweinrich/ADM1)
## Project description
Althought variouse ADM1 implementations are avaible, including important simplifications, the avaiblity of tools to simulate process modifications in AD is very limited. In this project, the model of Pomp-Mixed Anaerobic Digestion have been developed. The model consider 3-section structer of PM reactor to avoid partially differential equations. The project connect our previouse [EBS implementation](https://ich.postawa.eu/extended-biogas-simulator/) with simplicity and clarity of ADM1-R4, to make it more accesable for a wider audience. The overal concept of the model is presented below:

<p align="center"><img src="https://github.com/kar-pos/ADM1_PMAD/blob/main/Documentation/PMAD_reactor.png" width=50% height=50%></p>

The tool is desined to provide a support for design of instalation using novel AD method, where conventional stirrer is replaced with external pomp. This approach lets to limit energy consumption during fermemntation process, as well as improve overal efficiency by strong vertical mixing. The implementation is part of the Master Thesis of Eng. Justyna Małyszew, supervided by Dr Eng. Karol Postawa at [Wrocław University of Science and Technology](https://pwr.edu.pl/en/)

Alongside the [main model](https://github.com/kar-pos/ADM1_PMAD/tree/main/Pomp-mixed%20Anaerobic%20Digestion%20Mode) code, tools for [sensitivity analysis and model optimization](https://github.com/kar-pos/ADM1_PMAD/tree/main/Model%20optimization) are shared. Also an example ([case study](https://github.com/kar-pos/ADM1_PMAD/tree/main/Raw%20parameter%20optimization%20(case%20study))) of model utilization in optimization of process farameters for biogas plant design is provided.

## Literature
### Our implementations
Postawa, K., Małyszew, J., Jaroszewska, K., Wrzesińska-Jędrusiak, E., 2023. Adapting R4 simplifications of Anaerobic Digestion Model No. 1 (ADM1-R4) for pump-mixed biogas production. Fuel 351, 128794. https://doi.org/10.1016/j.fuel.2023.128794

Postawa K, Szczygieł J, Wrzesińska-Jędrusiak E, Klimek K, Kułażyński M. The pump-mixed anaerobic digestion of pig slurry: new technology and mathematical modeling. Waste Management 2021;123:111–9. https://doi.org/10.1016/j.wasman.2021.01.016.

Postawa K, Szczygieł J, Kułażyński M. Innovations in anaerobic digestion: a model-based study. Biotechnology for Biofuels 2021;14:19. https://doi.org/10.1186/s13068-020-01864-z.

Postawa K, Szczygieł J, Kułażyński M. Methods for anaerobic digestion model fitting—comparison between heuristic and automatic approach. Biomass Conv Bioref 2020. https://doi.org/10.1007/s13399-020-00945-1.

Postawa K, Szczygieł J, Kułażyński M. Heuristic methods in optimization of selected parameters of Two-Phase Anaerobic Digestion (TPAD) model. Fuel 2020;281:118257. https://doi.org/10.1016/j.fuel.2020.118257.

Postawa K, Szczygieł J, Kułażyński M. A comprehensive comparison of ODE solvers for biochemical problems. Renewable Energy 2020;156:624–33. https://doi.org/10.1016/j.renene.2020.04.089.

### ADM1-R4 implementation
Weinrich S, Nelles M. Systematic simplification of the Anaerobic Digestion Model No. 1 (ADM1) – Model development and stoichiometric analysis. Bioresource Technology 2021;333:125124. https://doi.org/10.1016/j.biortech.2021.125124.

Weinrich S, Mauky E, Schmidt T, Krebs C, Liebetrau J, Nelles M. Systematic simplification of the Anaerobic Digestion Model No. 1 (ADM1) – Laboratory experiments and model application. Bioresource Technology 2021;333:125104. https://doi.org/10.1016/j.biortech.2021.125104.

