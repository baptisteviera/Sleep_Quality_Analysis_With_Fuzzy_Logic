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

Vit_E = str2num(answer{1});

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
   