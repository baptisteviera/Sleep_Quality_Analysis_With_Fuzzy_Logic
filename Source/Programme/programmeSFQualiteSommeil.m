%Qualité sommeil

prompt ={'Sur cb de nuits voulez-vous faire le test'};
def ={'1'};
dlgtitle='Nbr nuits';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;
nb_nuits = str2num(answer{1});


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

%Alpha (valable pour Homme et Femme)

taux_alcool=0;
taux_nicotine=0;

for i=1: nb_nuits,
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

taux_alcool = str2num(answer{1})+ taux_alcool;
taux_nicotine = str2num(answer{2}) + taux_nicotine;
end;

taux_nicotine=taux_nicotine/nb_nuits;
taux_alcool=taux_alcool/nb_nuits;

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
    
    

if reponse == 1
    
%magnésium Homme

Mag_H=0;

for i=1: nb_nuits,
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

Mag_H = str2num(answer{1})+ Mag_H;
end;
Mag_H = Mag_H/nb_nuits;

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
niv_sonore=0;
vitamine_C=0;
meditation=0;

for i=1: nb_nuits,
    
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

niv_sonore = str2num(answer{1})+niv_sonore;
vitamine_C = str2num(answer{2})+vitamine_C;
meditation = str2num(answer{3})+meditation;
end;

niv_sonore=niv_sonore/nb_nuits;
vitamine_C=vitamine_C/nb_nuits;
meditation=meditation/nb_nuits;

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
    
mag_F=0;

for i=1: nb_nuits,
    
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

mag_F = str2num(answer{1})+mag_F;

end;

mag_F = mag_F/nb_nuits;

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

niv_sonore=0;
vitamine_C=0;
meditation=0;
for i=1: nb_nuits,
    
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

niv_sonore = str2num(answer{1})+ niv_sonore;
vitamine_C = str2num(answer{2})+ vitamine_C;
meditation = str2num(answer{3})+ meditation;

end;

niv_sonore=niv_sonore/nb_nuits;
vitamine_C=vitamine_C/nb_nuits;
meditation=meditation/nb_nuits;

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
 
  
 

%debut programme sommeil
irr_sommeil=[];
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

ccl_endormissementTxt='Consequence Qualité endormissement ={';
for i = 1:nb_ccl_endormissement,
    ccl_endormissementTxt=[ccl_endormissementTxt,'(',endormissement.output.mf(i).name,';',...
                 num2str(ccl_endormissement(i)), '), '];
end;


ccl_endormissementTxt=[ccl_endormissementTxt(1:end-2), '}'];
 disp(ccl_endormissementTxt);
    
 %Onde Delta
 
 %Adenosine
 
irr_adenosine =[]
adenosine =readfis ('SF1Adenosine.fis');
prompt = {'Café quantité (0 à 10):',...
    'café heure (0 à 24):'};

def ={'2','10'};
dlgtitle='Test Adenosine';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

cafeQ = str2num(answer{1});
cafeH = str2num(answer{2});

[sortie, irr_adenosine, orr, arr] = evalfis([cafeQ, cafeH], adenosine);
decl_adeno = min(irr_adenosine, [], 2);

nb_regles_adeno = length(adenosine.rule);
nb_ccl_adeno = length(adenosine.output.mf);
ccl_adeno = zeros(1,nb_ccl_adeno);

for i = 1:nb_regles_adeno,
    ccl_adeno(adenosine.rule(i).consequent)=max(ccl_adeno(adenosine.rule(i).consequent),...
        decl_adeno(i));
end;

ccl_adenoTxt='Consequence adénosine ={';
for i = 1:nb_ccl_adeno,
    ccl_adenoTxt=[ccl_adenoTxt,'(',adenosine.output.mf(i).name,';',...
                 num2str(ccl_adeno(i)), '), '];
end;

 ccl_adenoTxt=[ccl_adenoTxt(1:end-2), '}'];
 disp(ccl_adenoTxt);
    

if reponse == 1
  
 %Qualité nourriture
 
glucide = 0;
gras = 0;
fibres = 0;

for i=1: nb_nuits, 
    
irr_nourr =[]
nourr =readfis ('SF8NourritureHomme.fis');
prompt = {'Taux de glucides (50 à 700 g):',...
    'Taux de gras (33 à 300 g):',...
    'taux de fibres (5 à 100 g):'};

def ={'350','100','35'};
dlgtitle='Test nourrH';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

glucide = str2num(answer{1})+glucide;
gras = str2num(answer{2})+gras;
fibres = str2num(answer{3})+fibres;

end;

glucide=glucide/nb_nuits;
gras=gras/nb_nuits;
fibres=fibres/nb_nuits;

[sortie, irr_nourr, orr, arr] = evalfis([glucide, gras,fibres], nourr);
decl_nourr = min(irr_nourr, [], 2);

