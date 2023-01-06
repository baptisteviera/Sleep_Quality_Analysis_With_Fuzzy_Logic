    
%magnésium Femme
irr_magF =[]
magF = readfis ('SF9MagnesiumFemme.fis');
prompt = {'Taux de Magnesium (100 à 3000 mg/jour):'};

def ={'310'};
dlgtitle='Test Magnesium Femme';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

mag_F = str2num(answer{1});

[sortie, irr_magF, orr, arr] = evalfis([mag_F], magF);
decl_magF = min(irr_magF, [], 2);

nb_regles_magF = length(magF.rule);
nb_ccl_magF = length(magF.output.mf);
ccl_magF = zeros(1,nb_ccl_magF);

for i = 1:nb_regles_magF,
    ccl_magF(magF.rule(i).consequent)=max(ccl_magF(magF.rule(i).consequent),...
        decl_magF(i));
end;

ccl_magFTxt='Consequence Magnesium Femme ={';
for i = 1:nb_ccl_vitE,
    ccl_magFTxt=[ccl_magFTxt,'(',magF.output.mf(i).name,';',...
                 num2str(ccl_magF(i)), '), '];
end;

 ccl_magFTxt=[ccl_magFTxt(1:end-2), '}'];
 disp(ccl_magFTxt);
   
 
%Cortisol Femme
irr_cortisolF =[]
cortisolF =readfis ('SF3CortisolFemme.fis');
prompt = {'Niveau sonore (0 à 120 db):',...
    'Taux de vitamine C (5 à 2500 mg/L):',...
    'Meditation (0 à 60 min):'};

def ={'35','70','10'};
dlgtitle='Test cortisolF';
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

 
%début programme pour le SF beta Femme

irr_betaF=[];
betaF =readfis ('SFBetaFemme.fis');
 
nb_regles_betaF = length(betaF.rule);
nb_ccl_betaF = length(betaF.output.mf);

for i = 1:nb_regles_betaF,
   irr_betaF(i,1)= ccl_magF(betaF.rule(i).antecedent(1));
   irr_betaF(i,2)= ccl_cortisolF(betaF.rule(i).antecedent(2));
end;

decl_betaF = min(irr_betaF, [], 2);

ccl_betaF = zeros(1,nb_ccl_betaF);

for i = 1:nb_regles_betaF,
    ccl_betaF(betaF.rule(i).consequent)=max(ccl_betaF(betaF.rule(i).consequent),...
        decl_betaF(i));
end;

ccl_betaFTxt='Consequence ondes beta pour une femme ={';
for i = 1:nb_ccl_betaF,
    ccl_betaFTxt=[ccl_betaFTxt,'(',betaF.output.mf(i).name,';',...
                 num2str(ccl_betaF(i)), '), '];
end;


ccl_betaFTxt=[ccl_betaFTxt(1:end-2), '}'];
 disp(ccl_betaFTxt);
 
 