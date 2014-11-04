function varargout = TraceViewerK(varargin)
% TRACEVIEWERK MATLAB code for TraceViewerK.fig
%      TRACEVIEWERK, by itself, creates a new TRACEVIEWERK or raises the existing
%      singleton*.
%
%      H = TRACEVIEWERK returns the handle to a new TRACEVIEWERK or the handle to
%      the existing singleton*.
%
%      TRACEVIEWERK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACEVIEWERK.M with the given input arguments.
%
%      TRACEVIEWERK('Property','Value',...) creates a new TRACEVIEWERK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TraceViewerK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TraceViewerK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TraceViewerK

% Last Modified by GUIDE v2.5 30-Sep-2014 21:58:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TraceViewerK_OpeningFcn, ...
    'gui_OutputFcn',  @TraceViewerK_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TraceViewerK is made visible.
function TraceViewerK_OpeningFcn(hObject, eventdata, handles, varargin)

%---------- Initiate TraceViewer ----------%

%----- Populate Analysis Menu -----%
DD = dir('/home/farrowlab/Scripts/TraceViewer/AnalysisPrograms');
n = 0;
for i = 3:size(DD,1)
    n = n + 1;
    List{n} = DD(i).name;
end
set(handles.AnalysisMenu,'string',List)

handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes TraceViewerK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TraceViewerK_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

%------------------------------------------------------------------------%
%----------------------- Program Begins Here ----------------------------%
%------------------------------------------------------------------------%

%--------------- Select and Load Data ---------------%

%---------- Load Data ----------%
function LoadData_Callback(hObject, eventdata, handles)

%----- Get Files and Make File List -----%
pathname = get(handles.PrimaryFilePath,'String'); %'/media/nerffs/Data/00041/Raw/20140429/YC0001';
files = dir(pathname);
files = {files(~[files.isdir]).name};
set(handles.FileList,'String',files);

guidata(hObject, handles);

%----- Load Sub-Functions -----%
function PrimaryFilePath_Callback(hObject, eventdata, handles)
start_path = '/media/NERFFS01/Data'
pathname = uigetdir(start_path,'Get Directory for Data');
set(handles.PrimaryFilePath,'String',pathname);

function DataFormat_Callback(hObject, eventdata, handles)

%---------- Select Data for Display ----------%
function FileList_Callback(hObject, eventdata, handles)

%----- Initiate -----%
if isfield(handles,'data')
    handles = rmfield(handles,'data');
    handles = rmfield(handles,'trace');
    handles = rmfield(handles,'otrace');
    
else
end


%----- Get File -----%
pathname = get(handles.PrimaryFilePath,'String');
filelist = get(handles.FileList,'String');
files = get(handles.FileList,'Value');

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
    
    if isfield(handles.data(i).data,'acquirer') && ~isempty(handles.data(i).data.acquirer.trace_1)
        stimu(i).data = handles.data(i).data.acquirer.trace_1;
    else
        stimu(i).data = [];
    end
    
    trace(i).length = length(trace(i).data);
    time = (0:(length(trace(i).data)-1))./trace(i).srate;
    %%%%% THIS
    axes(handles.axes3);
    if ~isempty(stimu(i).data)
        linkaxes([handles.axes1 handles.axes3],'x');
        plot(time,stimu(i).data,'m'); axes(handles.axes3); 
        set(gca,'XTickLabel',[],'yaxislocation','right','ycolor','r'); hold on
    else
        cla()
    end
    
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
    axes(handles.axes1); xlabel('Time (s)');
    
end
axes(handles.axes1); hold off
axes(handles.axes3); hold off


%----- Display File Header -----%
if n == 1
    srate = handles.data(1).header.ephys.ephys.sampleRate;
    stimu = handles.data(1).header.headerGUI.headerGUI.whatTreatment;
    set(handles.FileDetails,'String',{['Sample Rate: ' num2str(srate) ' Hz'],stimu})
else
    srate = handles.data(1).header.ephys.ephys.sampleRate;
    set(handles.FileDetails,'String',['Sample Rate: ' num2str(srate) ' Hz']);
end
%     assignin('base','trace',trace)
for n = 1:size(trace,2)
    handles.trace(:,n) = trace(n).data;
end
handles.otrace=handles.trace;
handles.srate = srate;


axes(handles.axes1);
guidata(hObject, handles);

if get(handles.filter_bool,'Value')
   FilterButton_Callback(hObject, eventdata, handles)
else
   plot(time,trace(i).data,'k'); hold on
end
if get(handles.detect_spikes_bool,'Value')
    try
        handles = guidata(hObject);
        DetectSpikes_Callback(hObject, eventdata, handles)

    catch
        disp('There was an error or no spikes...Help...')
    end
end

