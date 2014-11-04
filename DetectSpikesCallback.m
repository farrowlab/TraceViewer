%----- Intiate -----%
    trace = handles.trace;
    srate = handles.srate;
    time = (0:(length(trace)-1))./srate;
    wpre = 30;
    wpost = 50;
    minpeakdistance = round(srate/1000);
    get(handles.SpikeMaxMin,'String')
    
    %----- Detect Spikes and get Spike Shapes -----%
    switch get(handles.SpikeMaxMin,'String')
        case 'Max'
            m = median(trace);
            v = std(trace);
            thresh = m + (v*str2num(get(handles.ThresholdSD,'String')));
            [~, spkidx]= findpeaks(trace,'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);
        case 'Min'
            ntrace = trace * -1; 
            m = median(ntrace);
            v = std(ntrace);
            thresh = m + (v*str2num(get(handles.ThresholdSD,'String')));
            [~, spkidx]= findpeaks(ntrace,'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);                
    end        
    spkshapes = [];        
    for ii = 1:length(spkidx)
        spkshapes = [spkshapes,trace(spkidx(ii)-wpre:spkidx(ii)+wpost)];
    end
    
        
    %----- Plot Traces -----%            
%     if get(handles.DetectSpikes,'Value')
        axes(handles.axes1);                
        plot(time,trace,'k'); hold on 
        switch get(handles.SpikeMaxMin,'String')
            case 'Max'
                plot(time,thresh * ones(1,length(time)),'r');
            case 'Min'
                plot(time,-thresh * ones(1,length(time)),'r');
        end
        plot(time(spkidx), trace(spkidx),'ro','markerfacecolor','r');   
        zoom on
        xlabel('Time (s)');    
        hold off
        
        axes(handles.axes2);
        X = (-wpre:wpost)*1000/srate;        
        plot(X,spkshapes,'color',[0.5,0.5,0.5],'linewidth',0.5); hold on
        plot(X,mean(spkshapes'),'r','linewidth',1.5); hold off   
        delete(findall(gcf,'Tag','somethingUnique'))
        annotation('textbox', [0.8,0.3,0.1,0.1],...
           'String',['no = ',num2str(length(spkidx))],...
           'Tag' , 'somethingUnique'); 
        xlabel('Time (ms)');
        axis('tight') 