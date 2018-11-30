function varargout = remove_haze(varargin)
% REMOVE_HAZE MATLAB code for remove_haze.fig
%      REMOVE_HAZE, by itself, creates a new REMOVE_HAZE or raises the existing
%      singleton*.
%
%      H = REMOVE_HAZE returns the handle to a new REMOVE_HAZE or the handle to
%      the existing singleton*.
%
%      REMOVE_HAZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_HAZE.M with the given input arguments.
%
%      REMOVE_HAZE('Property','Value',...) creates a new REMOVE_HAZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before remove_haze_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to remove_haze_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help remove_haze

% Last Modified by GUIDE v2.5 30-Nov-2018 15:11:29
%
% GUI created by Metin Suloglu, 2018
% Bahcesehir University

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @remove_haze_OpeningFcn, ...
                   'gui_OutputFcn',  @remove_haze_OutputFcn, ...
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

% --- Executes just before remove_haze is made visible.
function remove_haze_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to remove_haze (see VARARGIN)

% Choose default command line output for remove_haze
handles.output = hObject;
handles.step = 0;

% Update handles structure
guidata(hObject, handles);
addpath('..');

% UIWAIT makes remove_haze wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = remove_haze_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in saveImageButton.
function saveImageButton_Callback(hObject, ~, ~)
% hObject    handle to saveImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[file, path] = uiputfile({'*.jpg';'*.png';'*.bmp';'*.tif';'*.tiff'},...
        'Save Image with Haze Removed', 'haze_removed.png');
if ~isequal(file,0) && ~isequal(path,0)
    if isfield(handles, 'radiance')
        imwrite(handles.radiance, [path file]);
    end
end

% --- Executes on button press in selectImageButton.
function selectImageButton_Callback(hObject, ~, handles)
% hObject    handle to selectImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
[file, path] = uigetfile({'*.jpg;*.png;*.bmp;*.tif;*.tiff',...
        'Image Files (.jpg, .png, .bmp, .tif, .tiff)'},...
        'Select Hazy Image');
if ~isequal(file, 0) && ~isequal(path, 0)
    handles.I = im2double(imread([path file]));
    cla(handles.orig_im);
    axes(handles.orig_im);
    im = imshow(handles.I);
    im.ButtonDownFcn = @orig_im_ButtonDownFcn;
    set(handles.dcXButton, 'Enable', 'on');
    set(handles.heXButton, 'Enable', 'on');
    set(handles.dcButton1, 'Enable', 'on');
    set(handles.dcButton2, 'Enable', 'on');
    set(handles.dcButton3, 'Enable', 'on');
    set(handles.dcButton4, 'Enable', 'on');
    handles = resetDCColours(handles);
    handles = resetALColours(handles);
    handles = resetTransColours(handles);
    handles = resetRefinedTransColours(handles);
    cla(handles.dc_im);
    cla(handles.airlight_im);
    cla(handles.ttilde_im);
    cla(handles.t_im);
    cla(handles.clear_im);
    cla(handles.he_im);
    handles.step = 0;
    guidata(hObject, handles);
end

    
% --- Executes on mouse press over axes background.
function orig_im_ButtonDownFcn(hObject, ~, ~)
% hObject    handle to orig_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if isfield(handles, 'I')
    figure;
    imshow(handles.I);
end


% --- Executes on mouse press over axes background.
function clear_im_ButtonDownFcn(hObject, ~, ~)
% hObject    handle to clear_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles = guidata(hObject);
handles = guidata(hObject);
if isfield(handles, 'radiance')
    figure;
    imshow(handles.radiance);
end


% --- Executes on mouse press over axes background.
function dc_im_ButtonDownFcn(hObject, ~, ~)
% hObject    handle to dc_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if isfield(handles, 'dc')
    figure;
    imshow(handles.dc);
end


% --- Executes on mouse press over axes background.
function airlight_im_ButtonDownFcn(hObject, ~, ~)
% hObject    handle to airlight_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if isfield(handles, 'A')
    figure;
    imshow(repmat(reshape(handles.A, 1, 1, 3), [100, 100]));
