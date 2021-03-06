clc;clear close all;
% parameters
load gong.mat;
iEchoDelayTimeInSeconds = 7;
iTotalNumberOfEcho = 10;
iSamplingdFrequency = Fs;
fEchoRollOffInPercent = 0.2;
fEchoStartImpulseInPercent = 0.5;

%Generate Impulse signal for echo
iEchoDelayTimeInSampels = floor(iEchoDelayTimeInSeconds*Fs);
iNumberOfSampelsInInterterval = floor(iEchoDelayTimeInSampels/iTotalNumberOfEcho);
fEchoImpulse = fEchoStartImpulseInPercent;
for iInterval=1:iTotalNumberOfEcho
    aaImpulseForEachEcho(iInterval,:) = [fEchoImpulse zeros(1,iNumberOfSampelsInInterterval)];
    fEchoImpulse = fEchoImpulse*(1-fEchoRollOffInPercent);
    
end
aTemp = [aaImpulseForEachEcho(1,:) aaImpulseForEachEcho(2,:)];

for i =3:iTotalNumberOfEcho
    
    aTemp = [aTemp aaImpulseForEachEcho(i,:)];
end

%convolution 
aEchoImpulse = aTemp;
aEcho=conv(y,aEchoImpulse);



%plots
subplot(3,1,1)
plot(y)
title('Original sound');
ylabel('Amplitude');
xlabel('Sampel');

subplot(3,1,2)
plot(aEchoImpulse)
title('Impulse signal');
ylabel('Amplitude');
xlabel('Sampel');


subplot(3,1,3)
plot(aEcho)
title('Output sound');
ylabel('Amplitude');
xlabel('Sampel');
sound(aEcho,Fs)