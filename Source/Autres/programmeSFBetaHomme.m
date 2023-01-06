    
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

 
%début programme pour le SF beta Homme

irr_betaH=[];
betaH =readfis ('SFBetaHomme.fis');
 
nb_regles_betaH = length(betaH.rule);
nb_ccl_betaH = length(betaH.output.mf);

for i = 1:nb_regles_betaH,
   irr_betaH(i,1)= ccl_magH(betaH.rule(i).antecedent(1));
   irr_betaH(i,2)= ccl_cortisolH(betaH.rule(i).antecedent(2));
end;

decl_betaH = min(irr_betaH, [], 2);

ccl_betaH = zeros(1,nb_ccl_betaH);

for i = 1:nb_regles_betaH,
    ccl_betaH(betaH.rule(i).consequent)=max(ccl_betaH(betaH.rule(i).consequent),...
        decl_betaH(i));
end;

ccl_betaHTxt='Consequence ondes beta pour un homme ={';
for i = 1:nb_ccl_betaH,
    ccl_betaHTxt=[ccl_betaHTxt,'(',betaH.output.mf(i).name,';',...
                 num2str(ccl_betaH(i)), '), '];
end;


ccl_betaHTxt=[ccl_betaHTxt(1:end-2), '}'];
 disp(ccl_betaHTxt);
 
 