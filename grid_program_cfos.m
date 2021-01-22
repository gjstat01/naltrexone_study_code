function varargout = grid_program_cfos(varargin)
% grid_program_cfos MATLAB code for grid_program_cfos.fig
%      grid_program_cfos, by itself, creates a new grid_program_cfos or raises the existing
%      singleton*.
%
%      H = grid_program_cfos returns the handle to a new grid_program_cfos or the handle to
%      the existing singleton*.
%
%      grid_program_cfos('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in grid_program_cfos.M with the given input arguments.
%
%      grid_program_cfos('Property','Value',...) creates a new grid_program_cfos or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before grid_program_cfos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to grid_program_cfos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help grid_program_cfos

% Last Modified by GUIDE v2.5 27-Mar-2017 16:28:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @grid_program_cfos_OpeningFcn, ...
                   'gui_OutputFcn',  @grid_program_cfos_OutputFcn, ...
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


% --- Executes just before grid_program_cfos is made visible.
function grid_program_cfos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to grid_program_cfos (see VARARGIN)

% Choose default command line output for grid_program_cfos
handles.output = hObject;
handles.image_type = 1;

handles.heatmap_struct = struct('filename','','centroids_Y',[],'centroids_C',[],'centroids_YC',[],'centroids_GY',[],...
 'centroids_B',[],'centroids_GYB',[], 'centroids_GN',[], ... 
'central_canal',[],'adjusted_centroids_Y',[],'adjusted_centroids_C',[],'adjusted_centroids_YC',[],'adjusted_centroids_GY',[],...
'adjusted_centroids_B',[],'adjusted_centroids_GYB',[], 'adjusted_centroids_GN',[],'image',[]);


handles.matrix_settings = {'near_red','cyan','red';'red','yellow','black'};

handles.channel_val = 'Cyan';
handles.plot_val = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes grid_program_cfos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = grid_program_cfos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_im_dir.
function listbox_im_dir_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_im_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_im_dir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_im_dir

if isfield(handles,'centroids') 
    if ~isempty(ishandle(handles.centroids))
        handles.centroids = [];
    end
end
if isfield(handles,'central_canal') 
    if ~isempty(ishandle(handles.central_canal)) 
        handles.central_canal = [];
    end
end


index = get(handles.listbox_im_dir,'value');

handles.image_name = handles.image_directory{index};

imname = fullfile(handles.folder_name,handles.image_name);
image = imread(imname);


handles.fig1 = figure();


handles.newaxes = axes('Parent', handles.fig1);

imshow(image,'Parent',handles.newaxes)


% imstack = struct('layers',[]);
% for i = 1:4
%     imstack(i).layers = imadjust(imread(imname,i),[0;0.5],[0;1]); %Change filename accordingly
% end
% 
% imsize = size(imstack(1).layers);
% 
% green = cat(3,zeros(imsize),imstack(3).layers,zeros(imsize));
% red = cat(3,imstack(4).layers,zeros(imsize),zeros(imsize));
% blue = cat(3,zeros(imsize),zeros(imsize),imstack(2).layers);
% nearred = cat(3,imstack(1).layers,zeros(imsize),imstack(1).layers);
% merge = cat(3,(imstack(1).layers+imstack(4).layers)/2,imstack(3).layers,(imstack(2).layers+imstack(1).layers)/2);
handles.image = image;
handles.centroids_Y = '';
handles.centroids_C = '';
handles.centroids_YC = '';
handles.centroids_GY = '';
handles.centroids_B = '';
handles.centroids_GYB = '';
handles.centroids_GN = '';
handles.central_canal = '';

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox_im_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_im_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function open_folder_Callback(hObject, eventdata, handles)
% hObject    handle to open_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.status_indicator,'String','Busy')
set(handles.status_indicator,'BackgroundColor',[1 0 0])


folder_name = uigetdir;
handles.folder_name = folder_name;

%cd(folder_name)

if handles.image_type == 1
    full_directory = dir(folder_name);
    full_directory = struct2cell(full_directory);
    
    IndexFD = strfind(full_directory(1,:), '.tif');
    Index = not(cellfun('isempty', IndexFD));

    
    image_directory = full_directory(1,Index);
    
elseif handles.image_type == 2
    full_directory = dir(folder_name);
    full_directory = struct2cell(full_directory);
    
    IndexFD = strfind(full_directory(1,:), '.jp');
    Index = not(cellfun('isempty', IndexFD));

    
    image_directory = full_directory(1,Index);
elseif handles.image_type == 3
    full_directory = dir(folder_name);
    full_directory = struct2cell(full_directory);
    
    IndexFD = strfind(full_directory(1,:), '.png');
    Index = not(cellfun('isempty', IndexFD));

    
    image_directory = full_directory(1,Index);
elseif handles.image_type == 4
    full_directory = dir(folder_name);
    full_directory = struct2cell(full_directory);
    
    IndexFD = strfind(full_directory(1,:), '.bmp');
    Index = not(cellfun('isempty', IndexFD));

    
    image_directory = full_directory(1,Index);
end

for i = length(image_directory):-1:1
    current_file = image_directory{i};
    if strcmp(current_file(1), '.') == 1
        image_directory(i) = [];
    end
end


handles.image_directory = image_directory;
% % % for x = 1 : length(image_directory)   
% % %     
% % %     handles.images{x} = imread(fullfile(folder_name,image_directory{x}));
% % %     
% % % end

set(handles.listbox_im_dir,'string',image_directory);


set(handles.status_indicator,'String','Ready')
set(handles.status_indicator,'BackgroundColor',[0 1 0])
guidata(hObject, handles);


% --- Executes on button press in button_centroids.
function button_centroids_Callback(hObject, eventdata, handles)
% hObject    handle to button_centroids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.newaxes)

image = handles.image;


% image_R = double(image(:,:,1) == 0);
% image_G = double(image(:,:,2) == 255);
% image_B = double(image(:,:,3) == 0);

% image_comp = image_R + image_G + image_B;
% crosshair_blobs = logical(image_comp(:,:) == 3);

% s = regionprops(crosshair_blobs,'centroid');
% centroids = cat(1, s.Centroid);
% 
% 
% 
% imshow(image,'Parent',handles.newaxes);
% hold on
% % set(h,'AlphaData',0.5);
% plot(centroids(:,1),centroids(:,2), 'k*')
% hold off
% 
% handles.centroids = centroids;

