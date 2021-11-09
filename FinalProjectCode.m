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

filename = dicominfo(input('What filename would you like to scan? '));
[X, map] = dicomread('56364397.dcm');
montage(X, map, 'Size', [2 5]);
info = dicomread(filename); 


