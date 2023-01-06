
irr_insomnie =[]
insomnie =readfis ('SF5Insomnie.fis');
prompt = {'Nombre de réveils nocturnes (0 à 10):',...
    'Temps avant de s endormir(0 à 40 min):',...
    'Ronflement (0 à 100 db):'};

def ={'0','10','0'};
dlgtitle='Test insomnie';
lineNo=1;
answer=inputdlg(prompt, dlgtitle, lineNo, def);
if isempty(answer),
    disp('Action annulée');
    return;
end;

nb_reveils = str2num(answer{1});
temps = str2num(answer{2});
ronflement = str2num(answer{3});

[sortie, irr_insomnie, orr, arr] = evalfis([nb_reveils, temps,ronflement], insomnie);
decl_insomnie = min(irr_insomnie, [], 2);

nb_regles_insomnie = length(insomnie.rule);
nb_ccl_insomnie = length(insomnie.output.mf);
ccl_insomnie = zeros(1,nb_ccl_insomnie);

for i = 1:nb_regles_insomnie,
    ccl_insomnie(insomnie.rule(i).consequent)=max(ccl_insomnie(insomnie.rule(i).consequent),...
        decl_insomnie(i));
end;

ccl_insomnieTxt='Consequence insomnie ={';
for i = 1:nb_ccl_insomnie,
    ccl_insomnieTxt=[ccl_insomnieTxt,'(',insomnie.output.mf(i).name,';',...
                 num2str(ccl_insomnie(i)), '), '];
end;

 ccl_insomnieTxt=[ccl_insomnieTxt(1:end-2), '}'];
 disp(ccl_insomnieTxt);