%
image_R = double(image(:,:,1) == 255);
image_G = double(image(:,:,2) == 255);
image_B = double(image(:,:,3) == 255);

image_R0 = double(image(:,:,1) == 0);
image_G0 = double(image(:,:,2) == 0);
image_B0 = double(image(:,:,3) == 0);

image_R128 = double(image(:,:,1) == 128);
image_G128 = double(image(:,:,2) == 128);
image_B128 = double(image(:,:,3) == 128);

%
image_comp_Y = image_R + image_G +image_B0;
image_comp_C = image_R0 + image_G +image_B;
image_comp_GY = image_R128 + image_G128 +image_B128;
image_comp_B = image_R0 + image_G0 +image_B;
image_comp_GN = image_R0 + image_G +image_B0;

crosshair_blobs_Y = logical(image_comp_Y(:,:) == 3);
crosshair_blobs_C = logical(image_comp_C(:,:) == 3);
crosshair_blobs_GY = logical(image_comp_GY(:,:) == 3);
crosshair_blobs_B = logical(image_comp_B(:,:) == 3);
crosshair_blobs_GN = logical(image_comp_GN(:,:) == 3);

%
sY = regionprops(crosshair_blobs_Y,'centroid');
centroids_Y = cat(1, sY.Centroid);

sC = regionprops(crosshair_blobs_C,'centroid');
centroids_C = cat(1, sC.Centroid);

sGY = regionprops(crosshair_blobs_GY,'centroid');
centroids_GY = cat(1, sGY.Centroid);

sB = regionprops(crosshair_blobs_B,'centroid');
centroids_B = cat(1, sB.Centroid);

sGN = regionprops(crosshair_blobs_GN,'centroid');
centroids_GN = cat(1, sGN.Centroid);

centroids_YC = handles.centroids_YC;
centroids_GYB = handles.centroids_GYB;

%
imshow(image,'Parent',handles.newaxes);
hold on
% set(h,'AlphaData',0.5);
if ~isempty(centroids_Y)
    plot(centroids_Y(:,1),centroids_Y(:,2), 'b*')
end
if ~isempty(centroids_C)
    plot(centroids_C(:,1),centroids_C(:,2), 'r*')
end
if ~isempty(centroids_YC)
    plot(centroids_YC(:,1),centroids_YC(:,2), 'g*')
end
if ~isempty(centroids_GY)
    plot(centroids_GY(:,1),centroids_GY(:,2), 'w*')
end
if ~isempty(centroids_B)
    plot(centroids_B(:,1),centroids_B(:,2), 'y*')
end
if ~isempty(centroids_GYB)
    plot(centroids_GYB(:,1),centroids_GYB(:,2), 'b*')
end
if ~isempty(centroids_GN)
    plot(centroids_GN(:,1),centroids_GN(:,2), 'm*')
end
hold off


handles.centroids_Y = centroids_Y;
handles.centroids_C = centroids_C;
handles.centroids_GY = centroids_GY;
handles.centroids_B = centroids_B;
handles.centroids_GN = centroids_GN;



guidata(hObject, handles);


% --- Executes on button press in button_central_canal.
function button_central_canal_Callback(hObject, eventdata, handles)
% hObject    handle to button_central_canal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.newaxes)
image = handles.image;

central_canal = ginput(1);

handles.central_canal = central_canal;


if isfield(handles,'centroids_Y') == 1 || isfield(handles,'centroids_C') == 1 || isfield(handles,'centroids_YC') == 1 
    if isempty(handles.centroids_Y) + isempty(handles.centroids_C) + isempty(handles.centroids_YC) < 3
        centroids_Y = handles.centroids_Y;
        centroids_C = handles.centroids_C;
        centroids_YC = handles.centroids_YC;
        centroids_GY = handles.centroids_GY;
        centroids_B = handles.centroids_B;
        centroids_GYB = handles.centroids_GYB;
        centroids_GN = handles.centroids_GN;
        imshow(image,'Parent',handles.newaxes);
        hold on
        % set(h,'AlphaData',0.5);
        plot(central_canal(:,1),central_canal(:,2),'*','Color',[1 0.5 0])
        if ~isempty(centroids_Y)
            plot(centroids_Y(:,1),centroids_Y(:,2), 'b*')
        end
        if ~isempty(centroids_C)
            plot(centroids_C(:,1),centroids_C(:,2), 'r*')
        end
        if ~isempty(centroids_YC)
            plot(centroids_YC(:,1),centroids_YC(:,2), 'g*')
        end
        if ~isempty(centroids_GY)
            plot(centroids_GY(:,1),centroids_GY(:,2), 'w*')
        end
        if ~isempty(centroids_B)
            plot(centroids_B(:,1),centroids_B(:,2), 'y*')
        end
        if ~isempty(centroids_GYB)
            plot(centroids_GYB(:,1),centroids_GYB(:,2), 'b*')
        end
        if ~isempty(centroids_GN)
            plot(centroids_GN(:,1),centroids_GN(:,2), 'm*')
        end
        hold off
    
    else
        imshow(image,'Parent',handles.newaxes);
        hold on
        % set(h,'AlphaData',0.5);
        plot(central_canal(:,1),central_canal(:,2),'*','Color',[1 0.5 0])
        hold off
    end
else
    imshow(image,'Parent',handles.newaxes);
    hold on
    % set(h,'AlphaData',0.5);
    plot(central_canal(:,1),central_canal(:,2),'*','Color',[1 0.5 0])
    hold off
end



guidata(hObject, handles);



% --- Executes on selection change in listbox_heatmap.
function listbox_heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_heatmap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_heatmap


index = get(hObject,'Value');

heatmap_struct = handles.heatmap_struct;
centroids_Y = heatmap_struct(index).centroids_Y;
centroids_C = heatmap_struct(index).centroids_C;
centroids_YC = heatmap_struct(index).centroids_YC;
centroids_GY = heatmap_struct(index).centroids_GY;
centroids_B = heatmap_struct(index).centroids_B;
centroids_GYB = heatmap_struct(index).centroids_GYB;
centroids_GN = heatmap_struct(index).centroids_GN;
central_canal = heatmap_struct(index).central_canal;



image = heatmap_struct(index).image;

handles.fig1 = figure();


handles.newaxes = axes('Parent', handles.fig1);

imshow(image,'Parent',handles.newaxes)
hold on
% set(h,'AlphaData',0.5);
if ~isempty(centroids_Y)
    plot(centroids_Y(:,1),centroids_Y(:,2), 'b*')
