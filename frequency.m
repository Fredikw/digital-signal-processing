
% Calculates the fundamental frequency of the signal x

function f = frequency(x, Fs)

    min_f = 40;
    max_lag = round(Fs/min_f);
    
    % Auto correlation
    [acf, lags] = autocorr(x, max_lag-1);

	% Compensation for the decaing of the auto-correlation 
    % (caused by the decrease of the overlapping regions)
    N = size(x,1);
    comp = linspace(N, 1, N)' / N;
    acf = acf./comp(1:max_lag);
    
    % Removes local maxima below some threshold
    thresh = 0.5;
    acf(acf < thresh) = 0;

% Plot    
%     figure, plot(lags, acf);
%     xlabel('Samples');
%     ylabel('Amplitude');
%     grid
    
    [~,locs] = findpeaks(acf);
    Npeaks = size(locs, 1);
 
    % L is the distance, measured in samples, between the first peak
    % (at position 0) and the last peak.
    L = (locs(end)-1)/Npeaks;
    f = Fs/L;
    
end