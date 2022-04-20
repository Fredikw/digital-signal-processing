clc, close all

%% Read the sound file, and convert from stereo to mono
[x, Fs] = audioread('greensleeves.wav');
x = mean(x, 2);

% LPF and downsample
x = filter(fir1(100,1/5), 1, x);
x = downsample(x, 5);
Fs = Fs/5;
T = 1/Fs;

%% Note Selection
% locs has the starting time (in sec) of the first 10 notes
locs = [0.8, 1.4, 2.6, 3.1, 4.0, 4.2, 4.8, 5.9, 6.5, 7.4];
% convert from seconds to samples
locs = round(locs*Fs);

% select the Nth note in the song
n = 2; 
y = x(locs(n) : locs(n+1) - 1);
N = size(y, 1);

%% Calculate frequency and its corresponding note
f = frequency(y, Fs)
note = 12 * log2(f/440)
%TODO note name



