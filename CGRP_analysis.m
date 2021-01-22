function varargout = CGRP_analysis(varargin)
% CGRP_ANALYSIS MATLAB code for CGRP_analysis.fig
%      CGRP_ANALYSIS, by itself, creates a new CGRP_ANALYSIS or raises the existing
%      singleton*.
%
%      H = CGRP_ANALYSIS returns the handle to a new CGRP_ANALYSIS or the handle to
%      the existing singleton*.
%
%      CGRP_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CGRP_ANALYSIS.M with the given input arguments.
%
%      CGRP_ANALYSIS('Property','Value',...) creates a new CGRP_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CGRP_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CGRP_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CGRP_analysis

% Last Modified by GUIDE v2.5 18-Aug-2020 11:31:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CGRP_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @CGRP_analysis_OutputFcn, ...
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


% --- Executes just before CGRP_analysis is made visible.
function CGRP_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CGRP_analysis (see VARARGIN)

% Choose default command line output for CGRP_analysis
handles.output = hObject;
handles.threshval = 0.3;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CGRP_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CGRP_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

index = get(handles.listbox1,'value');

image_directory = handles.image_directory;

data = bfopen(fullfile(handles.folder_name,image_directory{index}));
series1 = data{1, 1};
handles.original_pic = imsharpen(imsharpen(series1{1, 1}));


nrows = size(handles.original_pic,1);
ncols = size(handles.original_pic,2);
handles.nrows = nrows;
handles.ncols = ncols;
handles.red = cat(3, ones(nrows,ncols),zeros(nrows,ncols),zeros(nrows,ncols));
handles.blank_image = zeros(nrows,ncols);

imshow(handles.original_pic, [1000 30000], 'Parent', handles.axes_original)

handles.filename = image_directory{index};

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in button_erase.
function button_erase_Callback(hObject, eventdata, handles)
% hObject    handle to button_erase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

original_pic = handles.original_pic;
BW = handles.BW;
red = cat(3, ones(handles.nrows,handles.ncols), zeros(handles.nrows,handles.ncols), zeros(handles.nrows,handles.ncols));

% imshow(original_pic);
% hold on
h = imshow(red, 'Parent', handles.axes_original);
% hold off
set(h, 'AlphaData', BW*0.5)

h = imfreehand;
freehand_image = h.createMask();

new_image = imbinarize(logical(BW) - freehand_image);

BW = new_image;

imshow(original_pic, [1000 30000]);
hold on
h = imshow(red, 'Parent', handles.axes_original);
hold off
set(h, 'AlphaData', BW*0.5)

handles.BW = BW;

guidata(hObject, handles);



% --- Executes on button press in button_threshold.
function button_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to button_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original_pic = handles.original_pic;

% BW = edge(original_pic,'Prewitt');
% BW = imbinarize(original_pic, handles.threshval);
BW = zeros(handles.nrows, handles.ncols);

BW(original_pic > handles.threshval * 2^16) = 1;

red = cat(3, ones(handles.nrows,handles.ncols), zeros(handles.nrows,handles.ncols), zeros(handles.nrows,handles.ncols));

imshow(handles.original_pic, [1000 30000], 'Parent', handles.axes_original)
hold on
h = imshow(red, 'Parent', handles.axes_original);
hold off
set(h, 'AlphaData', BW*0.5)

handles.BW = BW;
guidata(hObject, handles);



function editbox_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to editbox_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editbox_threshold as text
%        str2double(get(hObject,'String')) returns contents of editbox_threshold as a double
threshval = str2double(get(hObject,'String'))/100;

if threshval < 0
    threshval = 0;
elseif threshval > 100
    threshval = 1;
end

handles.threshval = threshval;

set(handles.slider1, 'Value', threshval)

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editbox_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbox_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu_open_folder_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
handles.folder_name = folder_name;

full_directory = dir(folder_name);
full_directory = struct2cell(full_directory);

IndexFD = strfind(full_directory(1,:), '.nd2');
Index = not(cellfun('isempty', IndexFD));


image_directory = full_directory(1,Index);

for i = length(image_directory):-1:1
    current_file = image_directory{i};
    if strcmp(current_file(1), '.') == 1
        image_directory(i) = [];
    end
