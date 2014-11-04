%----- Initiate -----%        
        clear handles.trace handles.data
        
        %----- Get File -----%
        pathname = get(handles.PrimaryFilePath,'String');
        filelist = get(handles.FileList,'String');
        files = get(handles.FileList,'Value')
                
        %----- Load Data -----%
        n = 0;
        for file = files
            n = n + 1;
            filename = [pathname,'/',filelist{file}];
            handles.data(n) = load(filename,'-mat');
        end
        hold off
        
        %----- Display Data -----%
        for i = 1:n
            trace(i).srate = handles.data(n).header.ephys.ephys.sampleRate;
            trace(i).data = handles.data(i).data.ephys.trace_1;       
            trace(i).length = length(trace(i).data);
            time = (0:(length(trace(i).data)-1))./trace(i).srate;
            axes(handles.axes1);                
            plot(time,trace(i).data,'k'); hold on
            if n > 1 && i == n
                for ii = 1:n
                    L(ii) = trace(ii).length;
                end
                L = max(L);
                dd = nan(n,L);
                for ii = 1:n
                    dd(ii,1:trace(ii).length) = trace(ii).data;
                end
                time = (0:(L-1))./trace(1).srate;
                plot(time,nanmean(dd),'r','linewidth',2);
               
            end
            zoom on
            xlabel('Time (s)');  
        end
        hold off
        
        
        
        %----- Display File Header -----%
        if n == 1
            srate = handles.data(1).header.ephys.ephys.sampleRate;
            stimu = handles.data(1).header.headerGUI.headerGUI.whatTreatment;
            set(handles.FileDetails,'String',{['Sample Rate: ' num2str(srate) ' Hz'],stimu})
        else 
            srate = handles.data(1).header.ephys.ephys.sampleRate;
            set(handles.FileDetails,'String',['Sample Rate: ' num2str(srate) ' Hz']);
        end

    handles.trace = trace.data;
    handles.srate = srate;