clear all;
close all;

%Put all files in one folder
%Copy and change the following for each of your scans

T4_SMA = zeros(3,1);
T4_MHU = zeros(3,1);
T12_SMA = zeros(2,1);
T12_MHU = zeros(2,1);

n = 0;

%Case 101

CaseID = 101;
n = n + 1;
[SMA, MHU] = sarccalc('101.nii', '101_seg_t4.nii.gz', 4);
T4_SMA (1, n) = CaseID;
T4_SMA (2:3, n) = SMA;
T4_MHU (1, n) = CaseID;
T4_MHU (2:3, n) = MHU;

[SMA, MHU] = sarccalc('101.nii.gz', '101_seg_t12.nii.gz', 12);
T12_SMA (1,n) = CaseID;
T12_SMA (2,n) = SMA;
T12_MHU (1,n) = CaseID;
T12_MHU (2,n) = MHU;

%Case 7071

CaseID = 7071;
n = n + 1;
[SMA, MHU] = sarccalc('7071.nii.gz', '7071_seg_t4.nii.gz', 4);
T4_SMA (1, n) = CaseID;
T4_SMA (2:3, n) = SMA;
T4_MHU (1, n) = CaseID;
T4_MHU (2:3, n) = MHU;

[SMA, MHU] = sarccalc('7071.nii.gz', '7071_seg_t12.nii.gz', 12);
T12_SMA (1,n) = CaseID;
T12_SMA (2,n) = SMA;
T12_MHU (1,n) = CaseID;
T12_MHU (2,n) = MHU;

%Continue adding others%%%%%%
%.....%

%%%%%%%%%%%%%%%%%%
%Output as spreadsheets

filename = 'SMA_T4.xlsx';
T = table(T4_SMA);
T.Properties.RowNames = {'ID','Pec Major','Pec Minor'}
writetable(T,filename,'Sheet',1,'WriteRowNames',true)

filename = 'SMA_T12.xlsx';
T = table(T12_SMA);
T.Properties.RowNames = {'ID','Muscle'}
writetable(T,filename,'Sheet',1,'WriteRowNames',true)

filename = 'MHU_T4.xlsx';
T = table(T4_MHU);
T.Properties.RowNames = {'ID','Pec Major','Pec Minor'}
writetable(T,filename,'Sheet',1,'WriteRowNames',true)

filename = 'MHU_T12.xlsx';
T = table(T12_MHU);
T.Properties.RowNames = {'ID','Muscle'}
writetable(T,filename,'Sheet',1,'WriteRowNames',true)

