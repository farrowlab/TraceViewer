function [dout] = FourierAnalysisYC(DD,params)

%----- Initiate -----%
assignin('base','DD',DD)
dsize = params.data_size;
srate=params.srate;
time = (0:dsize(1)-1)./srate;
signal = DD;


%----- Make rasterplot -----%
if params.spikes
    fh = figure('Position',[100 100 1000 300],'Color','w'); % ----- Define Figure -----%
    figure(fh);
    plot(time,signal);
              
end
            


%----- Covolution of singal (spike or analogue) -----%
if params.spikes
    sigma = .01; % Standard deviation of the kernel = 10 ms
    edges = [-4*sigma:1/srate:4*sigma];    % Time ranges form -4*st. dev. to 4*st. dev.
    kernel = normpdf(edges,0,sigma); %Evaluate the Gaussian kernel
    signal = conv(signal,kernel,'same');
    fh = figure('Position',[100 100 1000 300],'Color','w'); % ----- Define Figure -----%
    figure(fh);
    plot(time,signal);
    title('{\bfCovolution of spike}','FontSize',18);
    set(gca,'FontSize',18,'LineWidth',2); axis tight;
    xlabel('Time (s)','FontSize',18);
    ylabel('Firing rate (spikes/s)','FontSize',18);
   
end


%-----Fourier Transformation----%
NFFT=2^nextpow2(length(time));
freq=(srate/2)*linspace(0,1,NFFT/2+1); % Linearly spaced frequency vector scaled by the Nyquist limit
dout =fft(signal,NFFT)/length(time);


% ---Power Analysis -----%
% xdft=fft(c);
% xdft=xdft(1:length(c)/2+1);
% per=1/(srate*length(c))*abs(xdft).^2;
% freq2=0:srate/length(c):srate/2;
% n = pow2(nextpow2(length(time)));
% y = fft(c,n);
% f = (0:n-1)*(srate/n);
% power = y.*conj(y)/n;



%subplot(3,1,2)
%plot(time,c);
%title('{\bfConvolution of signal}')
%xlabel('Time (s)')
%Plot single-sided amplitude spectrum
fh = figure('Position',[100 100 1000 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
Amp = 2*abs(dout(1:NFFT/2+1));
plot(freq, Amp)
title('{\bfAmplitude Spectrum}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2); axis tight;
xlabel('Frequency (Hz)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0 20]);

temfreq = 2;
F0 = Amp(find(freq == 0));
F1 = max (Amp (find(freq < temfreq + 0.2 & freq > temfreq - 0.2)));
F2 = max (Amp(find(freq < 2*temfreq + 0.2 & freq > 2*temfreq - 0.2)));
Famp = [F0,F1,F2]'
dlmwrite('/media/NERFFS01/Data/00132/Analyzed/FFT.txt', Famp, '-append', 'delimiter', ' ', 'roffset',1);
type('/media/NERFFS01/Data/00132/Analyzed/FFT.txt');

