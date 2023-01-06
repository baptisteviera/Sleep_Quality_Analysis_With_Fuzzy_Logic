irr_magF =[]
magF =readfis ('SF9MagnesiumFemme.fis');
prompt = {'Taux de Magnesium (100 à 3000 mg/jour):'};

def ={'310'};
dlgtitle='Test Magnesium Femme';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

Mag_F = str2num(answer{1});

[sortie, irr_magF, orr, arr] = evalfis([Mag_F], magF);
decl_magF = min(irr_magF, [], 2);

nb_regles_magF = length(magF.rule);
nb_ccl_magF = length(magF.output.mf);
ccl_magF = zeros(1,nb_ccl_magF);

for i = 1:nb_regles_magF,
    ccl_magF(magF.rule(i).consequent)=max(ccl_magF(magF.rule(i).consequent),...
        decl_magF(i));
end;

ccl_magFTxt='Consequence Magnesium Femme ={';
for i = 1:nb_ccl_magF,
    ccl_magFTxt=[ccl_magFTxt,'(',magF.output.mf(i).name,';',...
                 num2str(ccl_magF(i)), '), '];
end;

 ccl_magFTxt=[ccl_magFTxt(1:end-2), '}'];
 disp(ccl_magFTxt);
   