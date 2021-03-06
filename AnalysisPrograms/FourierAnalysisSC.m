function [dout] = FourierAnalysisSC(DD,params)

%----- Initiate -----%
assignin('base','DD',DD)
dsize = params.data_size;
srate=params.srate;
time = (0:dsize(1)-1)./srate;
spkidx = DD{1};
spks = zeros(dsize(1),1);
spks(spkidx) = 1;

%----- Make Spike Train -----%
windowsize = .05; % seconds
gwin = -3*windowsize:1/srate:3*windowsize;    % set range
gwin = exp(-gwin.^2/(2*windowsize^2)); % calc gauss
gwin = gwin(gwin > 0.01);       % drop too small values
gwin = gwin' / sum(gwin);        % normalize  
c = conv(spks,gwin,'same');

%-----Fourier Analysis----%
NFFT=2^nextpow2(length(time)-1);
freq=((srate/2)*linspace(0,1,NFFT/2+1));
dout =fft(c,NFFT)/(length(c)-1);  

% ---Power Analysis -----%
xdft=fft(c);
xdft=xdft(1:length(c)/2+1);
per=1/(srate*length(c))*abs(xdft).^2;
freq2=0:srate/length(c):srate/2;


figure;
subplot(2,1,1)
plot(time,c);
xlabel('Time(s)')

subplot(2,1,2)
plot(freq, 2*abs(dout(1:NFFT/2+1)))
title('FFT of spikes')
xlabel('Frequency (Hz)')
ylabel('Magnitude') % Same units of the input
xlim([.01 50]);