end


% --- Executes on mouse press over axes background.
function ttilde_im_ButtonDownFcn(hObject, ~, ~)
% hObject    handle to airlight_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if isfield(handles, 't_tilde')
    figure;
    imshow(handles.t_tilde);
end


% --- Executes on mouse press over axes background.
function t_im_ButtonDownFcn(hObject, ~, ~)
% hObject    handle to airlight_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if isfield(handles, 'trans')
    figure;
    imshow(handles.trans);
end


% --- Executes on mouse press over axes background.
function he_im_ButtonDownFcn(hObject, ~, ~)
% hObject    handle to he_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if isfield(handles, 'hequalized')
    figure;
    imshow(handles.hequalized);
end

% --- Executes on button press in dcButton2.
function dcButton1_Callback(hObject, ~, handles)
% hObject    handle to dcButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = resetDCColours(handles);
handles = resetALColours(handles);
handles = resetTransColours(handles);
handles = resetRefinedTransColours(handles);

handles = executeDC(handles);
guidata(hObject, handles);


% --- Executes on button press in dcButton2.
function dcButton2_Callback(hObject, ~, handles)
% hObject    handle to dcButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = resetALColours(handles);
handles = resetTransColours(handles);
handles = resetRefinedTransColours(handles);

if handles.step < 1
    handles = executeDC(handles);
end
handles = executeAL(handles);

guidata(hObject, handles);


% --- Executes on button press in dcButton3.
function dcButton3_Callback(hObject, ~, handles)
% hObject    handle to dcButton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = resetTransColours(handles);
handles = resetRefinedTransColours(handles);

if handles.step < 1
    handles = executeDC(handles);
end
if handles.step < 2
    handles = executeAL(handles);
end
handles = executeTrans(handles);

guidata(hObject, handles);


% --- Executes on button press in dcButton4.
function dcButton4_Callback(hObject, ~, handles)
% hObject    handle to dcButton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = resetRefinedTransColours(handles);

if handles.step < 1
    handles = executeDC(handles);
end
if handles.step < 2
    handles = executeAL(handles);
end
if handles.step < 3
    handles = executeTrans(handles);
end
handles = refineTrans(handles);
handles = calculateRadiance(handles);

guidata(hObject, handles);


% --- Executes on button press in dcXButton.
% Remove haze using the dark channel method from start to end.
function dcXButton_Callback(hObject, ~, handles)
% hObject    handle to dcXButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = resetDCColours(handles);
handles = resetALColours(handles);
handles = resetTransColours(handles);
handles = resetRefinedTransColours(handles);

handles = executeDC(handles);
handles = executeAL(handles);
handles = executeTrans(handles);
handles = refineTrans(handles);
handles = calculateRadiance(handles);

handles.step = 0;
handles = resetDCColours(handles);
handles = resetALColours(handles);
handles = resetTransColours(handles);
handles = resetRefinedTransColours(handles);

guidata(hObject, handles);


% --- Resets panel colors of dark channel section to white.
function handles = resetDCColours(handles)
handles.dcPanel.BackgroundColor = 'w';
handles.dcSettingPanel.BackgroundColor = 'w';
handles.dcWinsizeLabel.BackgroundColor = 'w';
handles.vanHerkCB.BackgroundColor = 'w';


% --- Resets panel colors of airlight section to white.
function handles = resetALColours(handles)
handles.alPanel.BackgroundColor = 'w';
handles.alSettingPanel.BackgroundColor = 'w';
handles.aPercLabel.BackgroundColor = 'w';


% --- Resets panel colors of transmission section to white.
function handles = resetTransColours(handles)
handles.ttildePanel.BackgroundColor = 'w';
handles.ttildeSettingPanel.BackgroundColor = 'w';
handles.tWLabel.BackgroundColor = 'w';
handles.tWinsizeLabel.BackgroundColor = 'w';


