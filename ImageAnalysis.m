function varargout = ImageAnalysis(varargin)
% IMAGEANALYSIS MATLAB code for ImageAnalysis.fig
%      IMAGEANALYSIS, by itself, creates a new IMAGEANALYSIS or raises the existing
%      singleton*.
%
%      H = IMAGEANALYSIS returns the handle to a new IMAGEANALYSIS or the handle to
%      the existing singleton*.
%
%      IMAGEANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEANALYSIS.M with the given input arguments.
%
%      IMAGEANALYSIS('Property','Value',...) creates a new IMAGEANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageAnalysis

% Last Modified by GUIDE v2.5 18-Jul-2017 12:54:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageAnalysis_OutputFcn, ...
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


% --- Executes just before ImageAnalysis is made visible.
function ImageAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageAnalysis (see VARARGIN)

% Choose default command line output for ImageAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in importImage.
function importImage_Callback(hObject, eventdata, handles)
% hObject    handle to importImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Opening Image with Bioformats');
im_cell = bfopen;
im = im_cell{1,1}{1,1};
axes(handles.axes1);
imshow(im,[])

set(handles.text5, 'String', get(handles.zSlider, 'Value'));
set(handles.zSlider, 'Enable', 'on');

handles.im_cell = im_cell;
guidata(hObject, handles)


% --- Executes on button press in trans.
function trans_Callback(hObject, eventdata, handles)
% hObject    handle to trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in trans.
num = get(handles.zSlider, 'Value');
im = handles.im_cell{1,1}{(1+((num-1)*3)),1};
axes(handles.axes1);
imshow(im, [])

handles.first = 1;
handles.second = 0;
handles.third = 0;
clc; 
disp('Fist Button was pressed.');
guidata(hObject, handles);


% --- Executes on button press in RFP.
function RFP_Callback(hObject, eventdata, handles)
% hObject    handle to RFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = get(handles.zSlider, 'Value');
im = handles.im_cell{1,1}{(2+(3*(num-1))),1};
axes(handles.axes1);
imshow(im, [])

handles.first = 0;
handles.second = 1;
handles.third = 0;
clc; 
disp('Second Button was pressed.');
guidata(hObject, handles);

% --- Executes on button press in GFP.
function GFP_Callback(hObject, eventdata, handles)
% hObject    handle to GFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = get(handles.zSlider, 'Value');
im = handles.im_cell{1,1}{(3+(3*(num-1))),1};
axes(handles.axes1);
imshow(im, [])

handles.first = 0;
handles.second = 0;
handles.third = 1;
clc; 
disp('Third Button was pressed.');
guidata(hObject, handles);


% --- Executes on button press in box.
function box_Callback(hObject, eventdata, handles)
% hObject    handle to box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = imrect;
hparent = axes(handles.axes1);
h = imrect(hparent);


% --- Executes on slider movement.
function zSlider_Callback(hObject, eventdata, handles)
% hObject    handle to zSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

seriesCount = size(handles.im_cell, 1);
series1 = handles.im_cell{1,1};
metadataList = handles.im_cell{1,2};
planeCount = (size(series1, 1))/3;

set(handles.zSlider, 'Min', 1);
set(handles.zSlider, 'Max', planeCount);
set(handles.zSlider, 'SliderStep', [(1/(planeCount-1)) , (1/(planeCount-1 ))]);

sliderVal = get(hObject, 'Value');
assignin('base', 'sliderVal', sliderVal);
set(handles.text5, 'String', num2str(sliderVal));


num = get(hObject, 'Value');
if (handles.first==1 && handles.second==0 && handles.third==0)
    im = handles.im_cell{1,1}{(1+((num-1)*3)),1};
    axes(handles.axes1);
    imshow(im, [])
elseif (handles.first==0 && handles.second==1 && handles.third==0)
    im = handles.im_cell{1,1}{(2+((num-1)*3)),1};
    axes(handles.axes1);
    imshow(im, [])
elseif (handles.first==0 && handles.second==0 && handles.third==1)
    im = handles.im_cell{1,1}{(3+((num-1)*3)),1};
    axes(handles.axes1);
    imshow(im, [])
end

% --- Executes during object creation, after setting all properties.
function zSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Contrast_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
disp('adjusting contrast');
im = imread(handles.axes1);
J = imadjust(im);
axes(handles.axes1);
imshow(J)
%min=684
%max= 1893

% --- Executes during object creation, after setting all properties.
function Contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




