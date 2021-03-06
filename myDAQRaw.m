%myDAQRaw.m
clear all
close all

filename = input('File name: ','s');

plot_accel = 0;
plot_sound = 1;
plot_fft = 1;
plot_phase_shift = 1;

rawdat = importdata(filename);

tt = rawdat(:,1);

speaker1 = rawdat(:,2);
speaker2 = rawdat(:,3);
mic1 = rawdat(:,4);
mic2 = rawdat(:,5);
%accelx = rawdat(:,6);





if plot_accel
    accel = figure;
    plot(tt,accel_x);
    ylim([0.7 1]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw X Axis Accelerometer Data');
end

if plot_sound
    sound = figure;
    subplot(2,1,1)
    plot(tt,speaker1);
    hold on
    plot(tt,mic1,'r');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    axis([1 1.01 0 4]);
    title('Speaker/Mic #1 Raw Data');
    legend('Speaker Data','Mic Data');
    
    subplot(2,1,2);
    plot(tt,speaker2,'k');
    hold on
    plot(tt,mic2,'r');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    axis([1 1.01 0 4]);
    title('Speaker/Mic #2 Raw Data');
    legend('Speaker Data','Mic Data');
    
end

if plot_fft
    fft1 = figure;
    subplot(2,2,1)
    [f1s,X1s]=FFTrange(tt(1:2000),speaker1(1:2000),100,10000);
    plot(f1s,abs(X1s));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Speaker #1 FFT');
    
    subplot(2,2,2)
    [f1m,X1m]=FFTrange(tt(1:2000),mic1(1:2000),100,10000);
    plot(f1m,abs(X1m));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Mic #1 FFT');
    
    subplot(2,2,3)
    [f1s,X1s]=FFTrange(tt(1:2000),speaker2(1:2000),100,10000);
    plot(f1s,abs(X1s));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Speaker #2 FFT');
    
    subplot(2,2,4)
    [f1m,X1m]=FFTrange(tt(1:2000),mic2(1:2000),100,10000);
    plot(f1m,abs(X1m));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Mic #2 FFT');
end

if plot_phase_shift
    phase = figure;
    subplot(2,2,1)
    [T1,ph1,f1] = getPhaseDiff([tt,speaker1],[tt,mic2],2000,2200);
    ph_filt1 = filter(.5, [1 -.5], ph1);
    plot(T1,ph1);
    subplot(2,2,2)
    plot(T1,f1)
    
    
    subplot(2,2,3)
    [T2,ph2,f2] = getPhaseDiff([tt,speaker2],[tt,mic1],1700,1900);
    ph_filt2 = filter(.5, [1 -.5], ph2);
    plot(T2,ph2);
    subplot(2,2,4)
    plot(T2,f2)
end

