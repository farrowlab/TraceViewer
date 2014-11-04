function xf = Bstop_trace(x,srate,min_freq,max_freq)
% 
% Bstop_trace(x,srate,min_freq,max_freq)

[b,a] = butter(2,[min_freq,max_freq]/(srate/2),'stop');
xf = filtfilt(b,a,x);
%% DEBUG!
%min_freq = 45
%max_freq = 55
%%[b,a] = ellip(2,0.1,40,[min_freq,max_freq]*2/srate,'stop');
% [b,a] = butter(2,[min_freq,max_freq]/(srate/2),'stop');
% 
% xf = filtfilt(b,a,x);
% subplot(2,1,1), hold all
% plot(x)
% plot(xf)
% subplot(2,1,2),hold all
% plot(linspace(-1*srate/2,+srate/2,length(x)),abs(fftshift((fft(x)))))
% plot(linspace(-1*srate/2,+srate/2,length(x)),abs(fftshift((fft(xf)))))
% 
% xlim([-100,100])
% ylim([-200,20000])
