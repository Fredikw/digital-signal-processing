clc, close all

%% Read the sound file, and convert from stereo to mono
[x, Fs] = audioread('greensleeves.wav');
x = mean(x, 2);

% LPF and downsample
x = filter(fir1(100,1/5), 1, x);
x = downsample(x, 5);
Fs = Fs/5; dt = 1/Fs;

%% Location of the notes
locs = locations(x, Fs);
N = size(locs, 1); %Number of notes in the song

%% Estimate the frequency for each note (between 2 consecutive locs)
freqs = zeros(N, 1);

%TODO: Last note missing
for i = 1:N-1
    % Limits of each note
    a = locs(i);
    b = locs(i+1);
    
    %Frequency of each note
    y = x(a:b);
    freqs(i) = frequency(y, Fs);
end




