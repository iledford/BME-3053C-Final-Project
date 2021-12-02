%%%****FINAL PROJECT CODE****%%%

% BROWSE FOR THE FOLDER AND ADD IT TO THE CURRENT FOLDER
%The name of the folder for the DICOM FILE IS '\\Client\D$\BME3053C\Milestone Project\Subjects_COVID\Subject 1\Subject (1)\Subject (1)\98.12.2'
%(the last folder name was my specific example)

% WE HAVE THESE FUNCTIONS TO USE THE DICOM FILE
% X = dicomread(filename)
% X = dicomread(info)
% X = dicomread(___,'frames',f)
% X = dicomread(___,Name,Value)
% [X,cmap] = dicomread(___)
% [X,cmap,alpha] = dicomread(___)
% [X,cmap,alpha,overlays] = dicomread(___)

% The .dcm file that needs to be uploaded (just to test) is '56364397.dcm'

% Go to this site for more assistance 'https://www.mathworks.com/help/images/ref/dicomread.html';

%% Clear Command Window, Clear Workspace
clear; clc

%% Establish Folder Pathway for Subject

pathway = input('What is the pathway to the dicom image folder? ','s');
fprintf('Pathway has been established...\n')
pause(1)

fprintf('Enter a term (Subject1, Subject2, etc.) that you want associated with output files.\nDo NOT leave a space between the word subject and the corresponding number...\n')
%Must have 'Subject' and the number together because the .txt file cannot be written with a space 
OutputFileName = input('What subject does the CT scan correspond to (for our study)? ','s'); %replace this with the subject number you want to see in the output files

clc; 
fprintf('Subject Number: %s\n',OutputFileName(8:end))
fprintf('Pathway: %s \n', pathway)
addpath(pathway); pause(0.3)
fprintf('Pathway has been added!\n')

%% Create pathways and variables for length and prevalence matrix
folderpathway = dir(pathway); %put in folder name
folderpathway = folderpathway(3:end);
lengthFolder = length(folderpathway);
PrevalenceMatrix = [];

fprintf('Length of the input folder has been determined...\n')
pause(0.5)

%% Scan each of the .dcm images in the folder to determine prevalence of white pixels
fprintf('Scanning each .dcm/file in the input folder...\n')

for i = 1:1:lengthFolder
    file = folderpathway(i).name;
    prevalence = 0;
    PrevalencePercent = 0;
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
    PrevalencePercent = prevalence/(512^2);
    PrevalenceMatrix(i,:) = PrevalencePercent;
end 

fprintf('The Prevalence Matrix has been compiled.\n\n')
pause(0.5)

%% Find Statistical Differences in Data (from PrevalenceMatrix)

meanPrevalence = mean(PrevalenceMatrix); %mean of the prevalence
Sdev = std(PrevalenceMatrix); %stan. deviation of the prevalence

% add more measures of the data here 
varPrevalence = var(PrevalenceMatrix); %variance of the prevalence 

fprintf('For prevalence, the mean, standard deviation, and variance has been computed for the entire dataset for this subject.\n\n')

%% Set up output variables and prepare the table
txtOutputFilename = append(OutputFileName,'.txt');
datOutputFilename = append(OutputFileName,'.dat');
results = [meanPrevalence; Sdev; varPrevalence];
Titles = {'Mean';'Standard Deviation';'Variance'};

% Displaying each of the values in the command window. User feedback!
pause(1)
[PrintedTitles, WholePercentResults] = convertCharsToStrings(Titles',(results*100)');
format = "The %s is %f percent prevalence across the entire CT scan...  \n";
for m = 1:1:3
    pause(0.30)
    fprintf(format,PrintedTitles(m), WholePercentResults(m))
end

%Preparing the table and cell array for 
C = {'Mean', meanPrevalence; 'Standard Dev.', Sdev; 'Variance', varPrevalence};
T = table(Titles, results);

fprintf('\nThe table and cell array are complete.\n\n')
pause(0.5)
fprintf('Preparing to export...\n')

%% Sending Results to a Folder (SubjectResults_COVID) in Files

% Display a new current folder in flash drive
% path('\\client\d$\BME3053C\Milestone Project\SubjectResults_COVID');
% Create output files in current folder
writecell(C, datOutputFilename)
writetable(T, txtOutputFilename)

pause(1)
fprintf('The .dat and .txt files have been exported!\n')
pause(0.5)
fprintf('CT scan analysis is complete.\n')