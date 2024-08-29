function msgsim5
defaultString = 'Pronto, tua malha ta pronta!';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end