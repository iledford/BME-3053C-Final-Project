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

pathway = '\\client\d$\BME3053C\Milestone Project\Subjects_COVID\Subject 1\Subject (1)\Subject (1)\98.12.2';
OutputFileName = 'Subject1'; %replace this with the subject number you want to see in the output files

%% Create pathways and variables for length and prevalence matrix
folderpathway = dir(pathway); %put in folder name
folderpathway = folderpathway(3:end);
lengthFolder = length(folderpathway);
PrevalenceMatrix = [];

%% Scan each of the .dcm images in the folder to determine prevalence of white pixels
for i = 1:1:lengthFolder
    file = folderpathway(i).name;
    info = file;
    image = dicomread(info);
    newimage = image;
    prevalence = 0;
    for j = 1:1:length(image)
        for k = 1:1:length(image)
            if image(j,k) == 255
                newimage(j,k) = 1;
                prevalence = prevalence + 1;
            end 
        end 
    end 
    PrevalencePercent = prevalence/(516^2);
    PrevalenceMatrix(i,:) = PrevalencePercent;
end 

%% Find Statistical Differences in Data (from PrevalenceMatrix)

meanPrevalence = mean(PrevalenceMatrix); %mean of the prevalence
Sdev = std(PrevalenceMatrix); %stan. deviation of the prevalence

%add more measures of the data here 
varPrevalence = var(PrevalenceMatrix); %variance of the prevalence 

%% Set up output variables and prepare the table
txtOutputFilename = append(OutputFileName,'.txt');
datOutputFilename = append(OutputFileName,'.dat');
results = [meanPrevalence; Sdev; varPrevalence];
Titles = {'Mean';'Standard Deviation';'Variance'};

C = {'Mean', meanPrevalence; 'Standard Dev.', Sdev; 'Variance', varPrevalence};
T = table(Titles, results);

%% Sending Results to a Folder (SubjectResults_COVID) in Files

% Display a new current folder in flash drive
% path('\\client\d$\BME3053C\Milestone Project\SubjectResults_COVID');
% Create output files in current folder
writecell(C, datOutputFilename)
writetable(T, txtOutputFilename)
