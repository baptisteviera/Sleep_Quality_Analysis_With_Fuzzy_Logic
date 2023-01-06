
irr_apnee =[]
apnee =readfis ('SF4Apnee.fis');
prompt = {'Rythme cardiaque (10 à 180 bts/min):',...
    'Nombre d apnee par heure de plus de 10 secondes (0 à 40):',...
    'Taux d oxygene dans le sang (70 à 100 %):'};

def ={'60','0','95'};
dlgtitle='Test apnee';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

rythmecardiaque = str2num(answer{1});
nb_apnee = str2num(answer{2});
oxygene = str2num(answer{3});

[sortie, irr_apnee, orr, arr] = evalfis([rythmecardiaque, nb_apnee,oxygene], apnee);
decl_apnee = min(irr_apnee, [], 2);

nb_regles_apnee = length(apnee.rule);
nb_ccl_apnee = length(apnee.output.mf);
ccl_apnee = zeros(1,nb_ccl_apnee);

for i = 1:nb_regles_apnee,
    ccl_apnee(apnee.rule(i).consequent)=max(ccl_apnee(apnee.rule(i).consequent),...
        decl_apnee(i));
end;

ccl_apneeTxt='Consequence apnee ={';
for i = 1:nb_ccl_apnee,
    ccl_apneeTxt=[ccl_apneeTxt,'(',apnee.output.mf(i).name,';',...
                 num2str(ccl_apnee(i)), '), '];
end;

 ccl_apneeTxt=[ccl_apneeTxt(1:end-2), '}'];
 disp(ccl_apneeTxt);