end


handles.image_directory = image_directory;
% for x = 1 : length(image_directory)   
%     
%     handles.images{x} = imread(fullfile(folder_name,image_directory{x}));
%     
% end

set(handles.listbox1,'string',image_directory);

guidata(hObject, handles);




% --------------------------------------------------------------------
function menu_save_image_Callback(hObject, eventdata, handles)
% hObject    handle to menu_save_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uiputfile([handles.folder_name '\*.tif']);
BW = handles.BW; original_pic = handles.original_pic;

index = get(handles.listbox1,'value');

image_directory = handles.image_directory;

imname = image_directory{index};
fname = strsplit(imname,'.');

save([fname{1} '.mat'], 'BW', 'original_pic')
export_fig(handles.axes_original, [pathname filename])





% --------------------------------------------------------------------
function menu_save_excel_Callback(hObject, eventdata, handles)
% hObject    handle to menu_save_excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_sprouting_analysis.
function button_sprouting_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to button_sprouting_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

newpic = handles.newpic;
newbw = handles.newbw;

wid = round(50/0.33); hei = 1500; 
% distbox = 300;

red = cat(3, ones(handles.nrows,handles.ncols), zeros(handles.nrows,handles.ncols), zeros(handles.nrows,handles.ncols));



[x,y] = ginput(3);

% [x,y] = ginput(1);

% imshow(original_pic)
imshow(newpic,[1000 30000],'Parent', handles.axes_original)
hold on
h = imshow(red, 'Parent', handles.axes_original);
% rectangle('Position',[round(x-wid/2) round(y) wid hei],'EdgeColor','b');
% rectangle('Position',[round(x-wid/2)-distbox round(y) wid hei],'EdgeColor','g');
% rectangle('Position',[round(x-wid/2)+distbox round(y) wid hei],'EdgeColor','g');
rectangle('Position',[round(x(1)-wid/2) round(y(1)) wid hei],'EdgeColor','b');
rectangle('Position',[round(x(2)-wid/2) round(y(2)) wid hei],'EdgeColor','g');
rectangle('Position',[round(x(3)-wid/2) round(y(3)) wid hei],'EdgeColor','g');
hold off
set(h, 'AlphaData', newbw*0.5)

% R1 = newbw(round(y):round(y+hei),round(x-wid/2):round(x+wid/2));
% R2 = newbw(round(y):round(y+hei),round(x-wid/2)-distbox:round(x+wid/2-distbox));
% R3 = newbw(round(y):round(y+hei),round(x-wid/2)+distbox:round(x+wid/2+distbox));

R1 = newbw(round(y(1)):round(y(1)+hei),round(x(1)-wid/2):round(x(1)+wid/2));
R2 = newbw(round(y(2)):round(y(2)+hei),round(x(2)-wid/2):round(x(2)+wid/2));
R3 = newbw(round(y(3)):round(y(3)+hei),round(x(3)-wid/2):round(x(3)+wid/2));



outcomemat = zeros(37,3);
for i = 1:37
    curind = i*30;
    outcomemat(i,1) = sum(sum(R1(curind-29:curind,:)));
    outcomemat(i,2) = sum(sum(R2(curind-29:curind,:)));
    outcomemat(i,3) = sum(sum(R3(curind-29:curind,:)));
end

CGRP_fname0 = handles.filename;
CGRP_fname = strsplit(CGRP_fname0,'.');

save([CGRP_fname{1} '.mat'], 'outcomemat');

guidata(hObject, handles)
% 
% hold on
% % plot([p3(1), p1(1)], [p3(2),p1(2)])
% plot(R1(:,1),R1(:,2))
% hold off


% --- Executes on button press in button_total_area.
function button_total_area_Callback(hObject, eventdata, handles)
% hObject    handle to button_total_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BW = handles.BW;

area_in_pix = sum(sum(BW));

% Area in um assumes 20x acquisition on inverted scope: .33um/pix
area_in_um = area_in_pix/9;

set(handles.textbox_total_area, 'String', num2str(round(area_in_um,2)))


% --------------------------------------------------------------------
function menu_load_image_Callback(hObject, eventdata, handles)
% hObject    handle to menu_load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat');

