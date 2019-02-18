clc;clear close all;
% parameters

load gong.mat;
iEchoDelayTimeInSeconds = 7;
iTotalNumberOfEcho = 1000;
iSamplingdFrequency = Fs;
fEchoRollOffInPercent = 0.2;
fEchoStartImpulseInPercent = 1;

subplot(3,1,1)
plot(y)
xlabel('TIME DURATION');
ylabel('AMPLITUDE');
legend('ORIGINAL SOUND');
size(y)

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
aEchoImpulse = aTemp;

subplot(3,1,2)
plot(aEchoImpulse)
xlabel('TIME DELAY');
ylabel('AMPLITUDE');
legend('IMPULSE FOR ECHO');
aEcho=conv(y,aEchoImpulse);
subplot(3,1,3)
plot(aEcho)
sound(aEcho,Fs)