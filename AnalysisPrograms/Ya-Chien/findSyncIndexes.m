function syncIdx = findSyncIndexes(X, MIN_INTER_SAMPLE)
% Extracts the indexes where X crosses half of the maximal height of the
% signal.
%       - X                        sampled data
%       - MIN_INTER_SAMPLE         number of dead samples 
%                                  (equivalent to detector deadtime)
%
% USAGE:
%  syncIdx = findSyncIndexes(X, MIN_INTER_SAMPLE)
%

%   J Couto 19 Sep 2014

if ~exist('MIN_INTER_SAMPLE','var')
    MIN_INTER_SAMPLE = 15;
end

syncIdx = [];
% Find the indexes where the value is above half the width
idx = find(X>(mean(X)+(max(X) - min(X))/2));
if isempty(idx)
    return
else
    % Make sure you have only the first samples to cross (given a dead number of samples)
    syncIdx = [idx(1)];
    for ii = 2:(length(idx))
        if (idx(ii) - idx(ii-1)) > MIN_INTER_SAMPLE
            syncIdx = [syncIdx, idx(ii)];
        end
    end
end

% figure(1)
% plot(X)
% hold on
% plot(syncIdx,X(syncIdx),'ko')
% pause
% clf