% --- Resets panel colors of soft matting section to white.
function handles = resetRefinedTransColours(handles)
handles.tPanel.BackgroundColor = 'w';
handles.tSettingPanel.BackgroundColor = 'w';
handles.tLambdaLabel.BackgroundColor = 'w';


% --- Calculates dark channel of the image stored in handles.
% Also updates color of panel to green and displays the image.
function handles = executeDC(handles)
use_van_herk = get(handles.vanHerkCB, 'Value');
win_size = str2double(get(handles.dcWindowSizeTF, 'String'));
if isnan(win_size)
    win_size = 15;
    warning('Invalid window size for dark channel calculation: Using 15x15 windows.');
end
if use_van_herk
    handles.dc = dark_channel_van_herk(handles.I, win_size);
else
    handles.dc = dark_channel(handles.I, win_size);
end
handles.dcPanel.BackgroundColor = [0.8 1 0.8];
handles.dcSettingPanel.BackgroundColor = [0.8 1 0.8];
handles.dcWinsizeLabel.BackgroundColor = [0.8 1 0.8];
handles.vanHerkCB.BackgroundColor = [0.8 1 0.8];
cla(handles.dc_im);
axes(handles.dc_im);
im = imshow(handles.dc);
im.ButtonDownFcn = @dc_im_ButtonDownFcn;
handles.step = 1;


% --- Calculates atmospheric light of the image stored in handles.
% Also updates color of panel to green and displays the image.
function handles = executeAL(handles)
perc = str2double(get(handles.percTF, 'String'));
if isnan(perc)
    perc = 0.001;
    warning('Invalid percentage value: Using 0.1% of brigtest pixels.');
else
    perc = perc / 100;
end
handles.A = atmospheric_light(handles.I, handles.dc, perc);
handles.alPanel.BackgroundColor = [0.8 1 0.8];
handles.alSettingPanel.BackgroundColor = [0.8 1 0.8];
handles.aPercLabel.BackgroundColor = [0.8 1 0.8];
cla(handles.airlight_im);
axes(handles.airlight_im);
im = imshow(repmat(reshape(handles.A, 1, 1, 3), [100, 100]));
im.ButtonDownFcn = @airlight_im_ButtonDownFcn;
handles.step = 2;


% --- Calculates transmission of the image stored in handles.
% Also updates color of panel to green and displays the transmission map.
function handles = executeTrans(handles)
w = str2double(get(handles.wTF, 'String'));
if isnan(w)
    w = 0.95;
    warning('Invalid aerial perspective parameter: Using 0.95%.');
end
win_size = str2double(get(handles.tWindowSizeTF, 'String'));
if isnan(win_size)
    win_size = 15;
    warning('Invalid window size for transmission calculation: Using 15x15 windows.');
end
handles.t_tilde = transmission(handles.I, handles.A, win_size, w);
handles.ttildePanel.BackgroundColor = [0.8 1 0.8];
handles.ttildeSettingPanel.BackgroundColor = [0.8 1 0.8];
handles.tWLabel.BackgroundColor = [0.8 1 0.8];
handles.tWinsizeLabel.BackgroundColor = [0.8 1 0.8];
cla(handles.ttilde_im);
axes(handles.ttilde_im);
im = imshow(handles.t_tilde);
im.ButtonDownFcn = @ttilde_im_ButtonDownFcn;
handles.step = 3;


% --- Soft matting step.
% Also updates color of panel to green and displays the refined transmission map.
function handles = refineTrans(handles)
lambda = str2double(get(handles.lambdaTF, 'String'));
if isnan(lambda)
    lambda = 1e-4;
    warning('Invalid soft matting parameter: Using 1e-4.');
end
handles.trans = refine_transmission(handles.I, handles.t_tilde, lambda);
handles.tPanel.BackgroundColor = [0.8 1 0.8];
handles.tSettingPanel.BackgroundColor = [0.8 1 0.8];
handles.tLambdaLabel.BackgroundColor = [0.8 1 0.8];
cla(handles.t_im);
axes(handles.t_im);
im = imshow(handles.trans);
im.ButtonDownFcn = @t_im_ButtonDownFcn;
handles.step = 4;