load(fullfile(pathname, filename))

handles.BW = BW;
handles.original_pic = original_pic;
handles.nrows = size(BW, 1); handles.ncols = size(BW, 2);

imshow(original_pic,'Parent', handles.axes_original)

fname = strsplit(filename,'.'); 
set(handles.textbox_total_area, 'String', fname{1})

guidata(hObject, handles)


% --- Executes on button press in button_rotatecenter.
function button_rotatecenter_Callback(hObject, eventdata, handles)
% hObject    handle to button_rotatecenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original_pic = handles.original_pic;
BW = handles.BW;


checkbox_val = get(handles.checkbox_lr, 'Value');

imshow(original_pic, [1000 30000], 'Parent', handles.axes_original)

[x,y] = ginput(2);

u = [x(2)-x(1), y(2)-y(1)]; u = u/norm(u); %u1 = u*-1; 


 v = [0, 1, 0];


if x(2) > x(1)
    u90 = [u(1), u(2), 0]; 
    ator = atan2d(norm(cross(u90,v)),dot(u90,v)) * -(u90(1)/abs(u90(1))); 
    newpic = imrotate(original_pic, ator);
    newbw = imrotate(BW, ator);
else
    u90 = [-u(1), u(2), 0]; 
    ator = -atan2d(norm(cross(u90,v)),dot(u90,v)) * -(u90(1)/abs(u90(1)));
    newpic = imrotate(original_pic, ator);
    newbw = imrotate(BW, ator); 
end




% newpic = imrotate(original_pic, ator, 'crop');
% newbw = imrotate(BW, ator, 'crop');


nrows = size(newpic,1); ncols = size(newpic,2);

red = cat(3, ones(nrows,ncols), zeros(nrows,ncols), zeros(nrows,ncols));


imshow(newpic, [1000 30000])
hold on
h = imshow(red);
hold off
set(h, 'AlphaData', newbw*0.5)

% [cx, cy] = ginput(1);
% handles.centerpt = [cx, cy];

handles.newpic = newpic;
handles.newbw = newbw;

handles.nrows = nrows; handles.ncols = ncols;





guidata(hObject, handles)


% --- Executes on button press in button_save_rotated.
function button_save_rotated_Callback(hObject, eventdata, handles)
% hObject    handle to button_save_rotated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

index = get(handles.listbox1,'value');

image_directory = handles.image_directory;

imname = image_directory{index};
fname = strsplit(imname,'.');


% [filename,pathname] = uiputfile([handles.folder_name '\*.tif']);

newbw = handles.newbw; newpic = handles.newpic; centerpt = handles.centerpt;


imname = [get(handles.textbox_total_area, 'String'), '_rotated'];

save([fname{1} '.mat'], 'newbw', 'newpic', 'centerpt')

pathname = handles.folder_name; filename = ['\' fname{1} '.tif'];
export_fig(handles.axes_original, [pathname filename])



% 
% imshow(newpic)
% hold on
% scatter(centerpt(1) ,centerpt(2))
% hold off


% --- Executes on button press in button_rotate_cw.
function button_rotate_cw_Callback(hObject, eventdata, handles)
% hObject    handle to button_rotate_cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original_pic = handles.original_pic;
original_pic = imrotate(original_pic, -90);
nrows = size(original_pic,1);
ncols = size(original_pic,2);
handles.nrows = nrows;
handles.ncols = ncols;

handles.original_pic = original_pic;

imshow(handles.original_pic, [1000 30000], 'Parent', handles.axes_original)

guidata(hObject, handles)

% --- Executes on button press in button_rotate_CCW.
function button_rotate_CCW_Callback(hObject, eventdata, handles)
% hObject    handle to button_rotate_CCW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original_pic = handles.original_pic;
original_pic = imrotate(original_pic, 90);
nrows = size(original_pic,1);
ncols = size(original_pic,2);
handles.nrows = nrows;
handles.ncols = ncols;

handles.original_pic = original_pic;

imshow(handles.original_pic, [1000 30000], 'Parent', handles.axes_original)

guidata(hObject, handles)


% --- Executes on button press in checkbox_lr.
function checkbox_lr_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_lr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_lr
