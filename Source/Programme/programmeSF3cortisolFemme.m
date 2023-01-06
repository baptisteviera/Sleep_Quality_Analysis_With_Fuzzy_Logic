
irr_cortisolF =[]
cortisolF =readfis ('SF3CortisolFemme.fis');
prompt = {'Niveau sonore (0 à 120 db):',...
    'Taux de vitamine C (5 à 2500 mg/L):',...
    'Meditation (0 à 60 min):'};

def ={'35','70','10'};
dlgtitle='Test CortisolF';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

niv_sonore = str2num(answer{1});
vitamine_C = str2num(answer{2});
meditation = str2num(answer{3});

[sortie, irr_cortisolF, orr, arr] = evalfis([niv_sonore, vitamine_C,meditation], cortisolF);
decl_cortisolF = min(irr_cortisolF, [], 2);

nb_regles_cortisolF = length(cortisolF.rule);
nb_ccl_cortisolF = length(cortisolF.output.mf);
ccl_cortisolF = zeros(1,nb_ccl_cortisolF);

for i = 1:nb_regles_cortisolF,
    ccl_cortisolF(cortisolF.rule(i).consequent)=max(ccl_cortisolF(cortisolF.rule(i).consequent),...
        decl_cortisolF(i));
end;

ccl_cortisolFTxt='Consequence cortisol pour une femme ={';
for i = 1:nb_ccl_cortisolF,
    ccl_cortisolFTxt=[ccl_cortisolFTxt,'(',cortisolF.output.mf(i).name,';',...
                 num2str(ccl_cortisolF(i)), '), '];
end;

 ccl_cortisolFTxt=[ccl_cortisolFTxt(1:end-2), '}'];
 disp(ccl_cortisolFTxt);