guidata(hObject, handles);

%----- Data Display Subfunctions -----%
function FileDetails_Callback(hObject, eventdata, handles)



%--------------- Pre-Process Data ---------------%

%---------- Filter Traces ----------%
function FilterButton_Callback(hObject, eventdata, handles)

%----- Initiate -----%
FilterNumber = get(handles.FilterMenu,'Value');
FilterList =  get(handles.FilterMenu,'String');
FilterType = FilterList{FilterNumber};
trace = handles.trace;
srate = handles.srate;
time = (0:(length(trace)-1))./srate;
min_freq = str2num(get(handles.FilterLowCutOff,'String'));
max_freq = str2num(get(handles.FilterHighLowCutOff,'String'));

%----- Filter -----%
for n = 1:size(trace,2)
    switch FilterType
        case 'Lowpass'
            trace(:,n) = Lpass_trace(trace(:,n),srate,max_freq);
        case 'Highpass'
            trace(:,n) = Hpass_trace(trace(:,n),srate,min_freq);
        case 'Bandpass'
            trace(:,n) = Bpass_trace(trace(:,n),srate,min_freq,max_freq);
        case 'Bandstop'
            trace(:,n) = Bstop_trace(trace(:,n),srate,min_freq,max_freq);
        case 'Smooth'
            trace(:,n) = fastsmooth(trace(:,n),min_freq,3,1);
        case 'Original'
            trace(:,n) = handles.otrace(:,n);
        case 'Baseline'
            BL = median(trace(1:1000,n));
            trace(:,n) = trace(:,n) - BL;
        otherwise
            disp('Need to Program another filter!');
    end
end
%----- Plot Trace -----%
axes(handles.axes1);
plot(time,trace); hold on
zoom on
xlabel('Time (s)');
hold off
handles.trace = trace;
guidata(hObject, handles);

%----- Filter Sub-functions -----%
function FilterMenu_Callback(hObject, eventdata, handles)
function FilterHighLowCutOff_Callback(hObject, eventdata, handles)
function FilterLowCutOff_Callback(hObject, eventdata, handles)

%---------- Detect Spikes ----------%
function DetectSpikes_Callback(hObject, eventdata, handles)

%----- Intiate -----%
FR=[];
trace = handles.trace;
size(trace)
srate = handles.srate;
time = (0:(length(trace)-1))./srate;
wpre = 30;
wpost = 50;
minpeakdistance = round(srate/1000);
get(handles.SpikeMaxMin,'String')
NTraces = size(trace,2);
spkshapes = cell(NTraces);



