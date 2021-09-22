function y = voiceprint ( clip , fs ) 
%% 2
[m,n] = size(clip);
if (n == 1)
    clip2 = clip;
else
    clip2 = mean( clip, 2);
end  
clip2_mean = mean( clip2);
clip2 = clip2 - clip2_mean;
clip2 = resample( clip2, 8000, fs);
%% 3
l = 512;
[S, F, T] = spectrogram( clip2 , l, l/2 , l , 8000 );
% figure(1);
% imagesc(log10(abs(S)));
% colormap(1 - gray );
% title('Spectrogram');
% xlabel('Time');
% ylabel('Frequency');
%% 4
CS = circshift( S, [-1,-1]);
P1 = ((S-CS)>0);
CS = circshift( S, [0,-1]);
P2 = ((S-CS)>0);
CS = circshift( S, [1,-1]);
P3 = ((S-CS)>0);
CS = circshift( S, [-1,0]);
P4 = ((S-CS)>0);
CS = circshift( S, [1,0]);
P5 = ((S-CS)>0);
CS = circshift( S, [-1,1]);
P6 = ((S-CS)>0);
CS = circshift( S, [0,1]);
P7 = ((S-CS)>0);
CS = circshift( S, [1,1]);
P8 = ((S-CS)>0);
peaks = P1 & P2 & P3 & P4 & P5 & P6 & P7 & P8;
% figure
% imagesc(peaks);
% colormap(1 - gray );
% title('Spectrogam of All Peaks');
% xlabel('Time');
% ylabel('Frequency');
[p,q] = size(peaks);
counter = 0;
Li = round(T(end)*30,0);
for i=1:p
    for j=1:q
        if (peaks(i,j) == 1)   
            counter = counter+1;
            indicator(counter,1) = i;
            indicator(counter,2) = j;
            indicator(counter,3) = S(indicator(counter,1),indicator(counter,2));
        end
    end    
end
indicator = sortrows(indicator,-3);
y = peaks;
for i=Li+1:counter
     y(indicator(i,1),indicator(i,2)) = 0;
end  
% figure
% imagesc(y);
% colormap(1 - gray );
% title('Spectrogam of Limited Peaks');
% xlabel('Time');
% ylabel('Frequency');