end
if ~isempty(centroids_C)
    plot(centroids_C(:,1),centroids_C(:,2), 'r*')
end
if ~isempty(centroids_YC)
    plot(centroids_YC(:,1),centroids_YC(:,2), 'g*')
end
if ~isempty(centroids_GY)
    plot(centroids_GY(:,1),centroids_GY(:,2), 'w*')
end
if ~isempty(centroids_B)
    plot(centroids_B(:,1),centroids_B(:,2), 'y*')
end
if ~isempty(centroids_GYB)
    plot(centroids_GYB(:,1),centroids_GYB(:,2), 'b*')
end
if ~isempty(centroids_GN)
    plot(centroids_GN(:,1),centroids_GN(:,2), 'm*')
end
plot(central_canal(:,1),central_canal(:,2),'*','Color',[1 0.5 0])
hold off

handles.heatmap_struct = heatmap_struct;
handles.edit_index = index;
handles.image = image;
handles.image_name = heatmap_struct(index).filename;
handles.centroids_Y = centroids_Y;
handles.centroids_C = centroids_C;
handles.centroids_YC = centroids_YC;
handles.centroids_GY = centroids_GY;
handles.centroids_B = centroids_B;
handles.centroids_GYB = centroids_GYB;
handles.centroids_GN = centroids_GN;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function listbox_heatmap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_add_to_heatmap.
function button_add_to_heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to button_add_to_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

heatmap_struct = handles.heatmap_struct;

filename_mat = cell(length(heatmap_struct),1);
for i = 1:length(heatmap_struct)
    filename_mat(i,1) = {heatmap_struct(i).filename};
end




