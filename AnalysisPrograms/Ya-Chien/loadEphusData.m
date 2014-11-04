function [data, prot] = loadEphusData(filename)
% Wrapper to load data from ephus
%
% Returns a data array with each trace in a structure that has fields:
%   - srate       sampling rate (taken from header.ephys.ephys.sampleRate)
%   - data        recorded datapoints
%   - name        assigned channel name

% The function also searches for a string in:
%                   header.headerGUI.headerGUI.whatTreatment
% and tries to read protocol data from that string.
%
% USAGE:
%  [ent, prot] = loadEphusData(filename)
%   plot([ent.data])
%

%   J Couto 19 Sep 2014


data = [];
prot = [];

if ~exist(filename,'file')
    fprintf(1,'File (%) does not exist?')
end

tmp = load(filename,'-mat');
data = [];
for f = fields(tmp.data)'
    entity.srate = tmp.header.ephys.ephys.sampleRate;
    entity.data = tmp.data.(f{1}).trace_1;
    
    if ~isempty(tmp.data.(f{1}).amplifierName_1)
        entity.name = tmp.data.(f{1}).amplifierName_1;
    else
        entity.name = tmp.data.(f{1}).channelName_1;
    end
    data = [data,entity];
end

str = tmp.header.headerGUI.headerGUI.whatTreatment;
clear tmp
if ~isempty(str) && ~isempty(strfind(str,';'))
    % Then append the protocol information
    str = strsplit(str,';');
    for s = str
        if ~isempty(strfind(s{1},':'))
            ss = strsplit(s{1},':');
            % Remove strange characters that I don't know why are there...
            ss{2}(strfind(ss{2},'_')) = [];
            tmp.(ss{1}) = str2num(ss{2});
            if isempty(tmp.(ss{1}))
                tmp.(ss{1}) = ss{2};
            end
        end
    end
    prot = tmp;
end

