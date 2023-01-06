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
    
    
    
    
    
    