if isfield(handles,'centroids_Y') == 1 && isfield(handles,'central_canal') == 1 
    if isempty(handles.centroids_Y) + isempty(handles.centroids_C) + isempty(handles.centroids_YC) == 3
        erroricon = imread('error.jpg');
        msgbox('Count crosshairs before saving','Oh no','custom',erroricon)
    elseif isempty(ishandle(handles.central_canal)) == 1
        erroricon = imread('error.jpg');
        msgbox('Detect central canal before saving','Oh no','custom',erroricon)
    else
        struct_size = length(heatmap_struct);

        centroids_Y = handles.centroids_Y;
        centroids_C = handles.centroids_C;
        centroids_YC = handles.centroids_YC;
        centroids_GY = handles.centroids_GY;
        centroids_B = handles.centroids_B;
        centroids_GYB = handles.centroids_GYB;
        centroids_GN = handles.centroids_GN;                
        central_canal = handles.central_canal;    
        
        if ~ismember(handles.image_name,filename_mat)     
            if struct_size == 1
                if isempty(heatmap_struct.filename)

                    heatmap_struct(1).filename = handles.image_name;
                    %
                    heatmap_struct(1).centroids_Y = centroids_Y;
                    heatmap_struct(1).centroids_C = centroids_C;
                    heatmap_struct(1).centroids_YC = centroids_YC;
                    heatmap_struct(1).centroids_GY = centroids_GY;
                    heatmap_struct(1).centroids_B = centroids_B;
                    heatmap_struct(1).centroids_GYB = centroids_GYB;
                    heatmap_struct(1).centroids_GN = centroids_GN;                
                    heatmap_struct(1).central_canal = central_canal;
                    %
                    if ~isempty(centroids_Y)
                        heatmap_struct(1).adjusted_centroids_Y = [centroids_Y(:,1) - central_canal(1), centroids_Y(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_C)
                        heatmap_struct(1).adjusted_centroids_C = [centroids_C(:,1) - central_canal(1), centroids_C(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_YC)
                        heatmap_struct(1).adjusted_centroids_YC = [centroids_YC(:,1) - central_canal(1), centroids_YC(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_GY)
                        heatmap_struct(1).adjusted_centroids_GY = [centroids_GY(:,1) - central_canal(1), centroids_GY(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_B)
                        heatmap_struct(1).adjusted_centroids_B = [centroids_B(:,1) - central_canal(1), centroids_B(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_GYB)
                        heatmap_struct(1).adjusted_centroids_GYB = [centroids_GYB(:,1) - central_canal(1), centroids_GYB(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_GN)
                        heatmap_struct(1).adjusted_centroids_GN = [centroids_GN(:,1) - central_canal(1), centroids_GN(:,2) - central_canal(2)];
                    end
                    heatmap_struct(1).image = handles.image;

                    handles.heatmap_struct = heatmap_struct;
                else

                    heatmap_struct(2).filename = handles.image_name;
                    heatmap_struct(2).centroids_Y = centroids_Y;
                    heatmap_struct(2).centroids_C = centroids_C;
                    heatmap_struct(2).centroids_YC = centroids_YC;
                    heatmap_struct(2).centroids_GY = centroids_GY;
                    heatmap_struct(2).centroids_B = centroids_B;
                    heatmap_struct(2).centroids_GYB = centroids_GYB;
                    heatmap_struct(2).centroids_GN = centroids_GN; 
                    heatmap_struct(2).central_canal = central_canal;

                    if ~isempty(centroids_Y)
                        heatmap_struct(2).adjusted_centroids_Y = [centroids_Y(:,1) - central_canal(1), centroids_Y(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_C)
                        heatmap_struct(2).adjusted_centroids_C = [centroids_C(:,1) - central_canal(1), centroids_C(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_YC)
                        heatmap_struct(2).adjusted_centroids_YC = [centroids_YC(:,1) - central_canal(1), centroids_YC(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_GY)
                        heatmap_struct(2).adjusted_centroids_GY = [centroids_GY(:,1) - central_canal(1), centroids_GY(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_B)
                        heatmap_struct(2).adjusted_centroids_B = [centroids_B(:,1) - central_canal(1), centroids_B(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_GYB)
                        heatmap_struct(2).adjusted_centroids_GYB = [centroids_GYB(:,1) - central_canal(1), centroids_GYB(:,2) - central_canal(2)];
                    end
                    if ~isempty(centroids_GN)
                        heatmap_struct(2).adjusted_centroids_GN = [centroids_GN(:,1) - central_canal(1), centroids_GN(:,2) - central_canal(2)];
                    end
                    heatmap_struct(2).image = handles.image;

                    handles.heatmap_struct = heatmap_struct;
                end
            else

                central_canal = handles.central_canal;
                heatmap_struct(struct_size + 1).filename = handles.image_name;
                heatmap_struct(struct_size + 1).centroids_Y = centroids_Y;
                heatmap_struct(struct_size + 1).centroids_C = centroids_C;
                heatmap_struct(struct_size + 1).centroids_YC = centroids_YC;
                heatmap_struct(struct_size + 1).centroids_GY = centroids_GY;
                heatmap_struct(struct_size + 1).centroids_B = centroids_B;
                heatmap_struct(struct_size + 1).centroids_GYB = centroids_GYB;
                heatmap_struct(struct_size + 1).centroids_GN = centroids_GN;

                heatmap_struct(struct_size + 1).central_canal = central_canal;
                
                if ~isempty(centroids_Y)
                    heatmap_struct(struct_size + 1).adjusted_centroids_Y = [centroids_Y(:,1) - central_canal(1), centroids_Y(:,2) - central_canal(2)];
                end
                if ~isempty(centroids_C)
                    heatmap_struct(struct_size + 1).adjusted_centroids_C = [centroids_C(:,1) - central_canal(1), centroids_C(:,2) - central_canal(2)];
                end
                if ~isempty(centroids_YC)
                    heatmap_struct(struct_size + 1).adjusted_centroids_YC = [centroids_YC(:,1) - central_canal(1), centroids_YC(:,2) - central_canal(2)];
                end
                if ~isempty(centroids_GY)
                    heatmap_struct(struct_size + 1).adjusted_centroids_GY = [centroids_GY(:,1) - central_canal(1), centroids_GY(:,2) - central_canal(2)];
                end
                if ~isempty(centroids_B)
                    heatmap_struct(struct_size + 1).adjusted_centroids_B = [centroids_B(:,1) - central_canal(1), centroids_B(:,2) - central_canal(2)];
                end
                if ~isempty(centroids_GYB)
                    heatmap_struct(struct_size + 1).adjusted_centroids_GYB = [centroids_GYB(:,1) - central_canal(1), centroids_GYB(:,2) - central_canal(2)];
                end
                if ~isempty(centroids_GN)
                    heatmap_struct(struct_size + 1).adjusted_centroids_GN = [centroids_GN(:,1) - central_canal(1), centroids_GN(:,2) - central_canal(2)];
                end

                heatmap_struct(struct_size + 1).image = handles.image;

                handles.heatmap_struct = heatmap_struct;
            end
        else     
            central_canal = handles.central_canal;
            edit_index = handles.edit_index;
            
            heatmap_struct(edit_index).filename = handles.image_name;
            heatmap_struct(edit_index).centroids_Y = centroids_Y;
            heatmap_struct(edit_index).centroids_C = centroids_C;
            heatmap_struct(edit_index).centroids_YC = centroids_YC;
            heatmap_struct(edit_index).centroids_GY = centroids_GY;
            heatmap_struct(edit_index).centroids_B = centroids_B;
            heatmap_struct(edit_index).centroids_GYB = centroids_GYB;
            heatmap_struct(edit_index).centroids_GN = centroids_GN;

            heatmap_struct(edit_index).central_canal = central_canal;
            if ~isempty(centroids_Y)
                heatmap_struct(edit_index).adjusted_centroids_Y = [centroids_Y(:,1) - central_canal(1), centroids_Y(:,2) - central_canal(2)];
            end
            if ~isempty(centroids_C)
                heatmap_struct(edit_index).adjusted_centroids_C = [centroids_C(:,1) - central_canal(1), centroids_C(:,2) - central_canal(2)];
            end
            if ~isempty(centroids_YC)
                heatmap_struct(edit_index).adjusted_centroids_YC = [centroids_YC(:,1) - central_canal(1), centroids_YC(:,2) - central_canal(2)];
            end
            if ~isempty(centroids_GY)
                heatmap_struct(edit_index).adjusted_centroids_GY = [centroids_GY(:,1) - central_canal(1), centroids_GY(:,2) - central_canal(2)];
            end
            if ~isempty(centroids_B)
                heatmap_struct(edit_index).adjusted_centroids_B = [centroids_B(:,1) - central_canal(1), centroids_B(:,2) - central_canal(2)];
            end
            if ~isempty(centroids_GYB)
                heatmap_struct(edit_index).adjusted_centroids_GYB = [centroids_GYB(:,1) - central_canal(1), centroids_GYB(:,2) - central_canal(2)];
            end
            if ~isempty(centroids_GN)
                heatmap_struct(edit_index).adjusted_centroids_GN = [centroids_GN(:,1) - central_canal(1), centroids_GN(:,2) - central_canal(2)];
            end

            heatmap_struct(edit_index).image = handles.image;

            handles.heatmap_struct = heatmap_struct;    
        end
        fname = {heatmap_struct(:).filename};
        
        set(handles.listbox_heatmap,'string',fname)
        %set(handles.listbox_heatmap,'value',[])
    end

else
    erroricon = imread('error.jpg');
    msgbox('There is nothing to save','Oh no','custom',erroricon)
    
    
    
end




guidata(hObject, handles);






% --- Executes on button press in button_add_crosshair.
function button_add_crosshair_Callback(hObject, eventdata, handles)
% hObject    handle to button_add_crosshair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.newaxes)
image = handles.image;

centroids_Y = handles.centroids_Y;
centroids_C = handles.centroids_C;
centroids_YC = handles.centroids_YC;
centroids_GY = handles.centroids_GY;
centroids_B = handles.centroids_B;
centroids_GYB = handles.centroids_GYB;
centroids_GN = handles.centroids_GN;  
        
        
xlim = get(handles.newaxes, 'XLim');
ylim = get(handles.newaxes, 'YLim');

new_centroids = ginput;

if strcmp(handles.channel_val,'Yellow') == 1
    if ~isempty(centroids_Y)
        centroids_Y = cat(1,centroids_Y,new_centroids);        
    else 
        centroids_Y = new_centroids;
    end
    handles.centroids_Y = centroids_Y;
    
elseif strcmp(handles.channel_val,'Cyan') == 1
    if ~isempty(centroids_C)
        centroids_C = cat(1,centroids_C,new_centroids);        
    else 
        centroids_C = new_centroids;
    end
    handles.centroids_C = centroids_C;
    
elseif strcmp(handles.channel_val,'Cyan + Yellow') == 1
    if ~isempty(centroids_YC)
        centroids_YC = cat(1,centroids_YC,new_centroids);        
    else 
        centroids_YC = new_centroids;
    end
    handles.centroids_YC = centroids_YC;
    
elseif strcmp(handles.channel_val,'Gray') == 1
    if ~isempty(centroids_GY)
        centroids_GY = cat(1,centroids_GY,new_centroids);        
    else 
        centroids_GY = new_centroids;
    end
    handles.centroids_GY = centroids_GY;
    
elseif strcmp(handles.channel_val,'Blue') == 1
    if ~isempty(centroids_B)
        centroids_B = cat(1,centroids_B,new_centroids);        
    else 
        centroids_B = new_centroids;
    end
    handles.centroids_B = centroids_B;

elseif strcmp(handles.channel_val,'Gray + Blue') == 1
    if ~isempty(centroids_GYB)
        centroids_GYB = cat(1,centroids_GYB,new_centroids);        
    else 
        centroids_GYB = new_centroids;
    end
    handles.centroids_GYB = centroids_GYB;
    
elseif strcmp(handles.channel_val,'Green') == 1
    if ~isempty(centroids_GN)
        centroids_GN = cat(1,centroids_GN,new_centroids);        
    else 
        centroids_GN = new_centroids;
    end
    handles.centroids_GN = centroids_GN;
end

h = imshow(image,'Parent',handles.newaxes);
hold on
% set(h,'AlphaData',0.5);
if ~isempty(centroids_Y)
    plot(centroids_Y(:,1),centroids_Y(:,2), 'b*')
end
if ~isempty(centroids_C)
    plot(centroids_C(:,1),centroids_C(:,2), 'r*')
end
if ~isempty(centroids_YC)
    plot(centroids_YC(:,1),centroids_YC(:,2), 'g*')
end
if ~isempty(centroids_GY)
    plot(centroids_GY(:,1),centroids_GY(:,2), 'w*')
end
if ~isempty(centroids_B)
    plot(centroids_B(:,1),centroids_B(:,2), 'y*')
end
if ~isempty(centroids_GYB)
    plot(centroids_GYB(:,1),centroids_GYB(:,2), 'b*')
end
if ~isempty(centroids_GN)
    plot(centroids_GN(:,1),centroids_GN(:,2), 'm*')
end
hold off

set(handles.newaxes, 'XLim', xlim);
set(handles.newaxes, 'YLim', ylim);

guidata(hObject, handles);

% --- Executes on button press in button_delete_crosshair.
function button_delete_crosshair_Callback(hObject, eventdata, handles)
% hObject    handle to button_delete_crosshair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.newaxes) %call to axes may not be necessary
image = handles.image;

centroids_Y = handles.centroids_Y;
centroids_C = handles.centroids_C;
centroids_YC = handles.centroids_YC;
centroids_GY = handles.centroids_GY;
centroids_B = handles.centroids_B;
centroids_GYB = handles.centroids_GYB;
centroids_GN = handles.centroids_GN;  


xlim = get(handles.newaxes, 'XLim');
ylim = get(handles.newaxes, 'YLim');

h = imfreehand;
freehand_image = h.createMask();
B = bwboundaries(freehand_image,4,'noholes');
[max_size, max_index] = max(cellfun('size', B, 1));
area = B{max_index};

if strcmp(handles.channel_val,'Yellow') == 1
    deletemat = inpolygon(centroids_Y(:,1),centroids_Y(:,2),area(:,2),area(:,1));
    centroids_Y(deletemat == 1,:) = [];
    handles.centroids_Y = centroids_Y;
    
elseif strcmp(handles.channel_val,'Cyan') == 1
    deletemat = inpolygon(centroids_C(:,1),centroids_C(:,2),area(:,2),area(:,1));
    centroids_C(deletemat == 1,:) = [];
    handles.centroids_C = centroids_C;

elseif strcmp(handles.channel_val,'Cyan + Yellow') == 1
    deletemat = inpolygon(centroids_YC(:,1),centroids_YC(:,2),area(:,2),area(:,1));
    centroids_YC(deletemat == 1,:) = [];
    handles.centroids_YC = centroids_YC;
    
elseif strcmp(handles.channel_val,'Gray') == 1
    deletemat = inpolygon(centroids_GY(:,1),centroids_GY(:,2),area(:,2),area(:,1));
    centroids_GY(deletemat == 1,:) = [];
    handles.centroids_GY = centroids_GY;

elseif strcmp(handles.channel_val,'Blue') == 1
    deletemat = inpolygon(centroids_B(:,1),centroids_B(:,2),area(:,2),area(:,1));
    centroids_B(deletemat == 1,:) = [];
    handles.centroids_B = centroids_B;
    
elseif strcmp(handles.channel_val,'Gray + Blue') == 1
    deletemat = inpolygon(centroids_GYB(:,1),centroids_GYB(:,2),area(:,2),area(:,1));
    centroids_GYB(deletemat == 1,:) = [];
    handles.centroids_GYB = centroids_GYB;
    
elseif strcmp(handles.channel_val,'Green') == 1
    deletemat = inpolygon(centroids_GN(:,1),centroids_GN(:,2),area(:,2),area(:,1));
    centroids_GN(deletemat == 1,:) = [];
    handles.centroids_GN = centroids_GN;    
    
end


h = imshow(image,'Parent',handles.newaxes);
hold on
% set(h,'AlphaData',0.5);
if ~isempty(centroids_Y)
    plot(centroids_Y(:,1),centroids_Y(:,2), 'b*')
end
if ~isempty(centroids_C)
    plot(centroids_C(:,1),centroids_C(:,2), 'r*')
end
if ~isempty(centroids_YC)
    plot(centroids_YC(:,1),centroids_YC(:,2), 'g*')
end
if ~isempty(centroids_GY)
    plot(centroids_GY(:,1),centroids_GY(:,2), 'w*')
end
if ~isempty(centroids_B)
    plot(centroids_B(:,1),centroids_B(:,2), 'y*')
end
if ~isempty(centroids_GYB)
    plot(centroids_GYB(:,1),centroids_GYB(:,2), 'b*')
end
if ~isempty(centroids_GN)
    plot(centroids_GN(:,1),centroids_GN(:,2), 'm*')
end
hold off

set(handles.newaxes, 'XLim', xlim);
set(handles.newaxes, 'YLim', ylim);

guidata(hObject, handles);
 

% --- Executes on button press in heatmap_plot_all.
function heatmap_plot_all_Callback(hObject, eventdata, handles)
% hObject    handle to heatmap_plot_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%centroids_new = [centroids(:,1) - central_canal(1), centroids(:,2) - central_canal(2)];

axes(handles.axes_heatmap)

heatmap_struct = handles.heatmap_struct;

if handles.plot_val == 1 %% Plot "All LAPNs" selected
%    centroids_new_Y = [];
    centroids_new_C = [];
%     centroids_new_YC = [];
    for i = 1:length(heatmap_struct)
%         centroids_new_Y = cat(1,centroids_new_Y, heatmap_struct(i).adjusted_centroids_Y);
        centroids_new_C = cat(1,centroids_new_C, heatmap_struct(i).adjusted_centroids_R);
%         centroids_new_YC = cat(1,centroids_new_YC, heatmap_struct(i).adjusted_centroids_YC);
    end
    

%     centroids_new = cat(1, centroids_new_Y, centroids_new_C, centroids_new_YC);
    centroids_new = centroids_new_C;
    
    
    
    
elseif handles.plot_val == 2 %% Plot "All animals, ipsi LAPNs" selected
    centroids_new_Y = [];
    centroids_new_C = [];
    centroids_new_YC = [];
    for i = 1:length(heatmap_struct)
        centroids_new_Y = cat(1,centroids_new_Y, heatmap_struct(i).adjusted_centroids_Y);
        centroids_new_C = cat(1,centroids_new_C, heatmap_struct(i).adjusted_centroids_C);
        centroids_new_YC = cat(1,centroids_new_YC, heatmap_struct(i).adjusted_centroids_YC);
    end
    
    centroids_new_Y_log = centroids_new_Y(:,1) > 0;
    centroids_new_C_log = centroids_new_C(:,1) < 0;
    
    centroids_new_Y(centroids_new_Y_log == 0, :) = [];
    centroids_new_C(centroids_new_C_log == 0, :) = [];
    


%     centroids_new = cat(1, centroids_new_Y, centroids_new_C, centroids_new_YC);
    centroids_new = cat(1, centroids_new_C, centroids_new_YC);
    


elseif handles.plot_val == 3 %% Plot "All animals, contra LAPNs" selected
    centroids_new_Y = [];
    centroids_new_C = [];
    centroids_new_YC = [];
    for i = 1:length(heatmap_struct)
        centroids_new_Y = cat(1,centroids_new_Y, heatmap_struct(i).adjusted_centroids_Y);
        centroids_new_C = cat(1,centroids_new_C, heatmap_struct(i).adjusted_centroids_C);
        centroids_new_YC = cat(1,centroids_new_YC, heatmap_struct(i).adjusted_centroids_YC);
    end
    
    centroids_new_Y_log = centroids_new_Y(:,1) < 0;
    centroids_new_C_log = centroids_new_C(:,1) > 0;
    
    centroids_new_Y(centroids_new_Y_log == 0, :) = [];
    centroids_new_C(centroids_new_C_log == 0, :) = [];
    


    centroids_new = cat(1, centroids_new_Y, centroids_new_C, centroids_new_YC);
    
elseif handles.plot_val == 4 %% Plot "LAPNs that are L1-projection positive" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
    
    
    
elseif handles.plot_val == 5 %% Plot "LAPNs that are L1-local positive, ipsi local" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) > 0;
    centroids_new_B_log = centroids_new_B(:,1) > 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) > 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 6 %% Plot "LAPNs that are L1-local positive, contra local" selected
  
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) < 0;
    centroids_new_B_log = centroids_new_B(:,1) < 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) < 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);

elseif handles.plot_val == 7 %% Plot "Ipsi-LAPNs that are L1-local projecting positive" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) > 0;
    centroids_new_B_log = centroids_new_B(:,1) < 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
    
elseif handles.plot_val == 8 %% Plot "Ipsi-LAPNs that are L1-local positive, ipsi local" selected
    centroids_new_GY = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) > 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) > 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY,centroids_new_GYB);
    
