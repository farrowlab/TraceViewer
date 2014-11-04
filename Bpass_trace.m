function xf = Bpass_trace(x,srate,min_freq,max_freq)
% this hiasses the freq with an ellip filter
% Bpass_trace(x,srate,min_freq,max_freq)
[b,a] = ellip(2,0.1,40,[min_freq,max_freq]*2/srate,'bandpass');
xf = filtfilt(b,a,x);
%% DEBUG!
% figure(1)
% clf
% subplot(2,1,1), hold all
% plot(x)
% plot(xf)
% subplot(2,1,2),hold all
% plot(linspace(-1*srate/2,+srate/2,length(x)),abs(fftshift((fft(x)))))
% plot(linspace(-1*srate/2,+srate/2,length(x)),abs(fftshift((fft(xf)))))
% 
% xlim([-100,100])
% ylim([-200,20000])
