function [peaks] = voiceprint(clip ,fs) 
clip = sum(clip, 2) / size(clip, 2);
clipDC = mean(clip) ;
clip = clip - clipDC;

new_sample_rate = 8000 ;
clip = resample( clip , new_sample_rate , fs ) ;

fs = 8000 ;
window = 0.064*fs ;
noverlap = 0.032*fs ;
nfft = window;
[S, F, T] = spectrogram( clip , window, noverlap , nfft , fs ) ;

%imagesc(log10(abs(S)))
%colorbar
%xlabel('time')
%ylabel('freq')
%title('spec log(s)')

S = log10(abs(S));
peaks = zeros(size(S));

CS1 = circshift(S ,[0 ,-1]) ;
CS2 = circshift(S ,[0 , 1]) ;
CS3 = circshift(S ,[-1 , 0]) ;
CS4 = circshift(S ,[1 , 0]) ; 
CS5 = circshift(S ,[-1 ,-1]) ;
CS6 = circshift(S ,[1 ,-1]) ;
CS7 = circshift(S ,[-1 , 1]) ;
CS8 = circshift(S ,[1 , 1]) ;
peaks = ((S - CS1) > 0 & (S - CS2) > 0 & (S - CS3) > 0 & (S - CS4) > 0 & ...
     (S - CS5) > 0 & (S - CS6) > 0 & (S - CS7) > 0 & (S - CS8) > 0 );
%figure
 %colormap (1-gray) ; 
 %imagesc(peaks) 
%title('all of peaks')

peaks_with_magnitude = ( S(peaks));
limit = maxk2(peaks_with_magnitude,ceil(T(end)*30)) ;
peaks = S.*peaks > limit(end) ;

end