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

function result = ChoixPivot(A, col)
    //Boolean pour savoir si un résultat a été trouvé ou non
    fini = %f;
    for i=col:size(A, "r")
        if (A(i,col) <> 0) then
            //Retourne le premier résultat trouvé non nul
            result = A(i,col);
            fini = %t;
            break;  //Fin de la fonction -> optimisation
        end
    end
    // Y a-t-il eu un résultat de trouvé?
    if (fini == %f) then
        result = 0;
    end
endfunction

function result = CombinaisonLineaire(A, ln1, ln2, l)
    ligneAAjouter = A(ln1, :);
    result = A;
    result(ln2, :) = result(ln2, :) + ligneAAjouter*l;
endfunction


// Test matrice devoir
M4 = [2 -1 1 1; -6 1 -2 -1; -5 2 -1 0]

// Fonctionne pour la première col!!
for j=2:size(M4, "r")
    M4 = CombinaisonLineaire(M4, 1, j, abs( M4(j, 1)/M4(1,1) ) )
end

for j=3:size(M4, "r")
    M4 = CombinaisonLineaire(M4, 2, j, abs( M4(j, 2)/M4(2,2) ) )
end


// FAUX!!
//for i=1:size(M4, "c")
//  for j=2:size(M4, "r")
//        M4 = CombinaisonLineaire(M4, i, j, abs( M4(j, i)/M4(i,i) ) )
//    end
//end

disp( M4 )




