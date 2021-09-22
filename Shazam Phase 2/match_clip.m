function song_name = match_clip(address,clip_name,HashTable,Main_directory,SONGID_list)
A = [];
cd(address);
[clip, fs_clip] = audioread(clip_name);
snr = input('Enter SNR\n');
clip = awgn(clip,snr);
cd(Main_directory);
pairs_clip = peak_to_pair(voiceprintali(clip,fs_clip));
for i = 1 : length(pairs_clip) 
      index_clip = Hindex(pairs_clip(i,3),pairs_clip(i,4),pairs_clip(i,2)-pairs_clip(i,1)); 
      A = [A, HashTable(index_clip).Song_ID];
end 
maximum = 0;
if (sum(A(:)) == 0) 
    song_name = 'No Result'; end
for j = 1 : length(SONGID_list)
    checker = sum(A(:) == j);
    if (checker > maximum) 
        song_name = SONGID_list(j); end
    if (checker > maximum)
        maximum = sum(A(:)==j); end
end