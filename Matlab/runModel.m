clear; clc; close all;

load models7.mat
%%
arduinoObj = serialport("COM6",115200)
configureTerminator(arduinoObj,"CR/LF");
flush(arduinoObj);
% readline(arduinoObj)

%%
pause(2)
flush(arduinoObj);
flush(arduinoObj);
pause(2)
tline = readline(arduinoObj)
tline = readline(arduinoObj)

%%
% for j = 1:length(images)/24
%     ifFlame = model7_3.predictFcn(flatten(images(24*(j-1)+1:24*(j-1)+24,:)))
% end

%%
images = zeros(24,32);
while(1)
% for z = 1:2
    image = getImage_better(arduinoObj);
    images = cat(1, images, image);
    heatmap(image, 'Colormap',turbo,'ColorLimits',[10 110],'GridVisible','off');
    title("1: " + run_model(flatten(image), model7_1) + "   2: " + run_model(flatten(image), model7_2) + "   3: " + run_model(flatten(image), model7_3))
    pause(0.05)
end

%%
function ifFire = run_model(flattened_image, model)
    response = model.predictFcn(flattened_image);
    if max(max(flattened_image)) > 80
        ifFire = "Fire!!!!";
    elseif response == 0
        ifFire = "No Fire..";
    elseif response == 1
        ifFire = "Fire!!!!";
    else
        ifFire = response;
    end
end

%%
function image = getImage_better(arduinoObj)
    image = [];
    for i = 1:24
        tline = str2num(readline(arduinoObj));
        image = [image; tline];
    end
    tline = readline(arduinoObj);
    tline = readline(arduinoObj);
end
%%
function B = flatten(A) 
    B = [];
    for i = 1:size(A, 3)
        line = [];
        for j = 1:size(A(:,:,i), 1)
            line = [line A(j,:,i)];
        end
        B = [B; line];
        line = [];
    end
end