
irr_cortisolH =[]
cortisolH =readfis ('SF3CortisolHomme.fis');
prompt = {'Niveau sonore (0 à 120 db):',...
    'Taux de vitamine C (5 à 2500 mg/L):',...
    'Meditation (0 à 60 min):'};

def ={'35','90','10'};
dlgtitle='Test CortisolH';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

niv_sonore = str2num(answer{1});
vitamine_C = str2num(answer{2});
meditation = str2num(answer{3});

[sortie, irr_cortisolH, orr, arr] = evalfis([niv_sonore, vitamine_C,meditation], cortisolH);
decl_cortisolH = min(irr_cortisolH, [], 2);

nb_regles_cortisolH = length(cortisolH.rule);
nb_ccl_cortisolH = length(cortisolH.output.mf);
ccl_cortisolH = zeros(1,nb_ccl_cortisolH);

for i = 1:nb_regles_cortisolH,
    ccl_cortisolH(cortisolH.rule(i).consequent)=max(ccl_cortisolH(cortisolH.rule(i).consequent),...
        decl_cortisolH(i));
end;

ccl_cortisolHTxt='Consequence cortisol pour un homme ={';
for i = 1:nb_ccl_cortisolH,
    ccl_cortisolHTxt=[ccl_cortisolHTxt,'(',cortisolH.output.mf(i).name,';',...
                 num2str(ccl_cortisolH(i)), '), '];
end;

 ccl_cortisolHTxt=[ccl_cortisolHTxt(1:end-2), '}'];
 disp(ccl_cortisolHTxt);