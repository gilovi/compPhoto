function varargout = HDR(varargin)
% HDR MATLAB code for HDR.fig
%      HDR, by itself, creates a new HDR or raises the existing
%      singleton*.
%
%      H = HDR returns the handle to a new HDR or the handle to
%      the existing singleton*.
%
%      HDR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HDR.M with the given input arguments.
%
%      HDR('Property','Value',...) creates a new HDR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HDR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HDR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HDR

% Last Modified by GUIDE v2.5 11-Jun-2015 19:30:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HDR_OpeningFcn, ...
                   'gui_OutputFcn',  @HDR_OutputFcn, ...
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


% --- Executes just before HDR is made visible.
function HDR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HDR (see VARARGIN)

% Choose default command line output for HDR
handles.output = hObject;
gamma = 1/2.2;
path = ''
isHDR = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HDR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HDR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in fatal.
function fatal_Callback(hObject, handles)
% hObject    handle to fatal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fatal=get(hObject,'Value');
set (handles.fatal,'Value',fatal);

   
% --- Executes on button press in energy.
function energy_Callback(hObject, eventdata, handles)
% hObject    handle to energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

energy=get(hObject,'Value');
set(handles.energy,'Value',energy);


    

    


% --- Executes on slider movement.
function alfa_Callback(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

alfa = get(hObject,'Value');
string1 = sprintf(' %.3f', alfa);
set(handles.alfa,'Value',alfa);
set(handles.edit5,'String', string1);



% --- Executes during object creation, after setting all properties.
function alfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function beta_Callback(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
beta = get(hObject,'Value');
set(handles.beta,'Value',beta);
string1 = sprintf(' %.3f', beta);
set(handles.edit6,'String', string1);



% --- Executes during object creation, after setting all properties.
function beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gamma_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

gamma = get(hObject,'Value');
set(handles.gamma,'Value',gamma);
string1 = sprintf(' %.2f', gamma);
set(handles.edit7,'String', string1);


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double

path=get(hObject, 'String')
display(path)
set(handles.path,'String',path);


% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

path = get(handles.path,'String');
LDR=get(handles.isLDR,'Value');
HDR=get(handles.isHDR,'Value');
display(LDR);
display(HDR);
if  LDR == 1 
    image=im2double(imread(path));
    image=image.^2.2;
else
    image=hdrread(path);
end

axes(handles.axes1);
set(handles.Load,'CData',image);
imshow(image);
%guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pic=im2uint8(get(handles.final,'CData'));
name=get(handles.pic_name,'String');
display(name);
endd='.jpg';
name=strcat(name,endd);
display(name);
imwrite(pic, name);





% --- Executes on button press in isHDR.
function isHDR_Callback(hObject, eventdata, handles)
% hObject    handle to isHDR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isHDR

isHDR=get(hObject,'Value');
set(handles.isHDR,'Value',isHDR);



% --- Executes on button press in isLDR.
function isLDR_Callback(hObject, eventdata, handles)
% hObject    handle to isLDR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isLDR

isLDR=get(hObject,'Value');
set(handles.isLDR,'Value',isLDR);



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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

beta=get(hObject,'Value');
set(handles.beta,'Value',beta);



% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

gamma=get(hObject,'Value');
set(handles.gamma,'Value',gamma);


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gamma_corection_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_corection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma_corection as text
%        str2double(get(hObject,'String')) returns contents of gamma_corection as a double

gamma_corection=get(hObject,'String');
display(gamma_corection);
gamma_corection=str2double(gamma_corection);
set(handles.gamma_corection,'Value',gamma_corection);
display (gamma_corection);


% --- Executes during object creation, after setting all properties.
function gamma_corection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_corection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in final.
function final_Callback(hObject, eventdata, handles)
% hObject    handle to final (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


path=get(handles.path, 'String');
image=get(handles.Load, 'CData');
alfa=get(handles.alfa, 'Value');
beta=get(handles.beta, 'Value');
gamma=get(handles.gamma, 'Value');
params=[ alfa, beta, gamma ];
fatal=get(handles.fatal,'Value');
energy=get(handles.energy,'Value');
gamma_corection=get(handles.gamma_corection,'Value');
display(path);
display (alfa);
%figure; 
%title('fdsdf');
%imshow(image);
display(alfa);
display(beta);
display(params);
display(fatal);
display(gamma_corection);
if (~ strcmp(path,''))
    if ( fatal == 1 )
        final = compressDR( image, 'fattal' , params , gamma_corection);

    else
        final = compressDR( image, 'energy' , params , gamma_corection);
    end
    axes(handles.axes3);
    set(handles.final,'CData',final);
    imshow(final);
    
end



function pic_name_Callback(hObject, eventdata, handles)
% hObject    handle to pic_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pic_name as text
%        str2double(get(hObject,'String')) returns contents of pic_name as a double

pic_name=get(hObject,'String');
if ( strcmp(pic_name,'')  )
    pic_name='Defult';
end
set(handles.pic_name,'String', pic_name);



% --- Executes during object creation, after setting all properties.
function pic_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pic_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
