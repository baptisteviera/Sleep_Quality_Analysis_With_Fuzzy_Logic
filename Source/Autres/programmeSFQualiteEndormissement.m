
%Alpha (valable pour Homme et Femme)

irr_alpha =[]
alpha =readfis ('SF2Alpha.fis');
prompt = {'Taux d alcool (0 à 1) g/kg:',...
    'Nombre de cigarettes par jour (0 à 14):'};

def ={'0','0'};
dlgtitle='Test alpha';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

taux_alcool = str2num(answer{1});
taux_nicotine = str2num(answer{2});

[sortie, irr_alpha, orr, arr] = evalfis([taux_alcool, taux_nicotine], alpha);
decl_alpha = min(irr_alpha, [], 2);

nb_regles_alpha = length(alpha.rule);
nb_ccl_alpha = length(alpha.output.mf);
ccl_alpha = zeros(1,nb_ccl_alpha);

for i = 1:nb_regles_alpha,
    ccl_alpha(alpha.rule(i).consequent)=max(ccl_alpha(alpha.rule(i).consequent),...
        decl_alpha(i));
end;

ccl_alphaTxt='Consequence alpha ={';
for i = 1:nb_ccl_alpha,
    ccl_alphaTxt=[ccl_alphaTxt,'(',alpha.output.mf(i).name,';',...
                 num2str(ccl_alpha(i)), '), '];
end;

 ccl_alphaTxt=[ccl_alphaTxt(1:end-2), '}'];
 disp(ccl_alphaTxt);
    

%Homme ou Femme ? 
 Homme=1;
Femme=0;
prompt ={'Tape 1 si homme, tape 0 si femme :'}

def ={'0'};
dlgtitle='Genre';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;
 
reponse = str2num(answer{1});

% Si c'est un Homme
if reponse == 1
 
% BETA HOMME
%magnésium Homme
irr_magH =[]
magH = readfis ('SF9MagnesiumHomme.fis');
prompt = {'Taux de Magnesium (100 à 3000 mg/jour):'};

def ={'410'};
dlgtitle='Test Magnesium Homme';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

Mag_H = str2num(answer{1});

[sortie, irr_magH, orr, arr] = evalfis([Mag_H], magH);
decl_magH = min(irr_magH, [], 2);

nb_regles_magH = length(magH.rule);
nb_ccl_magH = length(magH.output.mf);
ccl_magH = zeros(1,nb_ccl_magH);

for i = 1:nb_regles_magH,
    ccl_magH(magH.rule(i).consequent)=max(ccl_magH(magH.rule(i).consequent),...
        decl_magH(i));
end;

ccl_magHTxt='Consequence Magnesium Homme ={';
for i = 1:nb_ccl_vitE,
    ccl_magHTxt=[ccl_magHTxt,'(',magH.output.mf(i).name,';',...
                 num2str(ccl_magH(i)), '), '];
end;

 ccl_magHTxt=[ccl_magHTxt(1:end-2), '}'];
 disp(ccl_magHTxt);
   
 
%Cortisol Homme
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


irr_beta=[];
beta =readfis ('SFBetaHomme.fis');
 
nb_regles_beta = length(beta.rule);
nb_ccl_beta = length(beta.output.mf);

for i = 1:nb_regles_beta,
   irr_beta(i,1)= ccl_magH(beta.rule(i).antecedent(1));
   irr_beta(i,2)= ccl_cortisolH(beta.rule(i).antecedent(2));
end;

decl_beta = min(irr_beta, [], 2);

ccl_beta = zeros(1,nb_ccl_beta);

for i = 1:nb_regles_beta,
    ccl_beta(beta.rule(i).consequent)=max(ccl_beta(beta.rule(i).consequent),...
        decl_beta(i));
end;

ccl_betaTxt='Consequence ondes beta pour un homme ={';
for i = 1:nb_ccl_beta,
    ccl_betaTxt=[ccl_betaTxt,'(',beta.output.mf(i).name,';',...
                 num2str(ccl_beta(i)), '), '];
end;


ccl_betaTxt=[ccl_betaTxt(1:end-2), '}'];
 disp(ccl_betaTxt);
 
 

% Si c'est une Femme    
else
% BETA FEMME

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

irr_beta=[];
beta =readfis ('SFBetaFemme.fis');
 
nb_regles_beta = length(beta.rule);
nb_ccl_beta = length(beta.output.mf);

for i = 1:nb_regles_beta,
   irr_beta(i,1)= ccl_magF(beta.rule(i).antecedent(1));
   irr_beta(i,2)= ccl_cortisolF(beta.rule(i).antecedent(2));
end;

decl_beta = min(irr_beta, [], 2);

ccl_beta = zeros(1,nb_ccl_beta);

for i = 1:nb_regles_beta,
    ccl_beta(beta.rule(i).consequent)=max(ccl_beta(beta.rule(i).consequent),...
        decl_beta(i));
end;

ccl_betaTxt='Consequence ondes beta pour une femme ={';
for i = 1:nb_ccl_beta,
    ccl_betaTxt=[ccl_betaTxt,'(',beta.output.mf(i).name,';',...
                 num2str(ccl_beta(i)), '), '];
end;


ccl_betaTxt=[ccl_betaTxt(1:end-2), '}'];
 disp(ccl_betaTxt);
 
end;

%debut programme endormissement
irr_endormissement=[];
endormissement =readfis ('SFQEndormissement.fis');
 
 nb_regles_endormissement = length(endormissement.rule);
nb_ccl_endormissement = length(endormissement.output.mf);

for i = 1:nb_regles_endormissement,
   irr_endormissement(i,1)= ccl_beta(endormissement.rule(i).antecedent(1));
   irr_endormissement(i,2)= ccl_alpha(endormissement.rule(i).antecedent(2));
end;

decl_endormissement = min(irr_endormissement, [], 2);

ccl_endormissement = zeros(1,nb_ccl_endormissement);

for i = 1:nb_regles_endormissement,
    ccl_endormissement(endormissement.rule(i).consequent)=max(ccl_endormissement(endormissement.rule(i).consequent),...
        decl_endormissement(i));
end;

ccl_endormissementTxt='Consequence Qualité Endormissement ={';
for i = 1:nb_ccl_endormissement,
    ccl_endormissementTxt=[ccl_endormissementTxt,'(',endormissement.output.mf(i).name,';',...
                 num2str(ccl_endormissement(i)), '), '];
end;


ccl_endormissementTxt=[ccl_endormissementTxt(1:end-2), '}'];
 disp(ccl_endormissementTxt);
    