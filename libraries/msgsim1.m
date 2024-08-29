function msgsim1
defaultString = 'Bem vindo, estamos muito feliz por você estar aqui!';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end

