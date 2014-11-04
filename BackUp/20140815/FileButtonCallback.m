%----- Initiate -----%
        FilterNumber = get(handles.FilterMenu,'Value')
        FilterList =  get(handles.FilterMenu,'String')
        FilterType = FilterList{FilterNumber}
        trace = handles.trace;
        srate = handles.srate;
        time = (0:(length(trace)-1))./srate;
        min_freq = str2num(get(handles.FilterLowCutOff,'String'));
        max_freq = str2num(get(handles.FilterHighCutOff,'String'));

        %----- Filter -----%
        switch FilterType
            case 'Lowpass'
                trace = Lpass_trace(trace,srate,max_freq);
            case 'Highpass'
                trace = Hpass_trace(trace,srate,min_freq);            
            case 'Bandpass'
                trace = Bpass_trace(trace,srate,min_freq,max_freq);
            case 'Smooth'
                trace = fastsmooth(trace,min_freq,3,1);            
            case 'Original'
                trace = trace;
            otherwise
                    disp('Need to Program!');
        end

        %----- Plot Trace -----%
        axes(handles.axes1);                
        plot(time,trace,'k');
        zoom on
        xlabel('Time (s)');    
        hold off        

    handles.trace = trace;