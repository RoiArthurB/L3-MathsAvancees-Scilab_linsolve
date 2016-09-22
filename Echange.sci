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

// Test matrice devoir
M4 = [2 -1 1 1; -6 1 -2 -1; -5 2 -1 0]
disp( Echange(M4, 1, 2) )

// Test matrice random
indice = 100
Mrandom2 = rand(indice, indice)

disp( Echange(Mrandom2, 1, 5) )
