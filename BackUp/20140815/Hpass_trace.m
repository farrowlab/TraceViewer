function xf = hpass_trace(x,srate,min_freq)
% this hiasses the freq with an ellip filter
[b,a] = ellip(2,0.1,40,[min_freq]*2/srate,'high');
xf = filtfilt(b,a,x);