elseif handles.plot_val == 9 %% Plot "Ipsi-LAPNs that are L1-local positive, contra local" selected
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_B_log = centroids_new_B(:,1) < 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) < 0;
    
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 10 %% Plot "Contra-LAPNs that are L1-local projecting positive" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) < 0;
    centroids_new_B_log = centroids_new_B(:,1) > 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 11 %% Plot "Contra-LAPNs that are L1-local positive, ipsi local" selected
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_B_log = centroids_new_B(:,1) > 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) > 0;
    
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 12 %% Plot "Contra-LAPNs that are L1-local positive, contra local" selected
    centroids_new_GY = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) < 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) < 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY,centroids_new_GYB);
elseif handles.plot_val == 13 %% Plot "LAPNs that are L5-projection positive" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
    
    
    
elseif handles.plot_val == 14 %% Plot "LAPNs that are L5-local positive, ipsi local" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) > 0;
    centroids_new_B_log = centroids_new_B(:,1) > 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) > 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 15 %% Plot "LAPNs that are L5-local positive, contra local" selected
  
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) < 0;
    centroids_new_B_log = centroids_new_B(:,1) < 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) < 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);

elseif handles.plot_val == 16 %% Plot "Ipsi-LAPNs that are L5-local projecting positive" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) > 0;
    centroids_new_B_log = centroids_new_B(:,1) < 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
    
