
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