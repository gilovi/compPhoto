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

% Last Modified by GUIDE v2.5 22-Jul-2015 23:08:37

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
handles.I = I;
guidata(hObject,handles);


%focus(I,1,0);
%imshow(I{1})

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over file_path.
function file_path_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to file_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.fileName, handles.pathName] = uigetfile({'*.*'});
guidata(hObject,handles);
set(hObject,'String', handles.pathName);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



function focus_inpiut_Callback(hObject, eventdata, handles)
% hObject    handle to focus_inpiut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of focus_inpiut as text
%        str2double(get(hObject,'String')) returns contents of focus_inpiut as a double

focus_inpiut=str2double(get(hObject,'String'));
%focus_inpiut
%set(handles.start_focus,'Value',start_focus);
handles.focus_inpiut = focus_inpiut;
%handles.focus_inpiut
%handles.focus_inpiut
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function focus_inpiut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to focus_inpiut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%imshow(handles.I{8});


% --- Executes on button press in with.
function with_Callback(hObject, eventdata, handles)
% hObject    handle to with (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of with

with_oclison=get(hObject,'Value');
%set(handles.with,'Value',with);
handles.with=with_oclison;
handles.without_oclison=0;
handles.with
guidata(hObject,handles);


% --- Executes on button press in without_oclison.
function without_oclison_Callback(hObject, eventdata, handles)
% hObject    handle to without_oclison (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of without_oclison

without_oclison=get(hObject,'Value');
%set(handles.with,'Value',with);
handles.without_oclison=without_oclison;
handles.with_oclison=0;
handles.without_oclison
guidata(hObject,handles);



% --------------------------------------------------------------------
function uibuttongroup2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit as text
%        str2double(get(hObject,'String')) returns contents of edit as a double
handles.edit =str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function degrees_Callback(hObject, eventdata, handles)
% hObject    handle to degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of degrees as text
%        str2double(get(hObject,'String')) returns contents of degrees as a double

if handles.r45==1
    set(handles.degrees,'String', '45');
end
if handles.r90==1
    set(handles.degrees,'String', '90' );
end
if handles.r135==1
    set(handles.degrees,'String', '135' );
end

% --- Executes during object creation, after setting all properties.
function degrees_CreateFcn(hObject, eventdata, handles)
% hObject    handle to degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function focus_num1_Callback(hObject, eventdata, handles)
% hObject    handle to focus_num1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.num=get(hObject,'Value');
handles.num
handles.edit=handles.num;
handles.edit
%set(handles.edit,'String',handles.num);


focus_num = str2double(get(hObject,'String'));
handles.edit=focus_num;
guidata(hObject,handles);
if handles.without_oclison == 1
    x=0;
else
    x=1;
end
q=focus(handles.I,handles.num,x);
imshow(q);

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function focus_num1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to focus_num1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on key press with focus on edit and none of its controls.
function edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in r90.
function r90_Callback(hObject, eventdata, handles)
% hObject    handle to r90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r90
handles.r90 = 1;
handles.num=90;
%set(handles.r135,'Value', 0);
%set(handles.r45,'Value', 0);
set(handles.degrees,'String', '90');
%set(handles.deg_slide,'Value', 90);
guidata(hObject,handles);

% --- Executes on button press in r45.
function r45_Callback(hObject, eventdata, handles)
% hObject    handle to r45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r45

handles.r45 = 1;
handles.num=45;
%set(handles.r135,'Value', 0);
%set(handles.r90,'Value', 0);
set(handles.degrees,'String', '45');
%set(handles.deg_slide,'Value', 45);
guidata(hObject,handles);



% --- Executes on button press in r135.
function r135_Callback(hObject, eventdata, handles)
% hObject    handle to r135 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r135

%handles.r45 = 0;
%handles.r90 = 0;
handles.r135 = 1;
handles.num=135;
%set(handles.r90,'Value', 0);
%set(handles.r45,'Value', 0);
set(handles.degrees,'String', '135');
%set(handles.deg_slide,'Value', 135);

guidata(hObject,handles);


% --- Executes on slider movement.
function deg_slide_Callback(hObject, eventdata, handles)
% hObject    handle to deg_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

deg=get(hObject,'Value');
handles.deg_slide=deg;
set(handles.degrees,'String', num2str(deg));
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function deg_slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deg_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
