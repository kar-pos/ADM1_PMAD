%Master thesis by eng. Justyna Małyszew
%University of Science and Technology in Wrocław
%Department of Chemistry 
%Chemical Technology major
%Supervisor Dr eng. Karol Postawa 

%reproductivity set as default
rng default

%import of objectiv function
fun=@objectiv;

%Plot of algorithm's best, worst and mean solution
opcje=optimoptions('ga','Display','iter','PlotFcn',@gaplotrange,'MaxGenerations',150);

%Optimalisation algorithm with time measurement
tic
[o,fval] = ga(fun,4,[],[],[],[],[0 0 0 0],[1 1 1 10],[],[],opcje)
toc
