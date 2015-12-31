function [y] = ssbmod(x,Fc,Fs,varargin)

//Single Sideband Amplitude Modulation

//y = ssbmod(x,Fc,Fs)
//modulates the carrier wave of frequency Fc with message signal x using single sideband amplitude modulation. 'x' and 'carrier wave' have a sampling frequency of Fc.

//y = ssbmod(x,Fc,Fs,INI_PHASE)
//specifies the initial phase of the modulated signal

//y = ssbmod(x,Fc,Fs,INI_PHASE,'upper')
//gives the upper sideband
//Default: Gives the lower side band

//Fs must satisfy Fs > 2*(Fc + BW), where BW = Bandwidth of x

//Example:
//Fs=1000;
//Fc=200;
//t=0:1/Fs:1-1/Fs;
//x=sinc(100*%pi*t)^2;
//y=abs(fft(x));
//N=length(t);
//f=Fs*(-N/2:N/2-1)/N;
//subplot(311);
//plot(f,[y(N/2:$) y(1:N/2-1)]); title("spectrum of the baseband signal");
//y2=abs(fft(x.*cos(2*%pi*Fc*t)));
//subplot(312);
//plot(f,[y2(N/2:$) y2(1:N/2-1)]); title("spectrum of the doublesided passband signal");
//y3=abs(fft(ssbmod(x,Fc,Fs)));
//subplot(313);
//plot(f,[y3(N/2:$) y3(1:N/2-1)]); title("spectrum of the singlesided passband signal");

//References:
//https://en.wikipedia.org/wiki/Single-sideband_modulation

//See also ammod
//written by Srikanth Kuthuru, FOSSEE, IIT Madras.

[ll, rr] = argn(0);
funcprot(0);
//Check number of Arguments
if (rr > 5) then
    error("Too many input arguments");
end

//Check for x and Fc
if (~isreal(x)) then
    error("X must be real");
end
if (~isreal(Fc) | ~(length(Fc))==1 | Fc<=0)
    error("Fc must be a real, positive scalar");
end
if(Fs < 2*Fc) then
    error("Fs must be atleast 2*Fc");
end

//check for INI_PHASE
ini_phase = 0;
if(rr>=4)
    ini_phase = varargin(1);
    if isempty(ini_phase) then
        ini_phase = 0;
    elseif (~isreal(ini_phase) | ~(length(ini_phase))==1)
        error("INI_PHASE must be a real scalar"); 
    end
end

//check for LSB or USB(upper side band).
side = ''; //upper side or lower side
if(rr == 5) then
    side = varargin(2);
    if(~strcmpi(side,'upper')) then
        error("invalid input argument");
    end
end
//END of parameter checks

//Check if x is one dimensional
wid = size(x,1);
if (wid==1)
    x = x(:);
end

t = (0:1/Fs:(size(x,1)-1)/Fs)';

if(strcmpi(side,'upper')) then
    //Upper sideband
    y = 0.5 *x.*cos(2 * %pi * Fc * t + ini_phase) - 0.5 *imag(hilbert(x) .* sin(2 * %pi * Fc * t + ini_phase));
else
    //lower sideband
    y = 0.5 *x.*cos(2 * %pi * Fc * t + ini_phase) + 0.5 *imag(hilbert(x) .* sin(2 * %pi * Fc * t + ini_phase));
end

//Restoring original orientation i.e row orientation
if(wid == 1)
    y = y';
end

endfunction