% --- Calculates the haze free image.
% Also displays the image on output axes.
function handles = calculateRadiance(handles)
t0 = str2double(get(handles.t0TF, 'String'));
if isnan(t0)
    t0 = 0.1;
    warning('Invalid lower bound for transmission: Using 0.1.');
end
handles.radiance = radiance(handles.I, handles.A, handles.trans, t0);
cla(handles.clear_im);
axes(handles.clear_im);
im = imshow(handles.radiance);
im.ButtonDownFcn = @clear_im_ButtonDownFcn;
set(handles.saveImageButton, 'Enable', 'on');
handles.step = 5;


% --- Executes on button press in heXButton.
% Applies contrast limited adaptive histogram equalization to the image.
function heXButton_Callback(hObject, ~, handles)
% hObject    handle to heXButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[~, ~, C] = size(handles.I);
handles.hequalized = zeros(size(handles.I));
for i = 1:C
    handles.hequalized(:, :, i) = adapthisteq(handles.I(:, :, i),...
        'ClipLimit', handles.heClipSlider.Value);
end
cla(handles.he_im);
axes(handles.he_im);
im = imshow(handles.hequalized);
im.ButtonDownFcn = @he_im_ButtonDownFcn;
handles.heMainPanel.BackgroundColor = [0.8 1 0.8];
handles.clipLimitLabel.BackgroundColor = [0.8 1 0.8];
handles.heSlider0.BackgroundColor = [0.8 1 0.8];
handles.heSlider1.BackgroundColor = [0.8 1 0.8];
pause(0.1);
handles.heMainPanel.BackgroundColor = 'w';
handles.clipLimitLabel.BackgroundColor = 'w';
handles.heSlider0.BackgroundColor = 'w';
handles.heSlider1.BackgroundColor = 'w';
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function dcWindowSizeTF_CreateFcn(hObject, ~, ~)
% hObject    handle to dcWindowSizeTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function percTF_CreateFcn(hObject, ~, ~)
% hObject    handle to percTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function wTF_CreateFcn(hObject, ~, ~)
% hObject    handle to wTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function tWindowSizeTF_CreateFcn(hObject, ~, ~)
% hObject    handle to tWindowSizeTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function lambdaTF_CreateFcn(hObject, ~, ~)
% hObject    handle to lambdaTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function t0TF_CreateFcn(hObject, ~, ~)
% hObject    handle to t0TF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function heClipSlider_CreateFcn(hObject, ~, ~)
% hObject    handle to heClipSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function dcWindowSizeTF_Callback(~, ~, ~)
% hObject    handle to dcWindowSizeTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dcWindowSizeTF as text
%        str2double(get(hObject,'String')) returns contents of dcWindowSizeTF as a double


function percTF_Callback(~, ~, ~)
% hObject    handle to percTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percTF as text
%        str2double(get(hObject,'String')) returns contents of percTF as a double


function wTF_Callback(~, ~, ~)
% hObject    handle to wTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wTF as text
%        str2double(get(hObject,'String')) returns contents of wTF as a double


function tWindowSizeTF_Callback(~, ~, ~)
% hObject    handle to tWindowSizeTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tWindowSizeTF as text
%        str2double(get(hObject,'String')) returns contents of tWindowSizeTF as a double


function lambdaTF_Callback(~, ~, ~)
% hObject    handle to lambdaTF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lambdaTF as text
%        str2double(get(hObject,'String')) returns contents of lambdaTF as a double


function t0TF_Callback(~, ~, ~)
% hObject    handle to t0TF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t0TF as text
%        str2double(get(hObject,'String')) returns contents of t0TF as a double


% --- Executes on slider movement.
function heClipSlider_Callback(~, ~, ~)
% hObject    handle to heClipSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
