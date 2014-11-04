% Ya-Chien 2014/5/7 view ephus trace (in comment)
% Joao 2014/5/9 view filterd trace and trace waveform

clear;
%[filename, pathname]=uigetfile({'*.xsg'},'Pick a file');
%%
pathname = 'E:\Data\20140509\YC0001';
files = dir(pathname);
files = {files(~[files.isdir]).name}
fig = figure(99);clf
for file = files
    clf
    disp(['opening file ',file{1}])
    filename = [pathname,'\',file{1}];
    data=load(filename,'-mat');
    trace = data.data.ephys.trace_1;
    srate = data.header.ephys.ephys.sampleRate;
    time = (0:(length(trace)-1))./srate;
    ftrace = hpass_trace(trace,srate,50,4000);
    thresh = 6*median(abs(ftrace))/0.6745;
    [~, spkidx]= findpeaks(-ftrace,'MINPEAKHEIGHT',thresh);
    spkshapes = [];
    wpre = 20;
    wpost = 40;
    for ii = 1:length(spkidx)
        spkshapes = [spkshapes,ftrace(spkidx(ii)-wpre:spkidx(ii)+wpost)];
    end
    subplot(1,8,[1,5])
    plot(time, ftrace,'k')
    hold on
    plot(time(spkidx), ftrace(spkidx),'ko','markerfacecolor','r')
    plot(xlim,[1,1]*-thresh,'--g')
        axis tight
    subplot(1,8,[6,8])
    plot(spkshapes,'color',[0.5,0.5,0.5],'linewidth',0.5)
    hold on
    plot(mean(spkshapes'),'r','linewidth',1.5)

    axis tight
    pause
end
%f=[pathname, filename];
%d=load(f,'-mat');
%tr=d.data.ephys.trace_1;
%figure;
%plot(tr)

