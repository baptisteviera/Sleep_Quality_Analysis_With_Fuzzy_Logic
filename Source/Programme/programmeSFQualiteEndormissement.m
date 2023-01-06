
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
    
    
prompt ={'Tape 1 si homme, tape 0 si femme :'};

def ={'0'};
dlgtitle='Genre';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;
 
reponse = str2num(answer{1});

if reponse == 1
    
%magnésium Homme
irr_mag =[]
mag = readfis ('SF9MagnesiumHomme.fis');
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

[sortie, irr_mag, orr, arr] = evalfis([Mag_H], mag);
decl_mag = min(irr_mag, [], 2);

nb_regles_mag = length(mag.rule);
nb_ccl_mag = length(mag.output.mf);
ccl_mag = zeros(1,nb_ccl_mag);

for i = 1:nb_regles_mag,
    ccl_mag(mag.rule(i).consequent)=max(ccl_mag(mag.rule(i).consequent),...
        decl_mag(i));
end;

ccl_magTxt='Consequence Magnesium Homme ={';
for i = 1:nb_ccl_mag,
    ccl_magTxt=[ccl_magTxt,'(',mag.output.mf(i).name,';',...
                 num2str(ccl_mag(i)), '), '];
end;

 ccl_magTxt=[ccl_magTxt(1:end-2), '}'];
 disp(ccl_magTxt);
   
 
%Cortisol Homme
irr_cortisol =[]
cortisol =readfis ('SF3cortisolHomme.fis');
prompt = {'Niveau sonore (0 à 120 db):',...
    'Taux de vitamine C (5 à 2500 mg/L):',...
    'Meditation (0 à 60 min):'};

def ={'35','90','10'};
dlgtitle='Test cortisol';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

niv_sonore = str2num(answer{1});
vitamine_C = str2num(answer{2});
meditation = str2num(answer{3});

[sortie, irr_cortisol, orr, arr] = evalfis([niv_sonore, vitamine_C,meditation], cortisol);
decl_cortisol = min(irr_cortisol, [], 2);

nb_regles_cortisol = length(cortisol.rule);
nb_ccl_cortisol = length(cortisol.output.mf);
ccl_cortisol = zeros(1,nb_ccl_cortisol);

for i = 1:nb_regles_cortisol,
    ccl_cortisol(cortisol.rule(i).consequent)=max(ccl_cortisol(cortisol.rule(i).consequent),...
        decl_cortisol(i));
end;

ccl_cortisolTxt='Consequence cortisol pour un homme ={';
for i = 1:nb_ccl_cortisol,
    ccl_cortisolTxt=[ccl_cortisolTxt,'(',cortisol.output.mf(i).name,';',...
                 num2str(ccl_cortisol(i)), '), '];
end;

 ccl_cortisolTxt=[ccl_cortisolTxt(1:end-2), '}'];
 disp(ccl_cortisolTxt);
 
else
    
    %magnésium Femme
irr_mag =[]
mag = readfis ('SF9MagnesiumFemme.fis');
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

[sortie, irr_mag, orr, arr] = evalfis([mag_F], mag);
decl_mag = min(irr_mag, [], 2);

nb_regles_mag = length(mag.rule);
nb_ccl_mag = length(mag.output.mf);
ccl_mag = zeros(1,nb_ccl_mag);

for i = 1:nb_regles_mag,
    ccl_mag(mag.rule(i).consequent)=max(ccl_mag(mag.rule(i).consequent),...
        decl_mag(i));
end;

ccl_magTxt='Consequence Magnesium Femme ={';
for i = 1:nb_ccl_mag,
    ccl_magTxt=[ccl_magTxt,'(',mag.output.mf(i).name,';',...
                 num2str(ccl_mag(i)), '), '];
end;

 ccl_magTxt=[ccl_magTxt(1:end-2), '}'];
 disp(ccl_magTxt);
   
 
%Cortisol Femme
irr_cortisol =[]
cortisol =readfis ('SF3cortisolFemme.fis');
prompt = {'Niveau sonore (0 à 120 db):',...
    'Taux de vitamine C (5 à 2500 mg/L):',...
    'Meditation (0 à 60 min):'};

def ={'35','70','10'};
dlgtitle='Test cortisol';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

niv_sonore = str2num(answer{1});
vitamine_C = str2num(answer{2});
meditation = str2num(answer{3});

[sortie, irr_cortisol, orr, arr] = evalfis([niv_sonore, vitamine_C,meditation], cortisol);
decl_cortisol = min(irr_cortisol, [], 2);

nb_regles_cortisol = length(cortisol.rule);
nb_ccl_cortisol = length(cortisol.output.mf);
ccl_cortisol = zeros(1,nb_ccl_cortisol);

for i = 1:nb_regles_cortisol,
    ccl_cortisol(cortisol.rule(i).consequent)=max(ccl_cortisol(cortisol.rule(i).consequent),...
        decl_cortisol(i));
end;

ccl_cortisolTxt='Consequence cortisol pour une femme ={';
for i = 1:nb_ccl_cortisol,
    ccl_cortisolTxt=[ccl_cortisolTxt,'(',cortisol.output.mf(i).name,';',...
                 num2str(ccl_cortisol(i)), '), '];
end;

 ccl_cortisolTxt=[ccl_cortisolTxt(1:end-2), '}'];
 disp(ccl_cortisolTxt);
    
end;

%début programme pour le SF beta 
irr_beta=[];
beta =readfis ('SFBeta.fis');
 
nb_regles_beta = length(beta.rule);
nb_ccl_beta = length(beta.output.mf);

for i = 1:nb_regles_beta,
   irr_beta(i,1)= ccl_mag(beta.rule(i).antecedent(1));
   irr_beta(i,2)= ccl_cortisol(beta.rule(i).antecedent(2));
end;

decl_beta = min(irr_beta, [], 2);

ccl_beta = zeros(1,nb_ccl_beta);

for i = 1:nb_regles_beta,
    ccl_beta(beta.rule(i).consequent)=max(ccl_beta(beta.rule(i).consequent),...
        decl_beta(i));
end;

ccl_betaTxt='Consequence ondes beta  ={';
for i = 1:nb_ccl_beta,
    ccl_betaTxt=[ccl_betaTxt,'(',beta.output.mf(i).name,';',...
                 num2str(ccl_beta(i)), '), '];
end;


ccl_betaTxt=[ccl_betaTxt(1:end-2), '}'];
 disp(ccl_betaTxt);
 
  
 

%debut programme endormissement
irr_endormissement=[];
endormissement =readfis ('SFQEndormissement.fis');
 
 nb_regles_endormissement = length(endormissement.rule);
nb_ccl_endormissement = length(endormissement.output.mf);

for i = 1:nb_regles_endormissement, %ATTENTION REGARDER L ORDRE A VERIFIER
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
    