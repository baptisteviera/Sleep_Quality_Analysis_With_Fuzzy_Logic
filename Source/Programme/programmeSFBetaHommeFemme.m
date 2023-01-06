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
prompt = {'Meditation (0 à 60 min):',...
    'Taux de vitamine C (5 à 2500 mg/L):',...
   'Niveau sonore (0 à 120 db):'};

def ={'10','90','35'};
dlgtitle='Test cortisol';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

meditation = str2num(answer{1});
vitamine_C = str2num(answer{2});
niv_sonore = str2num(answer{3});

[sortie, irr_cortisol, orr, arr] = evalfis([meditation, vitamine_C,niv_sonore], cortisol);
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
prompt = {'Meditation (0 à 60 min):',...
    'Taux de vitamine C (5 à 2500 mg/L):',...
    'Niveau sonore (0 à 120 db):'};


def ={'10','70','35'};
dlgtitle='Test cortisol';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

meditation = str2num(answer{1});
vitamine_C = str2num(answer{2});
niv_sonore = str2num(answer{3});

[sortie, irr_cortisol, orr, arr] = evalfis([meditation, vitamine_C,niv_sonore], cortisol);
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

 
