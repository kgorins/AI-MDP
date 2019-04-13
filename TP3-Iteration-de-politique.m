%% Par iteration de politique

FixedNodes=[10,11,5]; % cases dont la politique est fixe et nulle

% initialisation arbitraire de la politique
Politique = ...;
Politique(FixedNodes) = ...;

% affichage de la politique initiale
AffichePolitique(Politique,Plan,Map_plan2node),title('Politique initiale');

% valeur d'escompte
escompte = ...;
    
% structure pour stocker les resultats de chaque action
CasesPossibles = cell(1,length(A)); 

% vecteur pour stocker le gain d'utilite associe à chaque action
GainU = zeros(1,length(A));


% mise-à-jour iterative de la politique
%######## A CODER ##########%
%
% Pour j de 1 à NbrMaxIterations ou jusqu'à ce que ||Politique(:,j+1)-Politique(:,j)||<epsilon
%     Determiner les utilites associees à la politique courante : {
%         - remplir les coefficients de la matrice M telle que M*U=R (avec U le vecteur colonne des utilites et R le vecteur colonne des recompences)
%         - determiner U par inversion de matrice (fonction inv() dans Matlab). }
%     Afficher les nouvelles utilites : AfficheUtilites(reshape(U,RowMax,ColMax),Map_plan2node,j);
%
%     Pour chaque case i ...
%         Determiner la nouvelle politique Politique(i,j+1) : {
%             - si la politique de la case doit rester fixe, on conserve la precedente.
%             - sinon : pour chaque action a, stocker les voisins qui peuvent être atteints dans CasesPossibles{a}
%                       puis calculer l'utilite potentielle U_temp(a) engendree pour chaque action a
%                       puis mettre-à-jour (SI NECESSAIRE) la politique Politique(i,j+1) avec l'action associee au U_temp maximal. }
%     Afficher la nouvelle politique : AffichePolitique(Politique(:,end),Plan,Map_plan2node), title(['Politique temporaire : iteration',num2str(j)]), pause(1);
%
%###########################%
