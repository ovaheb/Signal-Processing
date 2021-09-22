%%
close all;
clc;
clear;
%% Directories:
Train_directory = 'C:\Users\omid\Desktop\Signal Project\SS_Project_Phase2\Train';
Main_directory  = 'C:\Users\omid\Desktop\Signal Project\SS_Project_Phase2';
%% Hashtable definition
HashTable_row = 2^21; % we have 3 values and each take 7 bits to store so total number is (2^7)^3
HashTable = struct('Song_ID',{[]}, 't1', {[]});
HashTable(HashTable_row).t1 = 0;
%%
SONGID_list = SONGID_DB(Train_directory);
Music_database = get_mp3_list(Train_directory);
for i = 1 : length(Music_database)  
   cd(Train_directory);
   [data, fs] = audioread(Music_database{i}); 
   cd(Main_directory);
   peaks = voiceprintali(data,fs);
   pairs = peak_to_pair(peaks);
   HashTable = HASHTABLE(HashTable,pairs,i);
end
%%
Clip_address = 'C:\Users\omid\Desktop\Signal Project\SS_Project_Phase2\Clips'; %input('Enter the directory of clip you want to find its source:\n','s')  
while(1)
    Clip_name = input('Enter the name of clip you want to find its source:\n','s');  
    result = match_clip(Clip_address,Clip_name,HashTable,Main_directory,SONGID_list);
    disp('The song you are looking for is ');
    disp(result);
end
%%
% without any noise 1 error
% with snr = -15 3 error
% with snr = -12 2 error
% with snr = -9 3 error
% with snr = -6 0 error
% with snr = -3 2 error
% with snr = 0 1 error
% with snr = 3 1 error
% with snr = 6 1 error
% with snr = 9 0 error       
% with snr = 12 1 error    
% with snr = 15 1 error