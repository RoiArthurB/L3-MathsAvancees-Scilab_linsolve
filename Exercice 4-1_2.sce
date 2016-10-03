function result = Echange(A, ln1, ln2)
    nbrCol = size(A, "c");
    for i=1:size(A, "r")
        for j=1:nbrCol
            if(i == ln1)
                result(i,j) = A(ln2,j);
            elseif (i == ln2 )
                result(i,j) = A(ln1,j);
            else
                result(i,j) = A(i,j);
            end
        end
    end
endfunction

function [result, ln] = ChoixPivot(A, col)
    //Boolean pour savoir si un résultat a été trouvé ou non
    fini = %f;
    for i=col:size(A, "r")
        if (A(i,col) <> 0) then
            //Retourne le premier résultat trouvé non nul
            result = A(i,col);
            ln = i;
            fini = %t;
            break;  //Fin de la fonction -> optimisation
        end
    end
    // Y a-t-il eu un résultat de trouvé?
    if (fini == %f) then
        result = 0; ln = 1;
    end
endfunction

function result = CombinaisonLineaire(A, ln1, ln2, l)
    ligneAAjouter = A(ln1, :);
    result = A;
    result(ln2, :) = result(ln2, :) - ligneAAjouter*l;
endfunction

// Pour les système sur/sous-déterminés [EXO1]
function result = solve_diag(A, b)
    if size(A, "r") == size(A, "c") then
        if size(A, "r") == size(b, "r") then
            for i=1:size(A, "r")
                if(A(i,i) == 0)
                    if(b(i) <> 0)
                        result = "Equation sur-déterminée";
                        break;
                    else
                        result = "Equation sous-déterminée";
                        break;
                    end
                else
                    result(i) = b(i)/A(i, i)
                end
            end
        else
            result = "b ne peut pas être une solution de A"
        end
    else
        result = "La première matrice n''est pas carrée"
    end
endfunction;

function result = echelonnage(A)
    
    nbrCol = size(A, "c"); nbrLn = size(A, "r");
    
    
    // Pivot de Gauss
    for i=1:nbrCol   //Voyage par colonne
        
       // Vérif que l'indice soit non-nul
       [pivot, ln] = ChoixPivot(A, i);
       if(i <= nbrLn)   // Pour s'il n'y a pas de A(i,i)
          if(pivot <> A(i,i))   //Vérif si le pivot est sur une autre ligne
             A = Echange(A, i, ln); //Si oui
          end
       end
    
       //Pivot de Gauss
       if(pivot <> 0)   //Pour éviter la division par zéro (la colonne en est constituée)
           for j=(1+i):nbrLn //Voyage par ligne
              A = CombinaisonLineaire(A, i, j, ( A(j, i)/A(i,i) ) ) //Echelonne
           end
        end
    end
    
    //Récupère la pointe basse du triangle
    if(nbrCol > nbrLn)
        diagBas = nbrLn;
    else
        diagBas = nbrCol
    end
    
    //Jordan
    for i=diagBas:-1:1  //Balayage par colonne
        if ( A(i,i) <> 0 ) then //Pour éviter la division par zéro
            // j = i-1 -> toutes les lignes du triangle sauf la diagonale
            for j=(i-1):-1:1    //Balayage par ligne
                A = CombinaisonLineaire(A, i, j, (A(j,i)/A(i,i)));
            end
        end
    end
    
    result = A;
endfunction

// Parce que je suis un flemmard
function result = myLinsolve(A)
    A = echelonnage(A);
    result = solve_diag( A(:,1:(size(A, "c") - 1)), A(:,size(A, "c")) )
endfunction

// Test matrice devoir
// M4 = [2 -1 1 1; -6 1 -2 -1; -5 2 -1 0]
M4 = [1 2 -1 3 22; 2 -1 4 -5 -38; -1 -2 1 2 3; 3 -4 2 5 6]
//M4 = [2 3 5 1; 3 -5 2 0; 1 -8 -3 1]
//M4 = [2 3 5 1; 3 -5 2 0; 5 -2 7 1]

disp( myLinsolve(M4) )

disp( linsolve(M4(:,1:4), -M4(:,5)) )


