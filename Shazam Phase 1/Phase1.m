%%
clc;
clear all;
close all;
%% 
[ clip, fs] = audioread ('viva.mp3') ;
peaks = voiceprint ( clip , fs ) ;
pairs = peak_to_pair(peaks);