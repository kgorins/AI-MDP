% Par iteration de valeur

% S: Position de l’agent sur la grille, nb cases
% A: Actions de l’agent
% T: Fonction de Transition (etat debut, action genere, etat depart)
% R: Recompense

epsilon = 0.01;
NbrMaxIterations = 20;

Map_plan2node = reshape((1:nbr),RowMax,ColMax);

FixedNodes=[5,10,11]; % cases dont les utilites sont fixes durant l'algorithme

% initialisation des utilites
U = zeros(nbr,NbrMaxIterations);
U(:,1)=R(:);


% affichage des utilites initiales
AfficheUtilites(reshape(U(:,end),RowMax,ColMax),Map_plan2node,0); pause();

% valeur d'escompte
escompte = 1; % gamma


for j = 1 : NbrMaxIterations-1
    for  i = 1:nbr % s cases
        % si l'utilite de la case doit rester fixe, on conserve la precedente
        if ismember(i,FixedNodes)
            U(i,j+1) = U(i,j); 
        else
            GainU = zeros(1,length(A)); % vecteur pour stocker le gain d'utilite associe à chaque action
            % puis calculer le gain potentiel d'utilite GainU(a) engendre pour chaque action a
            for a = 1:length(A)
                for h = 1:nbr
                    GainU(a) = GainU(a) + T( i, a, h ) * U(h,i);
                end
            end
            % puis mettre à jour l'utilite U(i,j+1) de la case i en considerant l'action offrant l'utilite maximale}  
            U(i,j+1)= R(i)+ escompte * max(GainU);

            % affichage de l'evolution des utilites en fonction des iterations
            AfficheUtilites(reshape(U(:,j),RowMax,ColMax),Map_plan2node,j); pause(0.01);
        end
    end
    if norm(U(:,j+1)-U(:,j)) < epsilon && j>12
        disp ('Done');
        break; 
    end
end

% Recherche de la politique optimale

GainU = zeros(1,length(A));

Uf = U(:,j); % prise en compte des dernieres valeurs d'utilite

% recherche de la politique optimale pour chaque case
for  i = 1:nbr % s cases
     if ismember(i,FixedNodes)
         Politique(i) = 0; % si la case a une utilite fixe, Politique(i)=0;
     else
        GainU = zeros(1,length(A));
        a_best = -1;
        for a = 1:length(A)
            % Calculer le gain potentiel d'utilite GainU(a) engendre pour chaque action a
            for h = 1: nbr
                GainU(a) = GainU(a) + T( i, a, h ) * Uf(h);  
            end
            % Determiner l'action  associee au gain d'utilite maximum  
        end
        a_best = find(GainU==max(GainU));
        Politique(i) = a_best;
    end
end

% affichage de la politique
AffichePolitique(Politique,Plan,Map_plan2node);
