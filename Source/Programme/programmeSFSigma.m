prompt ={'Sur cb de jours voulez-vous faire le test'};
def ={'1'};
dlgtitle='Nbr jour';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;
nb_jours = str2num(answer{1});

calcium=0;
heure=0;
vitamineB6=0;

for i=1: nb_jours,
    
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
calcium = calcium / nb_jours;
heure = heure / nb_jours;
vitamineB6 = vitamineB6 / nb_jours;

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
 
for i=1: nb_jours,
    
irr_vitE =[]
vitE =readfis ('SF7VitamineE.fis');
prompt = {'Taux de Vitamine E (0 à 1 UI):'};

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

Vit_E=Vit_E/nb_jours

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

