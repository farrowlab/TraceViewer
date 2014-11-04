function xf = Lpass_trace(x,srate,max_freq)
% this hiasses the freq with an ellip filter
[b,a] = ellip(2,0.1,40,[max_freq]*2/srate,'low');
xf = filtfilt(b,a,x);