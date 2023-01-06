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
    
 
irr_nourrH =[]
nourrH =readfis ('SF8NourritureHomme.fis');
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

glucide = str2num(answer{1});
gras = str2num(answer{2});
fibres = str2num(answer{3});

[sortie, irr_nourrH, orr, arr] = evalfis([glucide, gras,fibres], nourrH);
decl_nourrH = min(irr_nourrH, [], 2);

nb_regles_nourrH = length(nourrH.rule);
nb_ccl_nourrH = length(nourrH.output.mf);
ccl_nourrH = zeros(1,nb_ccl_nourrH);

for i = 1:nb_regles_nourrH,
    ccl_nourrH(nourrH.rule(i).consequent)=max(ccl_nourrH(nourrH.rule(i).consequent),...
        decl_nourrH(i));
end;

ccl_nourrHTxt='Consequence nourriture pour un homme ={';
for i = 1:nb_ccl_nourrH,
    ccl_nourrHTxt=[ccl_nourrHTxt,'(',nourrH.output.mf(i).name,';',...
                 num2str(ccl_nourrH(i)), '), '];
end;

 ccl_nourrHTxt=[ccl_nourrHTxt(1:end-2), '}'];
 disp(ccl_nourrHTxt);
    

  irr_delta=[];
 delta =readfis ('SFdelta.fis');
 
 nb_regles_delta = length(delta.rule);
nb_ccl_delta = length(delta.output.mf);

for i = 1:nb_regles_delta,
   irr_delta(i,1)= ccl_adeno(delta.rule(i).antecedent(1));
   irr_delta(i,2)= ccl_nourrH(delta.rule(i).antecedent(2));
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

 
 
 
    