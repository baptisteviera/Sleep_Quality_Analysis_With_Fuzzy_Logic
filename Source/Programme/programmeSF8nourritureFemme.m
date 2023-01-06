
irr_nourrF =[]
nourrF =readfis ('SF8NourritureFemme.fis');
prompt = {'Taux de glucides (50 à 700 g):',...
    'Taux de gras (33 à 300 g):',...
    'taux de fibres (5 à 100 g):'};

def ={'260','70','25'};
dlgtitle='Test nourrF';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

glucide = str2num(answer{1});
gras = str2num(answer{2});
fibres = str2num(answer{3});

[sortie, irr_nourrF, orr, arr] = evalfis([glucide, gras,fibres], nourrF);
decl_nourrF = min(irr_nourrF, [], 2);

nb_regles_nourrF = length(nourrF.rule);
nb_ccl_nourrF = length(nourrF.output.mf);
ccl_nourrF = zeros(1,nb_ccl_nourrF);

for i = 1:nb_regles_nourrF,
    ccl_nourrF(nourrF.rule(i).consequent)=max(ccl_nourrF(nourrF.rule(i).consequent),...
        decl_nourrF(i));
end;

ccl_nourrFTxt='Consequence nourriture pour une femme ={';
for i = 1:nb_ccl_nourrF,
    ccl_nourrFTxt=[ccl_nourrFTxt,'(',nourrF.output.mf(i).name,';',...
                 num2str(ccl_nourrF(i)), '), '];
end;

 ccl_nourrFTxt=[ccl_nourrFTxt(1:end-2), '}'];
 disp(ccl_nourrFTxt);