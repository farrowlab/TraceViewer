% 2014.10.1 Ya-Chien, plot F0, F1, F2

Fampdata = dlmread('/media/NERFFS01/Data/00137/Analyzed/FFT.txt');



angle = [0 180 90 270 45 225 135 315];

FampF0_sf1 = cat(1,angle,reshape(Fampdata(1:3:70)',8,3)');
FampF1_sf1 = cat(1,angle,reshape(Fampdata(2:3:71)',8,3)');
FampF2_sf1 = cat(1,angle,reshape(Fampdata(3:3:72)',8,3)');
mFampF0_sf1 = [FampF0_sf1(1,:);mean(FampF0_sf1(2:4,:))];
mFampF1_sf1 = [FampF0_sf1(1,:);mean(FampF1_sf1(2:4,:))];
mFampF2_sf1 = [FampF0_sf1(1,:);mean(FampF2_sf1(2:4,:))];
sFampF0_sf1 = sortrows(FampF0_sf1',1)';
smFampF0_sf1 = sortrows(mFampF0_sf1',1)';
sFampF1_sf1 = sortrows(FampF1_sf1',1)';
smFampF1_sf1 = sortrows(mFampF1_sf1',1)';
sFampF2_sf1 = sortrows(FampF2_sf1',1)';
smFampF2_sf1 = sortrows(mFampF2_sf1',1)';



% ---spatial frequency 0.017---%

%----- Plot F0 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
plot(sFampF0_sf1(1,:),sFampF0_sf1(2:4,:),'color',[0.5,0.5,0.5],'linewidth',1)
hold on
plot(smFampF0_sf1(1,:),smFampF0_sf1(2,:),'color',[1,0,0],'linewidth',2)
title('{\bfDirection tuning of F0}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2,'XTick',[0:45:315],'XTickLabel',sort(angle));
xlabel('Angle (degree)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0, 315])
ylim([0, 50])
box off

%----- Plot F1 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
plot(sFampF1_sf1(1,:),sFampF1_sf1(2:4,:),'color',[0.5,0.5,0.5],'linewidth',1)
hold on
plot(smFampF1_sf1(1,:),smFampF1_sf1(2,:),'color',[1,0,0],'linewidth',2)
title('{\bfDirection tuning of F1}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2,'XTick',[0:45:315],'XTickLabel',sort(angle));
xlabel('Angle (degree)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0, 315])
ylim([0, 15])
box off


%----- Plot F2 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
plot(sFampF2_sf1(1,:),sFampF2_sf1(2:4,:),'color',[0.5,0.5,0.5],'linewidth',1)
hold on
plot(smFampF2_sf1(1,:),smFampF2_sf1(2,:),'color',[1,0,0],'linewidth',2)
title('{\bfDirection tuning of F2}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2,'XTick',[0:45:315],'XTickLabel',sort(angle));
xlabel('Angle (degree)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0, 315])
ylim([0, 10])
box off








clear all
Fampdata = dlmread('/media/NERFFS01/Data/00137/Analyzed/FFT.txt');

theta = 0:pi/4:2*pi;
angle = [0 pi pi/2 pi/2+pi pi/4 pi/4+pi 3*pi/4 3*pi/4+pi];

FampF0_sf1 = cat(1,angle,reshape(Fampdata(1:3:70)',8,3)');
FampF1_sf1 = cat(1,angle,reshape(Fampdata(2:3:71)',8,3)');
FampF2_sf1 = cat(1,angle,reshape(Fampdata(3:3:72)',8,3)');
mFampF0_sf1 = [FampF0_sf1(1,:);mean(FampF0_sf1(2:4,:))];
mFampF1_sf1 = [FampF0_sf1(1,:);mean(FampF1_sf1(2:4,:))];
mFampF2_sf1 = [FampF0_sf1(1,:);mean(FampF2_sf1(2:4,:))];
sFampF0_sf1 = sortrows(FampF0_sf1',1)';
smFampF0_sf1 = sortrows(mFampF0_sf1',1)';
sFampF1_sf1 = sortrows(FampF1_sf1',1)';
smFampF1_sf1 = sortrows(mFampF1_sf1',1)';
sFampF2_sf1 = sortrows(FampF2_sf1',1)';
smFampF2_sf1 = sortrows(mFampF2_sf1',1)';

%----- Plot F0 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
p1 = polar([sFampF0_sf1(1,:), sFampF0_sf1(1,1)],[sFampF0_sf1(2,:),sFampF0_sf1(2,1)]);hold on
p2 = polar([sFampF0_sf1(1,:), sFampF0_sf1(1,1)],[sFampF0_sf1(3,:),sFampF0_sf1(3,1)]);hold on
p3 = polar([sFampF0_sf1(1,:), sFampF0_sf1(1,1)],[sFampF0_sf1(4,:),sFampF0_sf1(4,1)]);hold on
pm = polar([smFampF0_sf1(1,:), smFampF0_sf1(1,1)],[smFampF0_sf1(2,:),smFampF0_sf1(2,1)]);
set(p1,'color',[0.7 0.7 0.7],'linewidth',1)
set(p2,'color',[0.7 0.7 0.7],'linewidth',1)
set(p3,'color',[0.7 0.7 0.7],'linewidth',1)
set(pm,'color',[0 0 1],'linewidth',4)
hline = findobj(gca, 'Type', 'line');
set(hline, 'LineWidth', 2)
htext = findall(gca, 'Type', 'text');
set(htext, 'FontSize',18)


fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
[x_f0sf1,y_f0sf1]=pol2cart(smFampF0_sf1(1,:),smFampF0_sf1(2,:));
compass(x_f0sf1,y_f0sf1)
hold on
sumx_f0sf1 = sum(x_f0sf1);
sumy_f0sf1 = sum(y_f0sf1);
compass(sumx_f0sf1,sumy_f0sf1,'r')
DSI = norm([sumx_f0sf1,sumy_f0sf1])/sum(smFampF0_sf1(2,:))


%----- Plot F1 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
p1 = polar([sFampF1_sf1(1,:), sFampF1_sf1(1,1)],[sFampF1_sf1(2,:),sFampF1_sf1(2,1)]);hold on
p2 = polar([sFampF1_sf1(1,:), sFampF1_sf1(1,1)],[sFampF1_sf1(3,:),sFampF1_sf1(3,1)]);hold on
p3 = polar([sFampF1_sf1(1,:), sFampF1_sf1(1,1)],[sFampF1_sf1(4,:),sFampF1_sf1(4,1)]);hold on
pm = polar([smFampF1_sf1(1,:), smFampF1_sf1(1,1)],[smFampF1_sf1(2,:),smFampF1_sf1(2,1)]);
set(p1,'color',[0.7 0.7 0.7],'linewidth',1)
set(p2,'color',[0.7 0.7 0.7],'linewidth',1)
set(p3,'color',[0.7 0.7 0.7],'linewidth',1)
set(pm,'color',[1 0 0],'linewidth',4)
hline = findobj(gca, 'Type', 'line');
set(hline, 'LineWidth', 2)
htext = findall(gca, 'Type', 'text');
set(htext, 'FontSize',18)


fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
[x_f1sf1,y_f1sf1]=pol2cart(smFampF1_sf1(1,:),smFampF1_sf1(2,:));
compass(x_f1sf1,y_f1sf1)
hold on
sumx_f1sf1 = sum(x_f1sf1);
sumy_f1sf1 = sum(y_f1sf1);
compass(sumx_f1sf1,sumy_f1sf1,'r')
DSI = norm([sumx_f1sf1,sumy_f1sf1])/sum(smFampF1_sf1(2,:))

%----- Plot F2 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
p1 = polar([sFampF2_sf1(1,:), sFampF2_sf1(1,1)],[sFampF2_sf1(2,:),sFampF2_sf1(2,1)]);hold on
p2 = polar([sFampF2_sf1(1,:), sFampF2_sf1(1,1)],[sFampF2_sf1(3,:),sFampF2_sf1(3,1)]);hold on
p3 = polar([sFampF2_sf1(1,:), sFampF2_sf1(1,1)],[sFampF2_sf1(4,:),sFampF2_sf1(4,1)]);hold on
pm = polar([smFampF2_sf1(1,:), smFampF2_sf1(1,1)],[smFampF2_sf1(2,:),smFampF2_sf1(2,1)]);
set(p1,'color',[0.7 0.7 0.7],'linewidth',1)
set(p2,'color',[0.7 0.7 0.7],'linewidth',1)
set(p3,'color',[0.7 0.7 0.7],'linewidth',1)
set(pm,'color',[0 0.8 0],'linewidth',4)
hline = findobj(gca, 'Type', 'line');
set(hline, 'LineWidth', 2)
htext = findall(gca, 'Type', 'text');
set(htext, 'FontSize',18)


fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
[x_f2sf1,y_f2sf1]=pol2cart(smFampF2_sf1(1,:),smFampF2_sf1(2,:));
compass(x_f2sf1,y_f2sf1)
hold on
sumx_f2sf1 = sum(x_f2sf1);
sumy_f2sf1 = sum(y_f2sf1);
compass(sumx_f2sf1,sumy_f2sf1,'r')
DSI = norm([sumx_f2sf1,sumy_f2sf1])/sum(smFampF2_sf1(2,:))


% % ----Simulation test----%
% angle = 0:pi/4:3*pi/4+pi;
% testdata = [0 0 0 0 10 10 10 10];
% fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
% figure(fh);
% [x_test,y_test]=pol2cart(angle,testdata);
% compass(x_test,y_test)
% hold on
% sumx = sum(x_test);
% sumy = sum(y_test);
% compass(sumx,sumy,'r')
% DSI = norm([sumx,sumy])/sum(testdata)







clear all

Fampdata = dlmread('/media/NERFFS01/Data/00137/Analyzed/FFT.txt');


angle = [0 180 90 270 45 225 135 315];


% ---spatial frequency 0.036---%

FampF0_sf2 = cat(1,angle,reshape(Fampdata(73:3:142)',8,3)');
FampF1_sf2 = cat(1,angle,reshape(Fampdata(74:3:143)',8,3)');
FampF2_sf2 = cat(1,angle,reshape(Fampdata(75:3:144)',8,3)');
mFampF0_sf2 = [FampF0_sf2(1,:);mean(FampF0_sf2(2:4,:))];
mFampF1_sf2 = [FampF0_sf2(1,:);mean(FampF1_sf2(2:4,:))];
mFampF2_sf2 = [FampF0_sf2(1,:);mean(FampF2_sf2(2:4,:))];
sFampF0_sf2 = sortrows(FampF0_sf2',1)';
smFampF0_sf2 = sortrows(mFampF0_sf2',1)';
sFampF1_sf2 = sortrows(FampF1_sf2',1)';
smFampF1_sf2 = sortrows(mFampF1_sf2',1)';
sFampF2_sf2 = sortrows(FampF2_sf2',1)';
smFampF2_sf2 = sortrows(mFampF2_sf2',1)';






%----- Plot F0 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
plot(sFampF0_sf2(1,:),sFampF0_sf2(2:4,:),'color',[0.5,0.5,0.5],'linewidth',1)
hold on
plot(smFampF0_sf2(1,:),smFampF0_sf2(2,:),'color',[1,0,0],'linewidth',2)
title('{\bfDirection tuning of F0}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2,'XTick',[0:45:315],'XTickLabel',sort(angle));
xlabel('Angle (degree)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0, 315])
ylim([0, 50])
box off



%----- Plot F1 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
plot(sFampF1_sf2(1,:),sFampF1_sf2(2:4,:),'color',[0.5,0.5,0.5],'linewidth',1)
hold on
plot(smFampF1_sf2(1,:),smFampF1_sf2(2,:),'color',[1,0,0],'linewidth',2)
title('{\bfDirection tuning of F1}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2,'XTick',[0:45:315],'XTickLabel',sort(angle));
xlabel('Angle (degree)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0, 315])
ylim([0, 15])
box off


%----- Plot F2 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
plot(sFampF2_sf2(1,:),sFampF2_sf2(2:4,:),'color',[0.5,0.5,0.5],'linewidth',1)
hold on
plot(smFampF2_sf2(1,:),smFampF2_sf2(2,:),'color',[1,0,0],'linewidth',2)
title('{\bfDirection tuning of F2}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2,'XTick',[0:45:315],'XTickLabel',sort(angle));
xlabel('Angle (degree)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0, 315])
ylim([0, 10])
box off








clear all
Fampdata = dlmread('/media/NERFFS01/Data/00137/Analyzed/FFT.txt');

theta = 0:pi/4:2*pi;
angle = [0 pi pi/2 pi/2+pi pi/4 pi/4+pi 3*pi/4 3*pi/4+pi];

FampF0_sf2 = cat(1,angle,reshape(Fampdata(73:3:142)',8,3)');
FampF1_sf2 = cat(1,angle,reshape(Fampdata(74:3:143)',8,3)');
FampF2_sf2 = cat(1,angle,reshape(Fampdata(75:3:144)',8,3)');
mFampF0_sf2 = [FampF0_sf2(1,:);mean(FampF0_sf2(2:4,:))];
mFampF1_sf2 = [FampF0_sf2(1,:);mean(FampF1_sf2(2:4,:))];
mFampF2_sf2 = [FampF0_sf2(1,:);mean(FampF2_sf2(2:4,:))];
sFampF0_sf2 = sortrows(FampF0_sf2',1)';
smFampF0_sf2 = sortrows(mFampF0_sf2',1)';
sFampF1_sf2 = sortrows(FampF1_sf2',1)';
smFampF1_sf2 = sortrows(mFampF1_sf2',1)';
sFampF2_sf2 = sortrows(FampF2_sf2',1)';
smFampF2_sf2 = sortrows(mFampF2_sf2',1)';

%----- Plot F0 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
p1 = polar([sFampF0_sf2(1,:), sFampF0_sf2(1,1)],[sFampF0_sf2(2,:),sFampF0_sf2(2,1)]);hold on
p2 = polar([sFampF0_sf2(1,:), sFampF0_sf2(1,1)],[sFampF0_sf2(3,:),sFampF0_sf2(3,1)]);hold on
p3 = polar([sFampF0_sf2(1,:), sFampF0_sf2(1,1)],[sFampF0_sf2(4,:),sFampF0_sf2(4,1)]);hold on
pm = polar([smFampF0_sf2(1,:), smFampF0_sf2(1,1)],[smFampF0_sf2(2,:),smFampF0_sf2(2,1)]);
set(p1,'color',[0.7 0.7 0.7],'linewidth',1)
set(p2,'color',[0.7 0.7 0.7],'linewidth',1)
set(p3,'color',[0.7 0.7 0.7],'linewidth',1)
set(pm,'color',[0 0 1],'linewidth',4)
hline = findobj(gca, 'Type', 'line');
set(hline, 'LineWidth', 2)
htext = findall(gca, 'Type', 'text');
set(htext, 'FontSize',18)


fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
[x_f0sf2,y_f0sf2]=pol2cart(smFampF0_sf2(1,:),smFampF0_sf2(2,:));
compass(x_f0sf2,y_f0sf2)
hold on
sumx_f0sf2 = sum(x_f0sf2);
sumy_f0sf2 = sum(y_f0sf2);
compass(sumx_f0sf2,sumy_f0sf2,'r')
DSI = norm([sumx_f0sf2,sumy_f0sf2])/sum(smFampF0_sf2(2,:))


%----- Plot F1 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
p1 = polar([sFampF1_sf2(1,:), sFampF1_sf2(1,1)],[sFampF1_sf2(2,:),sFampF1_sf2(2,1)]);hold on
p2 = polar([sFampF1_sf2(1,:), sFampF1_sf2(1,1)],[sFampF1_sf2(3,:),sFampF1_sf2(3,1)]);hold on
p3 = polar([sFampF1_sf2(1,:), sFampF1_sf2(1,1)],[sFampF1_sf2(4,:),sFampF1_sf2(4,1)]);hold on
pm = polar([smFampF1_sf2(1,:), smFampF1_sf2(1,1)],[smFampF1_sf2(2,:),smFampF1_sf2(2,1)]);
set(p1,'color',[0.7 0.7 0.7],'linewidth',1)
set(p2,'color',[0.7 0.7 0.7],'linewidth',1)
set(p3,'color',[0.7 0.7 0.7],'linewidth',1)
set(pm,'color',[1 0 0],'linewidth',4)
hline = findobj(gca, 'Type', 'line');
set(hline, 'LineWidth', 2)
htext = findall(gca, 'Type', 'text');
set(htext, 'FontSize',18)

fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
[x_f1sf2,y_f1sf2]=pol2cart(smFampF1_sf2(1,:),smFampF1_sf2(2,:));
compass(x_f1sf2,y_f1sf2)
hold on
sumx_f1sf2 = sum(x_f1sf2);
sumy_f1sf2 = sum(y_f1sf2);
compass(sumx_f1sf2,sumy_f1sf2,'r')
DSI = norm([sumx_f1sf2,sumy_f1sf2])/sum(smFampF1_sf2(2,:))

%----- Plot F2 -----%
fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
p1 = polar([sFampF2_sf2(1,:), sFampF2_sf2(1,1)],[sFampF2_sf2(2,:),sFampF2_sf2(2,1)]);hold on
p2 = polar([sFampF2_sf2(1,:), sFampF2_sf2(1,1)],[sFampF2_sf2(3,:),sFampF2_sf2(3,1)]);hold on
p3 = polar([sFampF2_sf2(1,:), sFampF2_sf2(1,1)],[sFampF2_sf2(4,:),sFampF2_sf2(4,1)]);hold on
pm = polar([smFampF2_sf2(1,:), smFampF2_sf2(1,1)],[smFampF2_sf2(2,:),smFampF2_sf2(2,1)]);
set(p1,'color',[0.7 0.7 0.7],'linewidth',1)
set(p2,'color',[0.7 0.7 0.7],'linewidth',1)
set(p3,'color',[0.7 0.7 0.7],'linewidth',1)
set(pm,'color',[0 0.8 0],'linewidth',4)
hline = findobj(gca, 'Type', 'line');
set(hline, 'LineWidth', 2)
htext = findall(gca, 'Type', 'text');
set(htext, 'FontSize',18)


fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
[x_f2sf2,y_f2sf2]=pol2cart(smFampF2_sf2(1,:),smFampF2_sf2(2,:));
compass(x_f2sf2,y_f2sf2)
hold on
sumx_f2sf2 = sum(x_f2sf2);
sumy_f2sf2 = sum(y_f2sf2);
compass(sumx_f2sf2,sumy_f2sf2,'r')
DSI = norm([sumx_f2sf2,sumy_f2sf2])/sum(smFampF2_sf2(2,:))


% % ----Simulation test----%
% angle = 0:pi/4:3*pi/4+pi;
% testdata = [0 0 0 0 10 10 10 10];
% fh = figure('Position',[100 100 500 300],'Color','w'); % ----- Define Figure -----%
% figure(fh);
% [x_test,y_test]=pol2cart(angle,testdata);
% compass(x_test,y_test)
% hold on
% sumx = sum(x_test);
% sumy = sum(y_test);
% compass(sumx,sumy,'r')
% DSI = norm([sumx,sumy])/sum(testdata)

