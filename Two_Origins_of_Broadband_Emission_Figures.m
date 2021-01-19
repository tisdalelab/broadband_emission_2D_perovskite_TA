% This code loads and plots all transient absorption data collected and 
% analyzed in the journal article "Two Origins of Broadband Emission in 
% Multilayered 2D Lead Iodide Perovskites" published in the Journal of 
% Physical Chemistry Letters in 2020 by Watcharaphol Paritmongkol, Eric 
% Powers, Nabeel Dahod, and William Tisdale.
% doi: 10.1021/acs.jpclett.0c02214
% The code was written by Eric Powers in 2020.

% To load all data, go to Section 1 (line 14). To plot visible TA data, go
% to Section 2 (line 25). To plot infrared TA data, go to Section 3 (line
% 143).


%% Load in Raw Data
% Load the data in once and then comment this section out.

%{
load('n234BAMA_nochirpcorr.mat')
load('n234BAMA_withchirpcorr.mat')
load('NPL_IR.mat')
load('C.mat') %colormap
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visible 2D TA Plots
% You can generate one visible 2D TA plot at a time. Uncomment one section
% (e.g. uncomment lines 37-43) while leaving the others commented out.

% It may be necessary to run the Visible and IR 2D plots separately and rerun the
% following two lines of code at the end to get the figures to display properly.
%set(ax1,'units','normalized','position',[0.08 0.15 0.81 0.3]);
%set(ax2,'units','normalized','position',[0.08 0.45 0.81 0.48]);

close all
% {

% {
% Figure 3b and S6a
dat = n2BAMA_chrpcorr; % format: "n2BAMA" or "n2BAMA_chrpcorr"
NPL = 'n2BAMA';
xlims = [1.95,2.45]; %n2
clims = [-2e-3,2e-3];
%}

%{
% Figure S6b
dat = n3BAMA_chrpcorr; % format: "n2BAMA" or "n2BAMA_chrpcorr"
NPL = 'n3BAMA';
xlims = [1.75,2.25];
clims = [-4e-3,4e-3];
%}

%{
% Figure S6c
dat = n4BAMA_chrpcorr; % format: "n2BAMA" or "n2BAMA_chrpcorr"
NPL = 'n4BAMA';
xlims = [1.75,2.1];
clims = [-4e-3,4e-3];
%}

% No need to edit anything below this line for the visible 2D plot section.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

linlog = 10; %breakpoint between linear and log scales

% Selecting the correct run to plot
% 1100-1200uW
%n2BAMA 6
%n3BAMA 5
%n4BAMA 5
if strcmp(NPL(1:2),'n2')
    run = 6;
else
    run = 5;
end

wave = dat(run).wave;
energy = 1240./wave;
time = dat(run).time;
avg = dat(run).avg;
temp = dat(run).temp;
power = round(dat(run).power,2,'significant');

numavg = 1;
indices = timefind(time,linlog,numavg);
index = indices{1};

name = ['n=',NPL(2),' ',NPL(3:end-2),' ',NPL(end-1:end),'PbI_3 NPL'];

avg(40:60,:) = avg(40:60,:).*0; % cutting out 450nm red tail tripled
plotter = avg';
plot1 = plotter(1:index,:);
time1 = time(1:index);
plot2 = plotter(index+1:end,:);
time2 = time(index+1:end);
g1 = figure(1);
set(g1, 'Position',  [200, 50, 700, 550])

sgtitle([name, ' Transient Absorption, T=',num2str(temp),'K, Power=',num2str(power),'uW'])
ax1 = subplot(211);
pcolor(energy,time1,plot1)
shading('flat')
caxis(clims)
xticks(1.8:0.1:2.4);
xlabel('Energy (eV)')

ax2 = subplot(212);
pcolor(energy,time2,plot2)

shading('flat')
colormap(flipud(C))
caxis(clims)
set(ax1,'units','normalized','position',[0.08 0.15 0.81 0.3]);
set(ax2,'units','normalized','position',[0.08 0.45 0.81 0.48]);
ycutoff = linlog-0.01;
set(ax1,'ylim',[-1,ycutoff],'TickDir','out')
set(ax2,'yscale','log','ylim',[linlog time(end)],'TickDir','out');%,'yticklabel','');
set([ax1 ax2],'xlim',xlims);%,'box','off');

set(ax2,'xticklabel','')
set(ax2,'XTick',[]);
ax1.XAxis.TickLength = [0 0];
ax2.XAxis.TickLength = [0 0];
uistack(ax1,'top');

set([ax1,ax2],'xdir','reverse')
set([ax1,ax2],'FontSize',12)

c = colorbar;
c.Position = [0.91 0.18 0.02 0.64];
c.Label.String = '\Delta OD';
c.FontSize = 10;
c.TickLength = [0];

p1=get(ax1,'position');
p2=get(ax2,'position');

ax3 = axes('position',[0.055 0.5 0 0],'visible','off');
ax_label=ylabel('Time Delay (ps)','visible','on','FontSize',12);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IR 2D TA Plots
% You can generate one infrared 2D TA plot at a time. Uncomment one section
% (e.g. Uncomment lines 20-26) while leaving the others commented out.

