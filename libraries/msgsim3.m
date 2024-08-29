function msgsim3
defaultString = 'Obrigado por utilizar nosso simular inteligente e modelagem';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end