% Par iteration de politique
NbrMaxIterations = 20

FixedNodes=[10,11,5]; % cases dont la politique est fixe et nulle

% initialisation arbitraire de la politique
Politique = [1 1 2 3 4 1 1 2 3 4 1 1 2];
Politique(FixedNodes) = 0;

% affichage de la politique initiale
AffichePolitique(Politique,Plan,Map_plan2node),title('Politique initiale');

% valeur d'escompte
escompte = 1;
    
% structure pour stocker les resultats de chaque action
CasesPossibles = cell(1,length(A)); 

% vecteur pour stocker le gain d'utilite associe à chaque action
U_temp = zeros(1,length(A));

U = zeros(nbr,1);
U(:,1)=R(:);
U = reshape(U,RowMax,ColMax)
M = zeros(nbr,1);

%% mise-à-jour iterative de la politique
for j = 1 : NbrMaxIterations-1
    M = R\U; % La matrice M telle que M*U=R 
    U = inv(M)
    AfficheUtilites(U,Map_plan2node,j);

    for  i = 1:nbr % s cases
        if ismember(i,FixedNodes) % si la politique doit rester fixe, on conserve la precedente.
            Politique(i,j+1) = Politique(i,j); 
        else
            for a = 1:length(A)
                for h = 1:nbr % calculer l'utilite potentielle
                    U_temp(a) = U_temp(a) + T( i, a, h ) * U(h,i);
                end
            end
            Politique(i,j+1)=  escompte * max(U_temp);

            %Afficher la nouvelle politique : 
            AffichePolitique(Politique(:,end),Plan,Map_plan2node), title(['Politique temporaire : iteration',num2str(j)]), pause(1);

            if norm(Politique(:,j+1)-Politique(:,j)) < epsilon 
                break; 
            end
        end
    end
end





