function varargout = better_gui(varargin)
% BETTER_GUI MATLAB code for better_gui.fig
%      BETTER_GUI, by itself, creates a new BETTER_GUI or raises the existing
%      singleton*.
%
%      H = BETTER_GUI returns the handle to a new BETTER_GUI or the handle to
%      the existing singleton*.
%
%      BETTER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BETTER_GUI.M with the given input arguments.
%
%      BETTER_GUI('Property','Value',...) creates a new BETTER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before better_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to better_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help better_gui

% Last Modified by GUIDE v2.5 14-Jul-2015 10:22:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @better_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @better_gui_OutputFcn, ...
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


% --- Executes just before better_gui is made visible.
function better_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to better_gui (see VARARGIN)

% Choose default command line output for better_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes better_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

fileName = '';
pathName = '';


% --- Outputs from this function are returned to the command line.
function varargout = better_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = get_images(handles.fileName, handles.pathName);
imshow(I{1})

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over file_path.
function file_path_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to file_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.fileName, handles.pathName] = uigetfile({'*.*'});
guidata(hObject,handles)
set(hObject,'String', handles.pathName);

