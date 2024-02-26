<h1>A Real-Time QRS Detection Algorithm</h1>
<h2>Introduction</h2>
The QRS complex is a name for the combination of three of the graphical deflections seen on a typical electrocardiogram (EKG or ECG). It corresponds to the depolarization of the right and left ventricles of the human heart.
Arrhythmia is the condition of improper beating of the heart, whether irregular, too fast or too slow. Arrhythmia monitors help in real time checking and transmission of abnormal ECG signals to a central station, during the time the patient is moved over to the hospital in an ambulance. A physician present at the respective station interprets the said signal and thus, gets time to make the necessary preparations before the arrival of the patient.
Precision of such devices is a necessity, otherwise false data gets transmitted to the station which not help the physician. Also, large memory is required to store the ECG segments which are unnecessarily captured.
<br><br>
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot.jpg" width = 800 height = 400><br>
</p>
<br>

<h2>Code execution steps</h2>
Run the matlab file ECG_signal

To select one of three database signals:
1) Enter 1 for 100m file
2) Enter 2 for 101m file
3) Enter 3 for 102m file

Six figures are shown as output:
Figure 1) : Initial Signal
Figure 2) : Low pass filter output
Figure 3) : Band pass filter output
Figure 4) : Differentiated output of the above signal
Figure 5) : Squared output of the above signal
Figure 6) : Final Output through integrator

The total number of beats and heart rate is displayed in the command window  

<h2>Processing of the given signal</h2>

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
<h2>Corresponding database signal</h2>

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
Note : All the signals shown here are zoomed in to visualize the results properly.
<p align = "center">
<img src = "https://github.com/PratikPuri/Realtime-QRS-Complex-Detection/blob/master/images/plot1.jpg" width = 650 height = 400><br>
</p>
<h2>Low pass filtering</h2>

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
• Differentiator:

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
<h2>Combined Processing of signal</h2>
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
