function [dout] = meanK(dd,par)

%----- Initiate -----%
[X Y] = size(dd);


%----- Take Mean of Each Trace -----%
for n = 1:Y
    dout(n) = mean(dd(:,n));
end