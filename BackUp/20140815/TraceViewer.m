function varargout = TraceViewer(varargin)
% TRACEVIEWER MATLAB code for TraceViewer.fig
%      TRACEVIEWER, by itself, creates a new TRACEVIEWER or raises the existing
%      singleton*.
%
%      H = TRACEVIEWER returns the handle to a new TRACEVIEWER or the handle to
%      the existing singleton*.
%
%      TRACEVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACEVIEWER.M with the given input arguments.
%
%      TRACEVIEWER('Property','Value',...) creates a new TRACEVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TraceViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TraceViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TraceViewer

% Last Modified by GUIDE v2.5 04-Jul-2014 10:28:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TraceViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @TraceViewer_OutputFcn, ...
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


% --- Executes just before TraceViewer is made visible.
function TraceViewer_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = TraceViewer_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%------------------------------------------------------------------------%
%----------------------- Program Begins Here ----------------------------%
%------------------------------------------------------------------------%

%--------------- Select and Load Data ---------------%
function LoadData_Callback(hObject, eventdata, handles)

    %----- Get Files and Make File List -----%
    pathname = get(handles.PrimaryFilePath,'String'); %'/media/nerffs/Data/00041/Raw/20140429/YC0001';
    files = dir(pathname);
    files = {files(~[files.isdir]).name}
    set(handles.FileList,'String',files);   
          
guidata(hObject, handles);
    
    function PrimaryFilePath_Callback(hObject, eventdata, handles)
    start_path = '/media/NERFFS01/Data'
    pathname = uigetdir(start_path,'Get Directory for Data');
    set(handles.PrimaryFilePath,'String',pathname);
    
    function FileList_Callback(hObject, eventdata, handles)
    FileListCallback;        
    guidata(hObject, handles);
    
    function DataFormat_Callback(hObject, eventdata, handles)    
    function FileDetails_Callback(hObject, eventdata, handles)        
    function SecondaryFilePath_Callback(hObject, eventdata, handles)
    function TertiaryFilePath_Callback(hObject, eventdata, handles)
    
    
%--------------- Process and Analyze Data ---------------%

    %----- Baseline Correction -----%
    function BaselineCorrect_Callback(hObject, eventdata, handles)
    
    %----- Intiate -----%
    trace = handles.trace;
    srate = handles.srate;
    time = (0:(length(trace)-1))./srate;
    
    %----- Correct Baseline -----%
    if handles.BaselineCorrect
        baseline = median(trace);
        trace = trace - baseline;
        axes(handles.axes1);                
        plot(time,trace,'k');
        zoom on
        xlabel('Time (s)');   
    else
        FileList_Callback(hObject, eventdata, handles)
    end
    
    handles.trace = trace.data;
    guidata(hObject, handles);
    
        function BaselineStart_Callback(hObject, eventdata, handles)
        function BaselineEnd_Callback(hObject, eventdata, handles)
    
    %----- Spike Detection -----%
    function DetectSpikes_Callback(hObject, ~, handles)   
    DetectSpikesCallback;
    guidata(hObject, handles);

        function SpikeMaxMin_Callback(hObject, eventdata, handles)
        function ThresholdSD_Callback(hObject, eventdata, handles)
            
            
    %----- Filter trace -----%
    function FilterButton_Callback(hObject, eventdata, handles)            
    FilterButtonCallback;            
    guidata(hObject, handles);    

        function FilterMenu_Callback(hObject, eventdata, handles)         
        function FilterLowCutOff_Callback(hObject, eventdata, handles)
        function FilterHighCutOff_Callback(hObject, eventdata, handles)

        
%--------------- Save Data ---------------%
function SaveData_Callback(hObject, eventdata, handles)    
    function DataFormatSave_Callback(hObject, eventdata, handles)
    function SavePath_Callback(hObject, eventdata, handles)


%--------------- Analyze Data ---------------%
function AnalyzeButton_Callback(hObject, eventdata, handles)
    
    
    function AnalyzeProgramMenu_Callback(hObject, eventdata, handles)
    function AnalysisRange_Callback(hObject, eventdata, handles)
    
        




%% Create Function Depository
function FilterMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function BaselineStart_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function BaselineEnd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FilterLowCutOff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FilterHighCutOff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DataFormat_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TertiaryFilePath_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function PrimaryFilePath_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SecondaryFilePath_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AnalyzeProgramMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AnalysisRange_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DataFormatSave_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SavePath_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FileList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FileDetails_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SpikeMaxMin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function ThresholdSD_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
