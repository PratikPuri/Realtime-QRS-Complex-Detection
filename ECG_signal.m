disp('1: 100m')
disp('2: 101m')
disp('3: 102m')
t1='Select one of the above database files by entering their corresponding index : ';
f=input(t1);

if f == 1
    load ('100m.mat') %the signal gets loaded in the val matrix
elseif f == 2
    load ('101m.mat')
elseif f == 3
    load ('102m.mat')
end

%Specifying the signal values
val = (val-1024)/200;
E = val(1,1:650000); 
E = 5.2+E;
fs = 360;
t = (0:length(E)-1)/fs;
figure; plot(t,E)
xlabel("Time"), ylabel("Signal")
title("Initial Signal")

%Low Pass Filter
a = [1,0,0,0,0,0,-2,0,0,0,0,0,1];
b = [1,-2,1];
E =filter(a,b,E);
figure; plot(t,E)
xlabel("Time"), ylabel("Signal")
title("Low pass filtered signal")

%High Pass Filter
c=[-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
d=[1,1];
E =filter(c,d,E);
figure; plot(t,E)
xlabel("Time"), ylabel("Signal")
title("Band pass filtered signal")

%Differentiator
y = 0;
x = E;
for i=3:length(E)-2
    y(i) = (fs/8).*(-x(i-2)-2*x(i-1)+2*x(i+1)+x(i+2));
end
E=y;
figure; plot(E)
xlabel("Time"), ylabel("Signal")
title("Differentiator output of band pass filtered signal")

%Squaring
E= E.^2;
figure; plot(E)
xlabel("Time"), ylabel("Signal")
title("Squared output of differentiated and band pass filtered signal")

%Moving Window Integration
f=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
g=[1];
E=filter(f,g,E);
figure; plot(E)
xlabel("Time"), ylabel("Signal")
title("Output of signal passed through moving window integrator")

%Total Number Of Beats
pks = findpeaks(E,'MinPeakProminence',2*(10^9));
disp("The total number of beats are : "), length(pks)
disp("The heartrate is : "), (length(pks)/(1806/60))