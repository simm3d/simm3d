function msgsim4
defaultString = 'Vamos agora Gerar a sua malha!';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end