nb_regles_nourr = length(nourr.rule);
nb_ccl_nourr = length(nourr.output.mf);
ccl_nourr = zeros(1,nb_ccl_nourr);

for i = 1:nb_regles_nourr,
    ccl_nourr(nourr.rule(i).consequent)=max(ccl_nourr(nourr.rule(i).consequent),...
        decl_nourr(i));
end;

ccl_nourrTxt='Consequence nourriture pour un homme ={';
for i = 1:nb_ccl_nourr,
    ccl_nourrTxt=[ccl_nourrTxt,'(',nourr.output.mf(i).name,';',...
                 num2str(ccl_nourr(i)), '), '];
end;

 ccl_nourrTxt=[ccl_nourrTxt(1:end-2), '}'];
 disp(ccl_nourrTxt);
    

else
    
glucide = 0;
gras = 0;
fibres = 0;

for i=1: nb_nuits, 
    
irr_nourr =[]
nourr =readfis ('SF8NourritureFemme.fis');
prompt = {'Taux de glucides (50 à 600 g):',...
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

glucide = str2num(answer{1})+glucide;
gras = str2num(answer{2})+gras;
fibres = str2num(answer{3})+fibres;

end;

glucide=glucide/nb_nuits;
gras=gras/nb_nuits;
fibres=fibres/nb_nuits;

[sortie, irr_nourr, orr, arr] = evalfis([glucide, gras,fibres], nourr);
decl_nourr = min(irr_nourr, [], 2);

nb_regles_nourr = length(nourr.rule);
nb_ccl_nourr = length(nourr.output.mf);
ccl_nourr = zeros(1,nb_ccl_nourr);

for i = 1:nb_regles_nourr,
    ccl_nourr(nourr.rule(i).consequent)=max(ccl_nourr(nourr.rule(i).consequent),...
        decl_nourr(i));
end;

ccl_nourrTxt='Consequence nourriture pour une femme ={';
for i = 1:nb_ccl_nourr,
    ccl_nourrTxt=[ccl_nourrTxt,'(',nourr.output.mf(i).name,';',...
                 num2str(ccl_nourr(i)), '), '];
end;

 ccl_nourrTxt=[ccl_nourrTxt(1:end-2), '}'];
 disp(ccl_nourrTxt);
 
end;

  irr_delta=[];
 delta =readfis ('SFdelta.fis');
 
 nb_regles_delta = length(delta.rule);
nb_ccl_delta = length(delta.output.mf);

for i = 1:nb_regles_delta,
   irr_delta(i,1)= ccl_adeno(delta.rule(i).antecedent(1));
   irr_delta(i,2)= ccl_nourr(delta.rule(i).antecedent(2));
end;

decl_delta = min(irr_delta, [], 2);

ccl_delta = zeros(1,nb_ccl_delta);

for i = 1:nb_regles_delta,
    ccl_delta(delta.rule(i).consequent)=max(ccl_delta(delta.rule(i).consequent),...
        decl_delta(i));
end;

ccl_deltaTxt='Consequence Ondes Delta ={';
for i = 1:nb_ccl_delta,
    ccl_deltaTxt=[ccl_deltaTxt,'(',delta.output.mf(i).name,';',...
                 num2str(ccl_delta(i)), '), '];
end;


ccl_deltaTxt=[ccl_deltaTxt(1:end-2), '}'];
 disp(ccl_deltaTxt);

 
 %Ondes Sigma
 
 %Melatonine
 
calcium=0;
heure=0;
vitamineB6=0;

for i=1: nb_nuits,
    
irr_melato =[]
melato =readfis('SF6Melatonine.fis');
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

calcium = str2num(answer{1})+ calcium;
heure = str2num(answer{2})+ heure;
vitamineB6 = str2num(answer{3})+ vitamineB6;

end;

calcium = calcium / nb_nuits;
heure = heure / nb_nuits;
vitamineB6 = vitamineB6 / nb_nuits;

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
 
 
 
 Vit_E = 0;
 
for i=1: nb_nuits,
    
irr_vitE =[]
vitE =readfis ('SF7VitamineE.fis');
prompt = {'Taux de Vitamine E (0 à 400 UI):'};

def ={'22'};
dlgtitle='Test Vitamine E';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

Vit_E = str2num(answer{1})+ Vit_E;

end;

Vit_E=Vit_E/nb_nuits;

[sortie, irr_VitE, orr, arr] = evalfis([Vit_E], vitE);
decl_vitE = min(irr_VitE, [], 2);

nb_regles_vitE = length(vitE.rule);
nb_ccl_vitE = length(vitE.output.mf);
ccl_vitE = zeros(1,nb_ccl_vitE);

for i = 1:nb_regles_vitE,
    ccl_vitE(vitE.rule(i).consequent)=max(ccl_vitE(vitE.rule(i).consequent),...
        decl_vitE(i));
end;

ccl_vitETxt='Consequence vitamine E ={';
for i = 1:nb_ccl_vitE,
    ccl_vitETxt=[ccl_vitETxt,'(',vitE.output.mf(i).name,';',...
                 num2str(ccl_vitE(i)), '), '];
end;

 ccl_vitETxt=[ccl_vitETxt(1:end-2), '}'];
 disp(ccl_vitETxt);
   
 irrsigma=[];
 sigma =readfis ('SFsigmatest.fis');
 
 nb_regles_sigma = length(sigma.rule);
nb_ccl_sigma = length(sigma.output.mf);

for i = 1:nb_regles_sigma,
   irrsigma(i,1)= ccl_melato(sigma.rule(i).antecedent(1));
   irrsigma(i,2)= ccl_vitE(sigma.rule(i).antecedent(2));
end;

decl_sigma = min(irrsigma, [], 2);

ccl_sigma = zeros(1,nb_ccl_sigma);

for i = 1:nb_regles_sigma,
    ccl_sigma(sigma.rule(i).consequent)=max(ccl_sigma(sigma.rule(i).consequent),...
        decl_sigma(i));
end;

ccl_sigmaTxt='Consequence Ondes Sigma ={';
for i = 1:nb_ccl_sigma,
    ccl_sigmaTxt=[ccl_sigmaTxt,'(',sigma.output.mf(i).name,';',...
                 num2str(ccl_sigma(i)), '), '];
end;


ccl_sigmaTxt=[ccl_sigmaTxt(1:end-2), '}'];
 disp(ccl_sigmaTxt);

 
%debut programme Qualité Sommeil


irr_sommeil=[];
sommeil =readfis ('SFQualiteSommeil.fis');
 
 nb_regles_sommeil = length(sommeil.rule);
nb_ccl_sommeil = length(sommeil.output.mf);

for i = 1:nb_regles_sommeil,
   irr_sommeil(i,1)= ccl_sigma(sommeil.rule(i).antecedent(1));
   irr_sommeil(i,2)= ccl_delta(sommeil.rule(i).antecedent(2));
   irr_sommeil(i,3)= ccl_endormissement(sommeil.rule(i).antecedent(3));
end;

decl_sommeil = min(irr_sommeil, [], 2); %pourquoi on a 2 ici ???

ccl_sommeil = zeros(1,nb_ccl_sommeil);

for i = 1:nb_regles_sommeil,
    ccl_sommeil(sommeil.rule(i).consequent)=max(ccl_sommeil(sommeil.rule(i).consequent),...
        decl_sommeil(i));
end;

ccl_sommeilTxt='Consequence Qualité sommeil ={';
for i = 1:nb_ccl_sommeil,
    ccl_sommeilTxt=[ccl_sommeilTxt,'(',sommeil.output.mf(i).name,';',...
                 num2str(ccl_sommeil(i)), '), '];
end;
 
 ccl_sommeilTxt=[ccl_sommeilTxt(1:end-2), '}'];
 disp(ccl_sommeilTxt);
 
 %deffuzzification
 
 ccl_sommeil=[ccl_sommeil(1) ccl_sommeil(2) ccl_sommeil(3)];
 disp(ccl_sommeil);
 ccl_temoin = [10 50 100];
 disp(ccl_temoin);
 disp('La qualité sur 100 de votre sommeil est de :');
 disp(sum(ccl_temoin.*ccl_sommeil)/sum(ccl_sommeil));
 
 
 %Conseils précononisés pour améliorer la qualité du sommeil !
 
irr_conseils=[];
conseils =readfis ('SFConseils.fis');
 
nb_regles_conseils = length(conseils.rule);
nb_ccl_conseils = length(conseils.output.mf);

for i = 1:nb_regles_conseils,
   irr_conseils(i,1)= ccl_apnee(conseils.rule(i).antecedent(1));
   irr_conseils(i,2)= ccl_insomnie(conseils.rule(i).antecedent(2));
   irr_conseils(i,3)= ccl_sommeil(conseils.rule(i).antecedent(3));
end;

decl_conseils = min(irr_conseils, [], 2); %pourquoi on a 2 ici ???

ccl_conseils = zeros(1,nb_ccl_conseils);

for i = 1:nb_regles_conseils,
    ccl_conseils(conseils.rule(i).consequent)=max(ccl_conseils(conseils.rule(i).consequent),...
        decl_conseils(i));
end;

ccl_conseilsTxt='Les petits conseils de notre programme ={';
for i = 1:nb_ccl_conseils,
    ccl_conseilsTxt=[ccl_conseilsTxt,'(',conseils.output.mf(i).name,';',...
                 num2str(ccl_conseils(i)), '), '];
end;
 
 ccl_conseilsTxt=[ccl_conseilsTxt(1:end-2), '}'];
 disp(ccl_conseilsTxt);
 
    