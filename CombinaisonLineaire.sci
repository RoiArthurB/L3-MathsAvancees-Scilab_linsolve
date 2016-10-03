function result = CombinaisonLineaire(A, ln1, ln2, l)
    ligneAAjouter = A(ln1, :);
    result = A;
    result(ln2, :) = result(ln2, :) - ligneAAjouter*l;
endfunction

// Test matrice devoir
M4 = [2 -1 1 1; -6 1 -2 -1; -5 2 -1 0]
disp( CombinaisonLineaire(M4, 1, 2, 3) )
