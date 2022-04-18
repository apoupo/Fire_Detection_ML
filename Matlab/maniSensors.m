clear; clc; close all;

fid = fopen('sensorOutput.txt');
tline = 'poop';
okayLOL = [];
cnt1 = 0;
cnt2 = 0;
image = [];
while ischar(tline)
    tline = fgetl(fid);
    line = [];
    cnt = 0;
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
    cnt1 = cnt1 + 1;
    cnt2 = cnt2 + 1;
    image = [image; okayLOL];
    okayLOL = [];
    if cnt1 == 24
        tline = fgetl(fid);
        tline = fgetl(fid);
        cnt1 = 0;
    end
    if cnt2 == 934
        break;
    end
end

%%
A = image(1:24,:);
for i = 2:length(image)/24
    A = cat(3,A,image(24*(i-1)+1:24*(i-1)+24,:));
end

%%
images = [];
fireWarning = 80;
fireMaybe = 60;
for i = 1:length(image)/24
    fig = heatmap(A(:,:,i), 'Colormap',turbo,'ColorLimits',[20 110],'GridVisible','off');
    title(i)
    if max(max(A(:,:,i))) > fireWarning
        title(i + ": FIRE WARNING!")
    elseif max(max(A(:,:,i))) > fireMaybe
        title(i + ": FIRE MAYBE!")
    else
        title(i + ": everythings A-OKAY...")
    end
%     saveas(fig,['.\images\image_' num2str(i) '.png']);
pause(0.5)
end

%%
maxes = [];
for i = 1:36
    maxes = [maxes max(max(A(:,:,i)))];
end
plot(maxes)