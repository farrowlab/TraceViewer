function [dout] = stdK(dd,par)

%----- Initiate -----%
[X Y] = size(dd);


%----- Take Mean of Each Trace -----%
for n = 1:Y
    dout(n) = std(dd(:,n));
end

assignin('base','dout',dout);