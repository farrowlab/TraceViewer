clear all
folder = '/media/NERFFS01/Data/00137/Raw/20140908/YC0001/';

% cd(folder)

VNAME = '700B-1';
SYNCNAME = 'VisSync';

files = dir('*.xsg');
files = {files.name}';

% Load all the data in this folder
counter = 0;
fprintf(1,'Going to load %d files. \n',length(files))
for ii = 1:40
    [ent,prot] = loadEphusData(files{ii});
    fprintf(1,'#')
    if ~isempty(prot)
        counter = counter + 1;
        vdata(counter) = ent(strcmp({ent.name},VNAME));
        syncInd{counter} = findSyncIndexes(ent(strcmp({ent.name},SYNCNAME)).data);
        prots(counter) = prot;
    end
    if ~mod(ii,10)
        fprintf(1,'\n')
    end
end
fprintf(1,'Done\n')

%% Fourier analysis

NFFT=2^nextpow2(length(time));
freq=(srate/2)*linspace(0,1,NFFT/2+1); % Linearly spaced frequency vector scaled by the Nyquist limit
dout =fft(signal,NFFT)/length(time);

%Plot single-sided amplitude spectrum
fh = figure('Position',[100 100 1000 300],'Color','w'); % ----- Define Figure -----%
figure(fh);
Amp = 2*abs(dout(1:NFFT/2+1));
plot(freq, Amp)
title('{\bfAmplitude Spectrum}','FontSize',18)
set(gca,'FontSize',18,'LineWidth',2); axis tight;
xlabel('Frequency (Hz)','FontSize',18)
ylabel('Amplitude','FontSize',18)
xlim([0 20]);


%%

orientations = [0,180,90,270,45,225,135,315];
repetitions = 1:3;
data_dimention = 1; 

for r = 1:length(repetitions)
    for o = 1:length(orientations)
        % Clear the tmp structure variable
        tmp = struct();
        % generate 3 random points 
        % This is F0, F1 and F2
        F0 = rand(1);
        F1 = rand(1);
        F2 = rand(1);
        % now create a data structure
        tmp.F0 = F0;
        tmp.F1 = F1;
        tmp.F2 = F2;
        tmp.orientation = orientations(o);
        tmp.trial = repetitions(r);
        % now save the data (this is done when you analize)
        fname = sprintf('processed_data_%d_%03d.mat',orientations(o),repetitions(r));
        save(fname,'-struct','tmp')
    end
end