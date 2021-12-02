%%%****FINAL PROJECT CODE****%%%

%BROWSE FOR THE FOLDER AND ADD IT TO THE CURRENT FOLDER
%The name of the folder for the DICOM FILE IS '\\Client\D$\BME3053C\Milestone Project\Subjects_COVID\Subject 1\Subject (1)\Subject (1)\98.12.2'
%(the last folder name was my specific example)

%WE HAVE THESE FUNCTIONS TO USE THE DICOM FILE
% X = dicomread(filename)
% X = dicomread(info)
% X = dicomread(___,'frames',f)
% X = dicomread(___,Name,Value)
% [X,cmap] = dicomread(___)
% [X,cmap,alpha] = dicomread(___)
% [X,cmap,alpha,overlays] = dicomread(___)

%The .dcm file that needs to be uploaded (just to test) is '56364397.dcm'

% Go to this site for more assistance 'https://www.mathworks.com/help/images/ref/dicomread.html';

%% Clear Command Window, Clear Workspace
clc; clear;

%% Establish Folder Pathway for Subject

pathway = input('What is the pathway to the dicom image folder? ','s');
fprintf('Pathway has been established...\n')
pause(1)

fprintf('Enter a term (Subject1, Subject2, etc.) that you want associated with output files. Do NOT leave a space between the word subject and the corresponding number...\n')
OutputFileName = input('What subject does the CT scan correspond to (for our study)? ','s'); %replace this with the subject number you want to see in the output files

addpath(pathway)
fprintf('\nPathway has been added!\n')

%% Create pathways and variables for length and prevalence matrix
folderpathway = dir(pathway); %put in folder name
folderpathway = folderpathway(3:end);
lengthFolder = length(folderpathway);
PrevalenceMatrix = [];

fprintf('Length of the input folder has been determined...\n')
pause(0.5)

%% Scan each of the .dcm images in the folder to determine prevalence of white pixels
fprintf('Scanning each .dcm/file in the input folder...\n')
prevalence = 0;
for i = 1:1:lengthFolder
    file = folderpathway(i).name;
    if file(1) == 'S'
        fprintf("You already have a subject's output files in a folder. Check to make sure which one is correct!\n")
        clc; pause(3)
        break
    end 
    info = file;
    image = dicomread(info);
    newimage = image;
    for j = 1:1:512
        for k = 1:1:512
            if image(j,k) == 255
                newimage(j,k) = 1;
                prevalence = prevalence + 1;
            end 
        end 
    end 
    PrevalencePercent = prevalence/(516^2);
    PrevalenceMatrix(i,:) = PrevalencePercent;
end 

fprintf('The Prevalence Matrix has been compiled.\n')
pause(0.5)

%% Find Statistical Differences in Data (from PrevalenceMatrix)

meanPrevalence = mean(PrevalenceMatrix); %mean of the prevalence
Sdev = std(PrevalenceMatrix); %stan. deviation of the prevalence

%add more measures of the data here 
varPrevalence = var(PrevalenceMatrix); %variance of the prevalence 

fprintf('The mean, standard deviation, and variance has been computed for the entire dataset for this subject.\n')

%% Set up output variables and prepare the table
txtOutputFilename = append(OutputFileName,'.txt');
datOutputFilename = append(OutputFileName,'.dat');
results = [meanPrevalence; Sdev; varPrevalence];
Titles = {'Mean';'Standard Deviation';'Variance'};

C = {'Mean', meanPrevalence; 'Standard Dev.', Sdev; 'Variance', varPrevalence};
T = table(Titles, results);

fprintf('The table and cell array are complete. ')
pause(0.5)
fprintf('Preparing to export...\n')

%% Sending Results to a Folder (SubjectResults_COVID) in Files

% Display a new current folder in flash drive
% path('\\client\d$\BME3053C\Milestone Project\SubjectResults_COVID');
% Create output files in current folder
writecell(C, datOutputFilename)
writetable(T, txtOutputFilename)

fprintf('The .dat and .txt files have been exported!\n')
pause(0.5)
fprintf('CT scan analysis is complete.')


