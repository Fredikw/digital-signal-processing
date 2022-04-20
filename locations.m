
% Not organized

function locs = locations(x, Fs)

    scale = Fs / 8820;

    L = 400*scale;
    
    [rms, ~] = envelope(x, L, 'rms');
    
    rms = movmean(rms, 300);
    
    N = size(x, 1);
    dt = 1/Fs;

    dt = 1;
    
    if dt == 1 str = 'Samples'; else str = 'Time [s]'; end   
    
    figure, plot((0:N-1)*dt, x);
    grid; hold on;  xlabel(str);
    
    plot((0:N-1)*dt, rms);
    du = 1e3 * diff(rms);
    du = movmean(du, 300);

    figure, plot((0:N-1)*dt, x);
    grid; hold on; xlabel(str);
%     
    min_dist = round(0.1*Fs); % scale, 0.1s
    min_peak = 0.05;
    
    [~,locs] = findpeaks(du, 'minpeakdistance', min_dist, 'MinPeakProminence', min_peak);

    p = du(locs);
    scatter(locs-1, p);      
    plot((0:N-2)*dt, du);

end