elseif handles.plot_val == 17 %% Plot "Ipsi-LAPNs that are L5-local positive, ipsi local" selected
    centroids_new_GY = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) > 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) > 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY,centroids_new_GYB);
    
elseif handles.plot_val == 18 %% Plot "Ipsi-LAPNs that are L5-local positive, contra local" selected
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_B_log = centroids_new_B(:,1) < 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) < 0;
    
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 19 %% Plot "Contra-LAPNs that are L5-local projecting positive" selected
    centroids_new_GY = [];
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) < 0;
    centroids_new_B_log = centroids_new_B(:,1) > 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_B(centroids_new_B_log == 0, :) = [];    
    
    centroids_new = cat(1, centroids_new_GY, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 20 %% Plot "Contra-LAPNs that are L5-local positive, ipsi local" selected
    centroids_new_B = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_B = cat(1,centroids_new_B, heatmap_struct(i).adjusted_centroids_B);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_B_log = centroids_new_B(:,1) > 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) > 0;
    
    centroids_new_B(centroids_new_B_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_B,centroids_new_GYB);
elseif handles.plot_val == 21 %% Plot "Contra-LAPNs that are L5-local positive, contra local" selected
    centroids_new_GY = [];
    centroids_new_GYB = [];
    for i = 1:length(heatmap_struct)
        centroids_new_GY = cat(1,centroids_new_GY, heatmap_struct(i).adjusted_centroids_GY);
        centroids_new_GYB = cat(1,centroids_new_GYB, heatmap_struct(i).adjusted_centroids_GYB);
    end
    centroids_new_GY_log = centroids_new_GY(:,1) < 0;
    centroids_new_GYB_log = centroids_new_GYB(:,1) < 0;
    
    centroids_new_GY(centroids_new_GY_log == 0, :) = [];
    centroids_new_GYB(centroids_new_GYB_log == 0, :) = [];
    
    
    centroids_new = cat(1, centroids_new_GY,centroids_new_GYB);
  
    
    
