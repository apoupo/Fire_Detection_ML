clear; clc; close all;

arduinoObj = serialport("COM6",115200)
configureTerminator(arduinoObj,"CR/LF");
flush(arduinoObj);
% readline(arduinoObj)

%%

tline = readline(arduinoObj);
tline = readline(arduinoObj);
tline = readline(arduinoObj);
tline = readline(arduinoObj);
fps = 16;

while(1)
    heatmap(getImage, 'Colormap',turbo,'ColorLimits',[10 110],'GridVisible','off');
    pause(1/fps)
end

%%
function image = getImage()
    image = [];
    for i = 1:24
        tline = readline(arduinoObj);
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
    end
    tline = readline(arduinoObj);
    tline = readline(arduinoObj);
end