
irr_melato =[]
melato =readfis ('SF6Melatonine.fis');
prompt = {'Taux de calcium (0 à 3 mmol/L):',...
    'Heure à laquelle vous avez regardé un écran (0 à 24):',...
    'Taux de vitamine B6 (0 à 207 mg/jour):'};

def ={'2.4','20','1.7'};
dlgtitle='Test melato';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

calcium = str2num(answer{1});
heure = str2num(answer{2});
vitamineB6 = str2num(answer{3});

[sortie, irr_melato, orr, arr] = evalfis([calcium, heure,vitamineB6], melato);
decl_melato = min(irr_melato, [], 2);

nb_regles_melato = length(melato.rule);
nb_ccl_melato = length(melato.output.mf);
ccl_melato = zeros(1,nb_ccl_melato);

for i = 1:nb_regles_melato,
    ccl_melato(melato.rule(i).consequent)=max(ccl_melato(melato.rule(i).consequent),...
        decl_melato(i));
end;

ccl_melatoTxt='Consequence melatonine ={';
for i = 1:nb_ccl_melato,
    ccl_melatoTxt=[ccl_melatoTxt,'(',melato.output.mf(i).name,';',...
                 num2str(ccl_melato(i)), '), '];
end;

 ccl_melatoTxt=[ccl_melatoTxt(1:end-2), '}'];
 disp(ccl_melatoTxt);