# BME-3053C-Final-Project
## Authors: Joshua Fernandez, Hannah Higginson, Irene Ledford, John Prieschl
Since March of 2020, COVID-19 has completely changed our lives and the way we live. It is a dangerously infectious disease that can affect the body forever. Although COVID-19 tests exist, a program would be useful to decide between healthy and infected lungs, as it would provide additional information on the patients’ health and severity of infection.The motivation behind this project stems from the current state of the pandemic and providing a more accurate way to detect if a person is infected with COVID-19. With this program, it will be able to analyze the CT scan of the lungs to determine if a person is not infected or is infected with COVID-19. This program will not be able to detect other diseases of the lungs or provide any information regarding the patient’s health history. The result will be a statement confirming or denying if the patient is infected with COVID-19.



This project will be able to detect COVID-19 in the lungs of a patient through a CT scan of the lungs using a created MATLAB program. Lungs will appear opaque on a CT image, for which we will create a program to detect how opaque the lungs are and if it reaches a certain degree, it can be classified as infected with COVID-19. The aims of this project are to create a MATLAB program that can successfully analyze a lung CT scan as well as compare healthy lungs to lungs infected with COVID-19.



Intructions: Ask for the direct folder pathway to the dicom image being analyzed. Make sure to copy and paste exact pathway being used when asked. If needed, use command **addpath('your pathway')** to establish the pathway prior to running the program. When asked to give a term (Subject1, Subject2, etc.) that you want to be associated with the output files, do not leave a space between the word subject and the corresponding number. Once the program has finished analyzing the dicom image make sure to use the command              **save Subject(whatever number you are on) PrevalenceMatrix** to allow for comparison with other images later on. 
