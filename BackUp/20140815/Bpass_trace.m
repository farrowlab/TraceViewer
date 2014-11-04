function xf = Bpass_trace(x,srate,min_freq,max_freq)
% this hiasses the freq with an ellip filter
[b,a] = ellip(2,0.1,40,[min_freq,max_freq]*2/srate,'stop');
xf = filtfilt(b,a,x);