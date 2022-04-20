close all, clc

%% Read the sound file, and convert from stereo to mono
[x, Fs] = audioread('greensleeves.wav');
x = mean(x, 2);

% LPF and downsample
x = filter(fir1(100,1/5), 1, x);
x = downsample(x, 5);
Fs = Fs/5;
T = 1/Fs;

%% Note Selection
% note_times has the starting time (in sec) of the first 10 notes
note_times = [0.86, 1.42, 2.6, 3.16, 4.0, 4.26, 4.78, 5.9, 6.47, 7.3];
% convert note_times to the sample index
note_times = round(note_times/T);

% select the Nth note in the song
n = 1; 

y = x(note_times(n) : note_times(n+1) - 1);
N = size(y, 1);

%% Plot signal
% figure, hold on
% plot((0:N-1), y);
% %scatter((0:N-1), y, 10);
% xlabel('Samples');
% ylabel('Amplitude');
% grid

%% Plot signal in time
figure, hold on
plot((0:N-1)*T, y);
xlabel('Time [s]');
ylabel('Amplitude');
grid

%% Fourier Spectrum in rad
Y = 2 * fft(y) / N;
df = 2*pi/N; %Spectral resolution
% Plot frequencies from 0 to 0.3 rad
L = round(pi/df);
Y = Y(1:L) / max(Y);

figure, plot((0:L-1)*df, (abs(Y)));
xlabel('Frequency [rad]');
ylabel('Normalized Amplitude');
grid

%% Fourier Spectrum in Hz
df = Fs/N; %Spectral resolution
Y = 2 * fft(y) / N;

% Plot frequencies from 0 to 4 kHz
L = round(4000/df);
Y = Y(1:L) / max(Y);

figure, plot((0:L-1)*df, (abs(Y)));
xlabel('Frequency [Hz]');
ylabel('Normalized Amplitude');
grid

%% Auto-correlation
[acf, lags] = autocorr(y, 200);
figure, plot(lags, acf);
xlabel('Samples');
ylabel('Amplitude');
grid


%% Spectrogram
figure
window = 2^12;
spectrogram(y, hann(window), 3*window/4, 4*window, Fs, 'yaxis');




