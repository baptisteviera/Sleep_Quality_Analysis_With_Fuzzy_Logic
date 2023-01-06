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
    
    
    
    
    
    