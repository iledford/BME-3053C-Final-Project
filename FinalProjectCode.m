%%%****FINAL PROJECT CODE****%%%

%Clear the workspace and the command window

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

clc; clear;

folderpathway = dir('\\client\d$\BME3053C\Milestone Project\Subjects_COVID\Subject 1\Subject (1)\Subject (1)\98.12.2'); %put in folder name
folderpathway = folderpathway(3:end);
lengthFolder = length(folderpathway);
PrevalanceMatrix = [];

for i = 1:1:lengthFolder
    file = folderpathway(i).name;
    image = dicomload(file);
    newimage = image;
    prevalance = 0;
    for j = 1:1:length(image)
        for k = 1:1:length(image)
            if image(j,k) == 255
                newimage(j,k) = 1;
                prevalance = prevalence + 1;
            end 
        end 
    end 
    PrevalencePercent = prevalance/(516^2);
    PrevalanceMatrix(i,:) = PrevalencePercent;
end 

    
    
    