%----- Detect Spikes and get Spike Shapes -----%
for n = 1:NTraces
    thresh = median(abs(trace(:,n))./0.6745)*str2num(get(handles.ThresholdSD,'String'));
    switch get(handles.SpikeMaxMin,'String')
        case 'Max'
            ntrace = trace(:,n);
            [~, spkidx{n}]= findpeaks(trace(:,n),'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);
        case 'Min'
            ntrace = -trace(:,n);
            [~, spkidx{n}]= findpeaks(-trace(:,n),'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);
        otherwise
    end
%     m = median(ntrace);
%     v = std(ntrace);
%     thresh = m + (v*str2num(get(handles.ThresholdSD,'String')));
%     [~, spkidx{n}]= findpeaks(ntrace,'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);

    
    for ii = 1:length(spkidx{n})
        spkshapes{n} = [spkshapes{n},trace([-wpre:wpost]+spkidx{n}(ii),n)];
    end
end


%         %----- Calculate and Plot Rasta Plot and Firing Rate -----%
%         windowsize = .005; resamplingrate = 1000;
%         FR = zeros(length(trace),NTraces);
%
%         gspike = -3*windowsize:1/handles.srate:3*windowsize;    % set range
%         gspike = exp(-gspike.^2/(2*windowsize^2)); % calc gauss
%         g = gspike(gspike > 0.01);       % drop too small values
%         gspike = gspike' / sum(gspike);        % normalize
%         for n = 1:NTraces
%             FR(spkidx{n},n) = 1;
%         end
%         for n = 1:NTraces
%             FR(:,n) = resamplingrate * convn(FR(:,n), gspike, 'same');
%         end
%         clear('gspike');
%         handles.FR = FR;

%----- Plot Traces -----%
axes(handles.axes1);
plot(time,trace); hold on
switch get(handles.SpikeMaxMin,'String')
    case 'Max'
        plot(time,thresh * ones(1,length(time)),'r');
    case 'Min'
        plot(time,-thresh * ones(1,length(time)),'r');
    otherwise
end
for n = 1:NTraces
    plot(time(spkidx{n}), trace(spkidx{n},n),'ro','markerfacecolor','r');
end
%         plot(time,FR,'color',[.25 .25 .25]);
%         plot(time,mean(FR,2),'r','linewidth',2);
zoom on
xlabel('Time (s)');
hold off



%----- Plot Spike Shapes -----%
axes(handles.axes2);cla
X = (-wpre:wpost)*1000/srate;
for n = 1:NTraces
    spks = spkshapes{n};
    plot(X,spks,'color',[0.5,0.5,0.5],'linewidth',0.5); hold on
    Mspks = mean(spks,2);
    plot(X,Mspks,'color',[1,0.5,0.5],'linewidth',2);
    plot(X,Mspks + std(spkshapes{n},[],2),'--','color',[1,0.5,0.5],'linewidth',1);
    plot(X,Mspks - std(spkshapes{n},[],2),'--','color',[1,0.5,0.5],'linewidth',1);
end

xlabel('Time (ms)');
axis('tight');
hold off

handles.sptimes = spkidx;
handles.spkshapes = spkshapes;
guidata(hObject, handles);

% ----- Detect Spikes Subfunctions -----%
function ThresholdSD_Callback(hObject, eventdata, handles)
function SpikeMaxMin_Callback(hObject, eventdata, handles)


%--------------- Do Data Analysis ---------------%
function DoAnalysis_Callback(hObject, eventdata, handles)

%---------- Initiate ----------%
FF = get(handles.AnalysisMenu,'String');
FF = FF{get(handles.AnalysisMenu,'Value')}
DType = get(handles.DataType,'String');
DType = DType{get(handles.DataType,'Value')};
params = [];
%stimulus = str2num(get(handles.FileDetails,'String'));
if isfield(handles.data.data,'acquirer') && ~isempty(handles.data.data.acquirer.trace_1)
    stimu.data = handles.data.data.acquirer.trace_1;
else
    stimu.data = [];
end
switch DType
    case 'Spikes'
        DD.stim = stimu.data;
        params.srate = handles.srate;
        params.data_size = size(handles.trace);
        spkidx = handles.sptimes{1};
        DD.trace = zeros(params.data_size(1),1);
        DD(spkidx) = 1;
        params.spikes = 1;
    case 'Analogue'
        DD.trace = handles.trace;
        DD.stim = stimu.data;
        params.srate = handles.srate;
        params.data_size = size(handles.trace);
        params.spikes = 0;
    otherwise
        DD.stimu = stimu.data;
        DD.trace = handles.trace;
        params.srate = handles.srate;
end

%---------- Call Function ----------%
switch FF
    case 'meanK.m'
        dout = meanK(DD,params);
    case 'stdK.m'
        dout = std(DD,params);
    case 'FourierAnalysisSC.m'
        dout = FourierAnalysisSC(DD,params);
    case 'FourierAnalysisYC.m'
        dout = FourierAnalysisYC(DD,params);
    case 'SamSpot.m'
        dout = SamSpot(DD,params);
    otherwise
        disp('Need to Add program as case to list in TraceViewerK.m near line 396');
end
assignin('base','dout',dout)





%---------- Analysis Sub-Functions ----------%
function AnalysisRange_Callback(hObject, eventdata, handles)
function AnalysisMenu_Callback(hObject, eventdata, handles)
function DataType_Callback(hObject, eventdata, handles)




%-------------------------------------------------------------------------%
%---------------------- Create Function Depository -----------------------%
%-------------------------------------------------------------------------%
function FileDetails_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FileList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DataFormat_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function PrimaryFilePath_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ThresholdSD_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SpikeMaxMin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FilterMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FilterLowCutOff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FilterHighLowCutOff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AnalysisMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AnalysisRange_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DataType_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MakeFigure.
function MakeFigure_Callback(hObject, eventdata, handles)
% hObject    handle to MakeFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%----- Initiate -----%
FilterNumber = get(handles.FilterMenu,'Value');
FilterList =  get(handles.FilterMenu,'String');
FilterType = FilterList{FilterNumber};
trace = handles.trace;
srate = handles.srate;
time = (0:(length(trace)-1))./srate;
min_freq = str2num(get(handles.FilterLowCutOff,'String'));
max_freq = str2num(get(handles.FilterHighLowCutOff,'String'));

if isfield(handles.data.data,'acquirer') && ~isempty(handles.data.data.acquirer.trace_1)
        stimu.data = handles.data.data.acquirer.trace_1;
    else
        stimu.data = [];
end
    
%----- Filter -----%
for n = 1:size(trace,2)
    switch FilterType
        case 'Lowpass'
            trace(:,n) = Lpass_trace(trace(:,n),srate,max_freq);
        case 'Highpass'
            trace(:,n) = Hpass_trace(trace(:,n),srate,min_freq);
        case 'Bandpass'
            trace(:,n) = Bpass_trace(trace(:,n),srate,min_freq,max_freq);
        case 'Smooth'
            trace(:,n) = fastsmooth(trace(:,n),min_freq,3,1);
        case 'Original'
            trace(:,n) = handles.otrace(:,n);
        case 'Baseline'
            BL = median(trace(1:1000,n));
            trace(:,n) = trace(:,n) - BL;
        otherwise
            disp('Need to Program!');
    end
end
size(trace)


%----- Plot Trace in figure-----%

fh = figure('Position',[100 100 1000 500],'Color','w'); % ----- Define Figure -----%
figure(fh);
plot(time,trace,'k'); box off; hold on
% axis off;
zoom on
plot(time,stimu.data + 1.5*max(trace),'m');

set(gca,'FontSize',20,'LineWidth',2);
xlabel('Time (s)','FontSize',20);
ylabel('Potential (mV)','FontSize',20);
axis tight


handles.trace = trace;
guidata(hObject, handles);






function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on key press with focus on FileList and none of its controls.
function FileList_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to FileList (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PlotWaveform.
function PlotWaveform_Callback(hObject, eventdata, handles)
% hObject    handle to PlotWaveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%----- Intiate -----%
FR=[];
trace = handles.trace;
size(trace)
srate = handles.srate;
time = (0:(length(trace)-1))./srate;
wpre = 30;
wpost = 50;
minpeakdistance = round(srate/1000);
get(handles.SpikeMaxMin,'String')
NTraces = size(trace,2);
spkshapes = cell(NTraces);



%----- Detect Spikes and get Spike Shapes -----%
for n = 1:NTraces
    thresh = median(abs(trace(:,n))./0.6745)*str2num(get(handles.ThresholdSD,'String'));
    switch get(handles.SpikeMaxMin,'String')
        case 'Max'
            ntrace = trace(:,n);
            [~, spkidx{n}]= findpeaks(trace(:,n),'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);
        case 'Min'
            ntrace = -trace(:,n);
            [~, spkidx{n}]= findpeaks(-trace(:,n),'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);
        otherwise
    end
%     m = median(ntrace);
%     v = std(ntrace);
%     thresh = m + (v*str2num(get(handles.ThresholdSD,'String')));
%     [~, spkidx{n}]= findpeaks(ntrace,'MINPEAKHEIGHT',thresh,'minpeakdistance',minpeakdistance);

    
    for ii = 1:length(spkidx{n})
        spkshapes{n} = [spkshapes{n},trace([-wpre:wpost]+spkidx{n}(ii),n)];
    end
end


%         %----- Calculate and Plot Rasta Plot and Firing Rate -----%
%         windowsize = .005; resamplingrate = 1000;
%         FR = zeros(length(trace),NTraces);
%
%         gspike = -3*windowsize:1/handles.srate:3*windowsize;    % set range
%         gspike = exp(-gspike.^2/(2*windowsize^2)); % calc gauss
%         g = gspike(gspike > 0.01);       % drop too small values
%         gspike = gspike' / sum(gspike);        % normalize
%         for n = 1:NTraces
%             FR(spkidx{n},n) = 1;
%         end
%         for n = 1:NTraces
%             FR(:,n) = resamplingrate * convn(FR(:,n), gspike, 'same');
%         end
%         clear('gspike');
%         handles.FR = FR;


%----- Plot Spike Shapes -----%
fh = figure('Position',[100 100 1000 500],'Color','w'); % ----- Define Figure -----%
figure(fh);


X = (-wpre:wpost)*1000/srate;
for n = 1:NTraces
    spks = spkshapes{n};
    plot(X,spks,'color',[0.5,0.5,0.5],'linewidth',0.5); hold on
    Mspks = mean(spks,2);
    plot(X,Mspks,'color',[1,0.5,0.5],'linewidth',2);
    plot(X,Mspks + std(spkshapes{n},[],2),'--','color',[1,0.5,0.5],'linewidth',1);
    plot(X,Mspks - std(spkshapes{n},[],2),'--','color',[1,0.5,0.5],'linewidth',1);
end


axis('tight');
zoom on
set(gca,'FontSize',20,'LineWidth',2);
xlabel('Time (ms)','FontSize',20);
ylabel('Potential (mV)','FontSize',20);
axis tight
box off






handles.sptimes = spkidx;
handles.spkshapes = spkshapes;
guidata(hObject, handles);


% --- Executes on button press in filter_bool.
function filter_bool_Callback(hObject, eventdata, handles)
% hObject    handle to filter_bool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_bool

% --- Executes on button press in detect_spikes_bool.
function detect_spikes_bool_Callback(hObject, eventdata, handles)
% hObject    handle to detect_spikes_bool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detect_spikes_bool
