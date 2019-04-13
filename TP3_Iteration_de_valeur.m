% Par iteration de valeur

% S: Position de l’agent sur la grille, nb cases
% A: Actions de l’agent
% T: Fonction de Transition (etat debut, action genere, etat depart)
% R: Recompense

epsilon = 0.01;
NbrMaxIterations = 30;

Map_plan2node = reshape((1:nbr),RowMax,ColMax);

FixedNodes=[5,10,11]; % cases dont les utilites sont fixes durant l'algorithme

% initialisation des utilites
U = zeros(nbr,NbrMaxIterations);
for k = 1 : NbrMaxIterations
     U(:,k)=R(:);
end

% affichage des utilites initiales
AfficheUtilites(reshape(U(:,end),RowMax,ColMax),Map_plan2node,0); pause();

% valeur d'escompte
escompte = 1; % gamma

% structure pour stocker les resultats de chaque action
CasesPossibles = cell(1,length(A));

% vecteur pour stocker le gain d'utilite associe à chaque action
GainU = zeros(1,length(A));

% mise-à-jour iterative des valeurs d'utilite
 for j = 1 : NbrMaxIterations-1
      for  i = 1:nbr % s cases
          
          % si l'utilite de la case doit rester fixe, on conserve la precedente
          if   abs(U(i,j)) > 1
             U(i,j+1) = U(i,j); 
          else
              % puis calculer le gain potentiel d'utilite GainU(a) engendre pour chaque action a
              for a = 1:length(A)
                    for h = 1: nbr % On calcule pour tout les voisins
                        %disp('Uh'); disp (U(h));
                        t = T( i, a, h )* U(h);
                        %disp('t');disp(t);
                        if t ~= 0
                            GainU(a) = GainU(a) + t;
                        end
                    end
              end
                %GainU
              % puis mettre à jour l'utilite U(i,j+1) de la case i en considerant l'action offrant l'utilite maximale}  
              U(i,j+1)= R(i)+ escompte * max(GainU);

              % affichage de l'evolution des utilites en fonction des iterations
              AfficheUtilites(reshape(U(:,j),RowMax,ColMax),Map_plan2node,j); pause(0.01);

                if norm(U(:,j+1)-U(:,j)) < epsilon 
                    break; 
                end
          end
      end
 end


%% Recherche de la politique optimale

Uf = U(:,end); % prise en compte des dernieres valeurs d'utilite

% recherche de la politique optimale pour chaque case
for  i = 1:nbr % s cases
     if Plan(i) == -1  
         Politique(i) = 0; % si la case a une utilite fixe, Politique(i)=0;
     else
        a_best = GainU(a);
        for a = 1:length(A)
            % Calculer le gain potentiel d'utilite GainU(a) engendre pour chaque action a
            for h = 1: nbr
                GainU(a) = GainU(a) + T( i, a, h ) * Uf(h);
            end
            % Determiner l'action  associee au gain d'utilite maximum
            if GainU(a)>a_best a_best = GainU(a); end
        end
        Politique(i) = a_best;
    end
end

Politique
% affichage de la politique
AffichePolitique(Politique,Plan,Map_plan2node);
