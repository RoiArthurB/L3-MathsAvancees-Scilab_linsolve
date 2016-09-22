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

// Test matrice devoir
M4 = [2 -1 1 1; -6 1 -2 -1; -5 2 -1 0]
disp( ChoixPivot(M4, 4) )

// Test matrice random
indice = 100
Mrandom2 = rand(indice, indice)

disp( ChoixPivot(Mrandom2, 5) )
