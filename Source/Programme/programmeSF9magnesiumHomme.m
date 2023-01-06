irr_magH =[]
magH =readfis ('SF9MagnesiumHomme.fis');
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
   