end







% Conversion factor of 10 micrometers per 3 pixels used, check accuracy
% 0.65um/pix
    % Y-axis is inverted
    centroids_new = [centroids_new(:,1)*(0.65), centroids_new(:,2)*(-0.65)];

    XMin = min(centroids_new(:,1));
    XMax = max(centroids_new(:,1));
    YMin = min(centroids_new(:,2));
    YMax = max(centroids_new(:,2));
%     XMin = -1200;
%     XMax = 1200;
%     YMin = -1200;
%     YMax = 1200;
    
%     xrange = XMax - XMin;
%     yrange = YMax - YMin;

    bin_size = str2double(get(handles.heatmap_bin_size,'String'));

%     grid = ceil(max(xrange,yrange)/bin_size);   %refinement of map, adjust to um (original 256)
    grid = 4000 / bin_size;
    
%     minvals = min(centroids_new);
%     maxvals = max(centroids_new);
%     rangevals = maxvals - minvals;
    rangevals = [4000 4000];
    
%     xidx = 1 + round((centroids_new(:,1) - minvals(1)) ./ rangevals(1) * (grid-1));
%     yidx = 1 + round((centroids_new(:,2) - minvals(2)) ./ rangevals(2) * (grid-1));
    
    xidx = 1 + round((centroids_new(:,1) - (-2000)) ./ rangevals(1) * (grid-1));
    yidx = 1 + round((centroids_new(:,2) - (-2000)) ./ rangevals(2) * (grid-1));     
    
    colorbar_max = str2double(get(handles.colorbar_max,'String'));
    colorbar_tick = str2double(get(handles.colorbar_tick,'String'));
    density = accumarray([yidx, xidx], 1, [grid,grid])/(length(heatmap_struct)/2);  %note y is rows, x is cols
%     imagesc(density, 'xdata', [minvals(1), maxvals(1)], 'ydata', [minvals(2), maxvals(2)],'Parent',handles.axes_heatmap);
%     imagesc(density, 'xdata', [XMin XMax], 'ydata', [YMin YMax],'Parent',handles.axes_heatmap);
    imagesc(density, 'xdata', [-2000 2000], 'ydata', [-2000 2000],'Parent',handles.axes_heatmap);
%     colorbar('peer',handles.axes_heatmap,'Ticks',0:5:25)
    colorbar('peer',handles.axes_heatmap,'Ticks',0:colorbar_tick:colorbar_max)
    caxis([0 colorbar_max])
    set(handles.axes_heatmap,'YDir','normal')   

handles.heatmap_struct = heatmap_struct;


guidata(hObject, handles);



% --- Executes on button press in heatmap_plot_indiv.
function heatmap_plot_indiv_Callback(hObject, eventdata, handles)
% hObject    handle to heatmap_plot_indiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_heatmap)

heatmap_struct = handles.heatmap_struct;
hmap_index = get(handles.listbox_heatmap,'Value');

if handles.plot_val == 1 %% Plot "Contra-LAPNs" selected
   centroids_new_Y = heatmap_struct(hmap_index).adjusted_centroids_Y;
   centroids_new_C = heatmap_struct(hmap_index).adjusted_centroids_C;
    
    centroids_new_Y_log = centroids_new_Y(:,1) < 0;
    centroids_new_C_log = centroids_new_C(:,1) > 0;
    
    centroids_new_Y(centroids_new_Y_log == 0, :) = [];
    centroids_new_C(centroids_new_C_log == 0, :) = [];
    
    centroids_new = cat(1, centroids_new_Y, centroids_new_C);
    
    
    
elseif handles.plot_val == 2 %% Plot "Contra-LAPNs w/ ipsi-lumbar" selected
    centroids_new = heatmap_struct(hmap_index).adjusted_centroids_B;
    
    centroids_new_log = centroids_new(:,1) > 0;    
    centroids_new(centroids_new_log == 0, :) = [];
    


elseif handles.plot_val == 3 %% Plot "Contra-LAPNs w/ contra-lumbar" selected
    centroids_new = heatmap_struct(hmap_index).adjusted_centroids_GY;
    
    centroids_new_log = centroids_new(:,1) < 0;    
    centroids_new(centroids_new_log == 0, :) = [];
    
elseif handles.plot_val == 4 %% Plot "Ipsi-LAPNs" selected
    centroids_new_Y = heatmap_struct(hmap_index).adjusted_centroids_Y;
    centroids_new_C = heatmap_struct(hmap_index).adjusted_centroids_C;
    
    centroids_new_Y_log = centroids_new_Y(:,1) > 0;
    centroids_new_C_log = centroids_new_C(:,1) < 0;
    
    centroids_new_Y(centroids_new_Y_log == 0, :) = [];
    centroids_new_C(centroids_new_C_log == 0, :) = [];
    
    centroids_new = cat(1, centroids_new_Y, centroids_new_C);
    
    
elseif handles.plot_val == 5 %% Plot "Ipsi-LAPNs w/ ipsi-lumbar" selected
    centroids_new = heatmap_struct(hmap_index).adjusted_centroids_GY;
    
    centroids_new_log = centroids_new(:,1) > 0;    
    centroids_new(centroids_new_log == 0, :) = [];
    
elseif handles.plot_val == 6 %% Plot "Ipsi-LAPNs w/ contra-lumbar" selected
    centroids_new = heatmap_struct(hmap_index).adjusted_centroids_B;
    
    centroids_new_log = centroids_new(:,1) < 0;    
    centroids_new(centroids_new_log == 0, :) = [];    
elseif handles.plot_val == 7 %% Plot "LAPN w/ bilateral cervical projections" selected
    
    centroids_new = heatmap_struct(hmap_index).adjusted_centroids_GN;

