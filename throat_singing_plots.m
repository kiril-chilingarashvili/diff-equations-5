clear all
[YY,Fs] = audioread("1803_musicdata_voice_2pitches.wav");
YY = YY(:,1);
LL = length(YY);
k=1;
for j=[.025:.025:1];

% Extract points from 30-40% time period of the file
y = YY(1+round(LL*(j-.025)):round(LL*j));
% New length of the file
L = length(y);

% Sampling period
T = 1/Fs;
% Time vector
t = (0:L-1)*T;
% Plot the audio data
%figure(1)
%plot(t,y)
Y = fft(y);
P2 = abs(Y/L);
P1 = P2(1:floor(L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
f = (Fs*(0:(L/2))/L); 



f = f(:);
P1 = P1(:);
[pks, freq, w, p] = findpeaks(P1, f, 'MinPeakProminence',0.001, 'MinPeakDistance', 50);
audioData = table(freq, pks, w, p, 'VariableNames', {'Frequency', 'PeakHeight', 'PeakWidth', 'Prominence'})

plot(f, P1)
title('Single-Sided Amplitude Specturm of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim([0 2000])
hold on
plot(audioData.Frequency, audioData.PeakHeight, 'ro')
hold off
G(k)=getframe;
k=k+1;
end
close all
movie(G)