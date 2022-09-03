%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

%reproducvitiy set as default
rng default

%import of objectivity function
fun=@objectiv;

%Plot of algorithm's best, worst and mean solution
opcje=optimoptions('ga','Display','iter','PlotFcn',@gaplotrange,'MaxGenerations',150);

%Optimalisation algorithm with time measurement (T searched in range 298.15-318.15; q_in search in range 2.5-15)
tic
[o,fval] = ga(fun,2,[],[],[],[],[298.15 2.5],[318.15 15],[],[],opcje)
toc
