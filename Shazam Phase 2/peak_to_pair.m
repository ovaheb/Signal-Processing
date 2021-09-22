function pairs = peak_to_pair(peaks)
    deltaT = 32; % Time interval after the peak. (in pixels)
    deltaF = 10; % Distance from the frequency of the peak. (in pixels)
    plotLines = false;
    timeLowerBound = 0;
    fanout = 3;
    timeUpperBound = timeLowerBound + deltaT;
    for i = 257 : size(peaks, 1)
        peaks(i, :) = [];
    end
    [f, t] = find(peaks);
    numOfPeaks = length(f);
    outputTuple = [];
    % wb = waitbar(0,'1','Name','Number of Peaks');
    for p = 1 : numOfPeaks
        % waitbar(p/numOfPeaks,wb,sprintf('%d : %d',p, numOfPeaks))
        currentPeakF = f(p);
        currentPeakT = t(p);
        peakPairPosition = (t ~= t(p)) & ...
                           (f > currentPeakF - deltaF) & ...
                           (f < currentPeakF + deltaF) & ...
                           (t > currentPeakT + timeLowerBound) & ...
                           (t < currentPeakT + timeUpperBound);
        peakPairPosition = find(peakPairPosition, fanout);
        tuple = cat(2, repmat(t(p), size(peakPairPosition)), t(peakPairPosition), ...
                       repmat(f(p) - 1, size(peakPairPosition)), f(peakPairPosition) - 1);
        outputTuple = cat(1, outputTuple, tuple);
    end
    % close(wb);
    pairs = outputTuple;
    if plotLines
        figure
        imagesc(peaks)
        colormap(1 - gray)
        hold on
        for i = 1 : size(pairs, 1)
            line(pairs(i, 1:2), pairs(i, 3:4))
        end
        title('Spectrogram local peaks and peak pairs')
        xlabel('Time')
        ylabel('Frequency')
    end
end