% It may be necessary to run the Visible and IR 2D plots separately and rerun the
% following two lines of code at the end to get the figures to display properly.
%set(ax1,'units','normalized','position',[0.08 0.15 0.81 0.3]);
%set(ax2,'units','normalized','position',[0.08 0.45 0.81 0.48]);

%{

%{
% Figure 3c and S7a
dat = n2BAMAIR1;
NPL = 'n2BAMA';
run = 2;
xlims = [0.8,1.28];
cscale = 14;
clims = [-cscale*1e-5,cscale*2e-6];
%}

%{
% Figure S7b
dat = n2BAFAIR1;
NPL = 'n2BAFA';
run = 8; 
xlims = [0.8,1.28];
cscale = 16;
clims = [-cscale*1e-5,cscale*2e-6];
%}

%{
% Figure S7c
dat = n2PEAMAIR1;
NPL = 'n2PEAMA';
run = 1;
xlims = [0.8,1.28];
cscale = 22;
clims = [-cscale*1e-5,cscale*2e-6];
%}

%{
% Figure S8
% For plotting the figures at 10K, 30K, 50K, 80K, 120K, and 170K, change 
% run to 1, 3, 5, 8, 9, and 11, respectively.
dat = n2BAFAIR1;
NPL = 'n2BAFA';
run = 1; %Temperature series: 1,3,5,8,9,11
xlims = [0.8,1.28];
cscale = 16;
clims = [-cscale*1e-5,cscale*2e-6];
%}

% No need to edit anything below this line for the IR 2D plot section.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

linlog = 10; %breakpoint between linear and log scales

wave = dat(run).wave;
energy = 1240./wave;
time = dat(run).time;
avg = dat(run).avg;
temp = dat(run).temp;
power = round(dat(run).power,2,'significant');

numavg = 1;
indices = timefind(time,linlog,numavg);
index = indices{1};

name = ['n=',NPL(2),' ',NPL(3:end-2),' ',NPL(end-1:end),'PbI_3 NPL'];

avg(40:60,:) = avg(40:60,:).*0; % cutting out 450nm red tail tripled
plotter = avg';
plot1 = plotter(1:index,:);
time1 = time(1:index);
plot2 = plotter(index+1:end,:);
time2 = time(index+1:end);
g2 = figure(2);
set(g2, 'Position',  [200, 50, 700, 550])

sgtitle([name, ' Transient Absorption, T=',num2str(temp),'K, Power=',num2str(power),'uW'])
ax1 = subplot(211);
pcolor(energy,time1,plot1)
shading('flat')
caxis(clims)
xticks(0.8:0.1:1.2);
xlabel('Energy (eV)')

ax2 = subplot(212);
pcolor(energy,time2,plot2)

shading('flat')
colormap(flipud(C))
caxis(clims)
set(ax1,'units','normalized','position',[0.08 0.15 0.81 0.3]);
set(ax2,'units','normalized','position',[0.08 0.45 0.81 0.48]);
ycutoff = linlog-0.01;
set(ax1,'ylim',[-1,ycutoff],'TickDir','out')
set(ax2,'yscale','log','ylim',[linlog time(end)],'TickDir','out');%,'yticklabel','');
set([ax1 ax2],'xlim',xlims);%,'box','off');
set(ax2,'xticklabel','')
set(ax2,'XTick',[]);
ax1.XAxis.TickLength = [0 0];
ax2.XAxis.TickLength = [0 0];
uistack(ax1,'top');

set([ax1,ax2],'xdir','reverse')
set([ax1,ax2],'FontSize',12)

c = colorbar;
c.Position = [0.91 0.18 0.02 0.64];
c.Label.String = '\Delta OD';
c.FontSize = 10;
c.TickLength = [0];

p1=get(ax1,'position');
p2=get(ax2,'position');

ax3 = axes('position',[0.055 0.5 0 0],'visible','off');
ax_label=ylabel('Time Delay (ps)','visible','on','FontSize',12);

%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Functions

function indices = timefind(time,timepoints,numavg)
% This function takes the selected time points and number of points to
% average and gives a cell array of vectors of indices in "time" to use

n = length(timepoints);
indices = cell(n,1);

% loop through all requested time points
for i = 1:n
    thistime = timepoints(i);
    ind = find(time>thistime,1);
    
    if ind==1
        disp('Warning: one or more time points given is before the first measurement.')
        indices{i} = ind;
        continue
    elseif isempty(ind)
        disp('Warning: one or more time points given is after the last measurement.')
        indices{i} = length(time);
        continue
    end
    
    % Determine closest index in "time" vector to the given time
    above = time(ind)-thistime;
    below = thistime-time(ind-1);
    if above>below
        closest = ind-1;
    else
        closest = ind;
    end
    
    % generate output vector of indices closest to the specified time, with
    % length given by numavg
    count = numavg(i);
    indices{i} = zeros(1,count);
    if mod(count,2) == 1
        b = (count-1)/2;
        indices{i} = closest-b:closest+b;
    elseif closest == ind
        b = count/2;
        indices{i} = closest-b:closest+b-1;
    else
        b = count/2;
        indices{i} = closest-b+1:closest+b;
    end
end
end

function out = getname(var)
    out = inputname(1);
end