function Falasim
msgsim2
prompt = 'Do you want more? Y/N [Y]: ';
str = input(prompt,'s');
if isempty(str)
    str = 'Y';
end
if str=='N' || str=='n'
    msgsim3
end
end

function msgsim1
defaultString = 'Bem vindo, estamos muito feliz por você estar aqui!';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end

function msgsim2
defaultString = 'Tem mais alguma duvida?';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end

function msgsim3
defaultString = 'Obrigado por utilizar nosso simulador inteligente e modelagem, Até mais!!';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end

function msgsim4
defaultString = 'Vamos agora Gerar a sua malha!';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end

function msgsim5
defaultString = 'Pronto, tua malha ta pronta!';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );
end