elseif handles.plot_val == 8
    centroids_new_Y = heatmap_struct(hmap_index).adjusted_centroids_Y;
    centroids_new_C = heatmap_struct(hmap_index).adjusted_centroids_C;
    
    centroids_new = cat(1, centroids_new_Y, centroids_new_C);
    
end

% Conversion factor of 10 micrometers per 3 pixels used, check accuracy
    % Y-axis is inverted
    centroids_new = [centroids_new(:,1)*(10/3), centroids_new(:,2)*(-10/3)];

    XMin = min(centroids_new(:,1));
    XMax = max(centroids_new(:,1));
    YMin = min(centroids_new(:,2));
    YMax = max(centroids_new(:,2));
%     XMin = -1200;
%     XMax = 1200;
%     YMin = -1200;
%     YMax = 1200;
    
%     xrange = XMax - XMin;
%     yrange = YMax - YMin;

    bin_size = str2double(get(handles.heatmap_bin_size,'String'));

%     grid = ceil(max(xrange,yrange)/bin_size);   %refinement of map, adjust to um (original 256)
    grid = 4000 / bin_size;
    
%     minvals = min(centroids_new);
%     maxvals = max(centroids_new);
%     rangevals = maxvals - minvals;
    rangevals = [4000 4000];
    
%     xidx = 1 + round((centroids_new(:,1) - minvals(1)) ./ rangevals(1) * (grid-1));
%     yidx = 1 + round((centroids_new(:,2) - minvals(2)) ./ rangevals(2) * (grid-1));
    
    xidx = 1 + round((centroids_new(:,1) - (-2000)) ./ rangevals(1) * (grid-1));
    yidx = 1 + round((centroids_new(:,2) - (-2000)) ./ rangevals(2) * (grid-1));     
    
    colorbar_max = str2double(get(handles.colorbar_max,'String'));
    colorbar_tick = str2double(get(handles.colorbar_tick,'String'));
    density = accumarray([yidx, xidx], 1, [grid,grid]);  %note y is rows, x is cols
%     imagesc(density, 'xdata', [minvals(1), maxvals(1)], 'ydata', [minvals(2), maxvals(2)],'Parent',handles.axes_heatmap);
%     imagesc(density, 'xdata', [XMin XMax], 'ydata', [YMin YMax],'Parent',handles.axes_heatmap);
    imagesc(density, 'xdata', [-2000 2000], 'ydata', [-2000 2000],'Parent',handles.axes_heatmap);
%     colorbar('peer',handles.axes_heatmap,'Ticks',0:5:25)
    colorbar('peer',handles.axes_heatmap,'Ticks',0:colorbar_tick:colorbar_max)
    caxis([0 colorbar_max])
    set(handles.axes_heatmap,'YDir','normal')   

handles.heatmap_struct = heatmap_struct;
guidata(hObject, handles);


function heatmap_bin_size_Callback(hObject, eventdata, handles)
% hObject    handle to heatmap_bin_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heatmap_bin_size as text
%        str2double(get(hObject,'String')) returns contents of heatmap_bin_size as a double


% --- Executes during object creation, after setting all properties.
function heatmap_bin_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heatmap_bin_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function heatmap_menu_Callback(hObject, eventdata, handles)
% hObject    handle to heatmap_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to save_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

heatmap_struct = handles.heatmap_struct;


struct_size = length(heatmap_struct);

if struct_size == 1
    if isempty(heatmap_struct.filename)
        erroricon = imread('error.jpg');
        msgbox('There is nothing to save','Oh no','custom',erroricon)
    else
        [filename,pathname] = uiputfile('*.mat');
        save([pathname filename],'heatmap_struct')
    end
else
    [filename,pathname] = uiputfile('*.mat');
    save([pathname filename],'heatmap_struct')
end           
      


handles.heatmap_struct = heatmap_struct;

guidata(hObject, handles);





% --------------------------------------------------------------------
function edit_heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to edit_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function open_heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to open_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile;

if ~isequal(filename,0)
    load([pathname filename])
    handles.heatmap_struct = heatmap_struct;
    
    fname = {heatmap_struct(:).filename};        
    set(handles.listbox_heatmap,'string',fname)   
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function save_image_Callback(hObject, eventdata, handles)
% hObject    handle to save_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% F = getframe(handles.axes_heatmap);
% Image = frame2im(F);
% [filename,pathname] = uiputfile('*.jpg');
% imwrite(Image, [pathname filename])

% addpath('altmany-export_fig')
[filename,pathname] = uiputfile('*.tif');
export_fig(handles.axes_heatmap, [pathname filename])


% --------------------------------------------------------------------
function settings_Callback(hObject, eventdata, handles)
% hObject    handle to settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f = figure;
t = uitable(f);


t.Data = handles.matrix_settings;
t.Position = [20 20 258 78];

t.ColumnName = {'Channel','Marker color','New Marker Color'};
t.ColumnEditable = true;


% --- Executes on selection change in channel_select.
function channel_select_Callback(hObject, eventdata, handles)
% hObject    handle to channel_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel_select
contents = cellstr(get(hObject,'String'));
handles.channel_val = contents{get(hObject,'Value')};
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function channel_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in plotting_menu.
function plotting_menu_Callback(hObject, eventdata, handles)
% hObject    handle to plotting_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plotting_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotting_menu

handles.plot_val = get(hObject,'Value');
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function plotting_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotting_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colorbar_max_Callback(hObject, eventdata, handles)
% hObject    handle to colorbar_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorbar_max as text
%        str2double(get(hObject,'String')) returns contents of colorbar_max as a double


% --- Executes during object creation, after setting all properties.
function colorbar_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorbar_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colorbar_tick_Callback(hObject, eventdata, handles)
% hObject    handle to colorbar_tick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorbar_tick as text
%        str2double(get(hObject,'String')) returns contents of colorbar_tick as a double


% --- Executes during object creation, after setting all properties.
function colorbar_tick_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorbar_tick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_remove_from_heatmap.
function button_remove_from_heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to button_remove_from_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if ~isempty(handles.edit_index)
    index = handles.edit_index;
    heatmap_struct = handles.heatmap_struct;
    
    heatmap_struct(index) = [];
    
    handles.heatmap_struct = heatmap_struct;
    fname = {heatmap_struct(:).filename};
          
    set(handles.listbox_heatmap,'string',fname)
    
    if index < length(heatmap_struct)
        set(handles.listbox_heatmap,'Value', index)
    else
        set(handles.listbox_heatmap,'Value', index - 1)
    end
end

guidata(hObject, handles);
