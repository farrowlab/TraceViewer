function [spks,tEnd,spks_during_stim,spks_per_cycle] = processGratingStationary(spks,visSyncT,prot)
% Processes data from Class 'Grating' type 'Stationary'
% [spks,tEnd,spks_during_stim,spks_per_cycle] = processGratingStationary(spks,visSyncT,prot)
%
% J Couto 19 Sep 2014

if ~strcmp(lower(prot.Class),'grating') || ...
        ~strcmp(lower(prot.Type),'stationary')
    fprintf(1,'Wrong protocol (%s,%s)\n',prot.Class,prot.Type)
    return 
end

% idx = find(visSyncT>= prot.PreTime);
% tStart = visSyncT(idx(1));
% tStop = visSyncT(idx(end));
tStart = visSyncT(1);
tStop = visSyncT(end);
tEnd = tStop - tStart - prot.PostTime;
spks = spks - tStart;
tf = prot.TemporalFreq;
spks_during_stim = spks(spks>=prot.PreTime & spks<=(prot.PreTime + prot.StimTime));
spks_per_cycle = mod(spks_during_stim, 1./tf);
