clear; clc; close all;

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
images = zeros(24,32);
while(1)
% for z = 1:2
    image = getImage_better(arduinoObj);
    images = cat(1, images, image);
    heatmap(image, 'Colormap',turbo,'ColorLimits',[10 110],'GridVisible','off');
    pause(0.05)
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

function image = getImage(arduinoObj)
    image = [];
    cnt = 0;
    okayLOL= [];
    for i = 1:24
        tline = convertStringsToChars(readline(arduinoObj));
        line = [];
        for j = 1:length(tline)
            cnt = cnt + 1;
            line = [line tline(j)];
            if cnt == 5
                line = line(1:end-1);
            elseif cnt == 6
                cnt = 0;
                val = str2double(line);
                okayLOL = [okayLOL val];
                line = [];
            end
        end
        image = [image; okayLOL];
        okayLOL = [];
    end
    tline = readline(arduinoObj);
    tline = readline(arduinoObj);
end