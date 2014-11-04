%   J Couto 19 Sep 2014

clear all
folder = '/media/NERFFS01/Data/00137/Raw/20140908/YC0001/';

% cd(folder)

VNAME = '700B-1';
SYNCNAME = 'VisSync';

files = dir('*.xsg');
files = {files.name}';

% Load all the data in this folder
counter = 0;
fprintf(1,'Going to load %d files. \n',length(files))
for ii = 9:40
    [ent,prot] = loadEphusData(files{ii});
    fprintf(1,'#')
    if ~isempty(prot)
        counter = counter + 1;
        vdata(counter) = ent(strcmp({ent.name},VNAME));
        syncInd{counter} = findSyncIndexes(ent(strcmp({ent.name},SYNCNAME)).data);
        prots(counter) = prot;
    end
    if ~mod(ii,10)
        fprintf(1,'\n')
    end
end
fprintf(1,'Done\n')
%% To check that the pulse are deterministic
% time = 1e3*(0:length(vdata(selectedProt(ii)).data)-1)./vdata(selectedProt(ii)).srate;
% figure(1),plotRastergram(cellfun(@(x)time(x) - time(x(1)),syncInd,'uniformoutput',0))
%%
PLOT = false;
visfunc = @(x,tf)sin(2*pi*tf*x);
binsize = 20; % in ms

uniqueProtSize = unique([prots.Size]);
uniqueDirections = unique([prots.Angle]);
uniqueProtTf = unique([prots.TemporalFreq]);
frate = [];
for tfidx = 1:length(uniqueProtTf)
    for dir = 1:length(uniqueDirections)
        for sze = 1:length(uniqueProtSize)
            fname = sprintf('angle_%2.3f_size_%2.3f_tf_%2.3f',uniqueDirections(dir),...
                uniqueProtSize(sze),uniqueProtTf(tfidx));
            selectedProt = find([prots.Angle] == uniqueDirections(dir) & ...
                [prots.Size] == uniqueProtSize(sze) & ...
                [prots.TemporalFreq] == uniqueProtTf(tfidx));
            THRESHOLD = 6;
            spks = {};
            Tspks = {};
            spk_w = {};
            tEnd = [];
            spks_per_cycle = {};
            tf = [];
            if PLOT
                figure(),clf
            end
            for ii = 1:length(selectedProt)
                time = (0:length(vdata(selectedProt(ii)).data)-1)./vdata(selectedProt(ii)).srate;
                fdata = Bpass_trace(vdata(selectedProt(ii)).data,vdata(selectedProt(ii)).srate,100,5000);
                %filter_data(vdata(selectedProt(ii)).data,100,5000,vdata(selectedProt(ii)).srate,'ellip'); 
                [spks{ii},spk_w{ii},...
                    t_spk_w,...
                    spk_idx,...
                    threshold] = detectExtracellularSpikes(fdata,time,...
                    THRESHOLD,0.6,1,1,'neg');
                if PLOT
                    clf,plot(time,fdata,'k-')
                    hold all
                    title(sprintf('trial %d',ii))
                    plot(spks{ii},fdata(spk_idx),'ko','markerfacecolor','r')
                    plot(xlim(),repmat(-threshold{1},2,1),'r--')
                    pause
                end
                [Tspks{ii},tEnd(ii),spks_during_stim{ii},spks_per_cycle{ii}] = processGratingStationary(spks{ii},time(syncInd{ii}),prots(ii));
            end
            %
            frate(ii) = mean(1./diff(spks_during_stim{ii}));
            
            % Prepare figures
            fig = figure('papersize',[9,7],'paperposition',[0,0,9,7]);clf
            set(fig,'color','w')
            ax(1) = axes('position',[.1,.35,.4,.6]);
            ax(2) = axes('position',[.1,.1,.4,.23]);
            ax(3) = axes('position',[.1,.1,.4,.23],'visible','off');
            ax(4) = axes('position',[.6,.2,.3,.5],...
                'yaxislocation','left',...
                'xaxislocation','bottom');hold all;
            %Plot the rastergram
            axes(ax(1))
            plotRastergram(Tspks)
            axis tight
%             % Plot the trial duration
%             plotRastergram(arrayfun(@(x)x,tEnd,'uniformoutput',0)...
%                 ,'color','r')
%             plot([0,0],ylim,'r')
            % plot Histogram
            axes(ax(2)) 
            all_spks = cell2mat(Tspks);
            edges = min(all_spks):binsize*1e-3:max(all_spks);
            cnts = histc(all_spks,edges);
            bar(edges,(cnts./length(Tspks))./binsize,'k')
            
            axes(ax(3))
%             % The sine on top of the histogram
%             visTime = linspace(0,prots( selectedProt(1)).StimTime,5000);
%             visStim = visfunc(visTime,prots( selectedProt(1)).TemporalFreq);
%             plot(visTime,visStim,'r')
%             linkaxes(ax([1,2,3]),'x')
%             axes(ax(4))
            %The cycle triggered spike count
            sin_edges = linspace(0,1./prots(selectedProt(1)).TemporalFreq,100);
            counts = histc(cell2mat(spks_per_cycle),sin_edges);
            bar(sin_edges,counts,'k')
            xlabel('Time (s)')
            ylabel(sprintf('Spikes per %s bin',diff(sin_edges([1:2]))*1e3))
            axis tight
            sin_amp = diff(ylim())/2+min(ylim());
            sin_t = linspace(0,max(sin_edges),1000);
            plot(sin_t,sin_amp.*visfunc(sin_t...
                ,prots(selectedProt(1)).TemporalFreq) + sin_amp,'r')
            set(ax([1,3]),'visible','off')
            set(ax,'box','off','xcolor','k','ycolor','k','color','none')
            
            annotation(fig,'textbox',[.1 .9 .9,.1],'String',fname,...
                'edgecolor','none','verticalalignment','top',...
                'horizontalalignment','center','interpreter','none',...
                'fontweight','bold')
            
            print(fig,'-dpdf',sprintf('%s.pdf',fname))
        end
    end
end
