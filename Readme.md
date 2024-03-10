<h1>A Real-Time QRS Detection Algorithm</h1>
<h2>Introduction</h2>
Arrhythmia is the condition of improper beating of the heart, wherein the heart beat could be irregular, too fast or too slow. During dire situations Arrhythmia monitors help in real time transmission of ECG signals to a hospital, while the patient is being moved over using an ambulance. A physician present at the respective hospital interprets the signal and thus gets time to make the necessary preparations before the arrival of the patient. The QRS complex found within ECG signals is useful in diagnosing cardiac arrhythmias, conduction abnormalities, ventricular hypertrophy, myocardial infarction, electrolyte derangements, and other disease states. QRS complex is a name given to the combination of three graphical deflections seen on a typical electrocardiogram - please refer the diagram below. <ins><b>This project illustrates the precise algorithm used in real time detection of such QRS signals, which helps in cutting down on the physician's effort and memory required to store complete ECG segments.</b></ins>
<br><br>
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot.jpg" width = 800 height = 400><br>
</p>
<h2>Code execution steps</h2>
Run the following matlab file: ECG_signal

<h3>Input</h3>

Select one of three database signals:
1) Enter 1 for 100m file
2) Enter 2 for 101m file
3) Enter 3 for 102m file

<h3>Output</h3>

The total number of heart beats and heart rate is provided as output within the command line. Seven figures are also generated as output in the following order:
1) Initial Signal
2) Low pass filter output
3) Band pass filter output
4) Differentiated output of the above signal
5) Squared output of the above signal
6) Final Output through integrator
7) Complete lifecycle discussed above within a single figure

The algorithm executes in the following order:

<h2>Selection of the input ECG signal</h2>

```
Taking the input:
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
```
<h2>Initial processing of the selected signal</h2>

```
val = (val-1024)/200;
E = val(1,1:650000);
E = 5.2+E;
fs = 360;
t = (0:length(E)-1)/fs;
figure; plot(t,E)
xlabel("Time"), ylabel("Signal")
title("Initial Signal")
```

<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot1.jpg" width = 650 height = 400><br>
</p>
<h2>Low pass filtering of the selected signal</h2>

```
a = [1,0,0,0,0,0,-2,0,0,0,0,0,1];
b = [1,-2,1];
E =filter(a,b,E);
figure; plot(t,E)
xlabel("Time"), ylabel("Signal")
title("Low pass filtered signal")
```
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot2.jpg" width = 650 height = 400><br>
</p>
<h2>High pass filtering of low pass filtered signal (Band pass filtering)</h2>

```
c=[-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
d=[1,1];
E =filter(c,d,E);
figure; plot(t,E)
xlabel("Time"), ylabel("Signal")
title("Band pass filtered signal")
```
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot3.jpg" width = 650 height = 400><br>
</p>
<h2>Differentiation</h2>

```
y = 0;
x = E;
for i=3:length(E)-2
y(i) = (fs/8).*(-x(i-2)-2*x(i-1)+2*x(i+1)+x(i+2));
end
E=y;
figure; plot(E)
xlabel("Time"), ylabel("Signal")
title("Differentiator output of band pass filtered signal")
```
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot4.jpg" width = 650 height = 400><br>
</p>

<h2>Squaring</h2>

```
E= E.^2;
figure; plot(E)
xlabel("Time"), ylabel("Signal")
title("Squared output of differentiated and band pass filtered signal")
```
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot5.jpg" width = 650 height = 400><br>
</p>
<h2>Moving Window Integration</h2>

```
f=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
g=[1];
E=filter(f,g,E);
figure; plot(E)
xlabel("Time"), ylabel("Signal")
title("Output of signal passed through moving window integrator")
```
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot6.jpg" width = 650 height = 400><br>
</p>
<h2>Complete lifecycle discussed above within a single figure</h2>
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot7.jpg" width = 650 height = 400><br>
</p>
<h2>References</h2>

1) https://www.physionet.org/physiobank/database/mitdb/
2) https://archive.ics.uci.edu/ml/datasets/arrhythmia
3) https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=4122029
4) https://stackoverflow.com/questions/6283929/load-mit-bih-arrhythmia-ecg-database-onto-matlab
5) http://physionet.org/cgi-bin/atm/ATM
6) https://ecgwaves.com/
