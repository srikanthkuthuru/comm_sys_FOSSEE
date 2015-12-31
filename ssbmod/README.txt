Instructions:
1) copy the .sci file in your working directory
2) enter command : exec('.sci file location', -1)

Example:
Fs=1000;
Fc=200;
t=0:1/Fs:1-1/Fs;
x=sinc(100*%pi*t)^2;
y=abs(fft(x));
N=length(t);
f=Fs*(-N/2:N/2-1)/N;
subplot(311);
plot(f,[y(N/2:$) y(1:N/2-1)]); title("spectrum of the baseband signal");
y2=abs(fft(x.*cos(2*%pi*Fc*t)));
subplot(312);
plot(f,[y2(N/2:$) y2(1:N/2-1)]); title("spectrum of the doublesided passband signal");
y3=abs(fft(ssbmod(x,Fc,Fs)));
subplot(313);
plot(f,[y3(N/2:$) y3(1:N/2-1)]); title("spectrum of the singlesided passband signal");
//written by Srikanth Kuthuru, FOSSEE, IIT Madras.
