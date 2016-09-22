function result = solve_diag_v1(A, b)
    //Vérifie que A est carré et b est solution de A
    if size(A, "r") == size(A, "c") then
        if size(A, "r") == size(b, "r") then
          //max i = nombre de ligne de A
            for i=1:size(A, "r")
                result(i) = b(i)/A(i, i)
            end
        else
            result = "b ne peut pas être une solution de A"
        end
    else
        result = "La première matrice n''est pas carrée"
    end
endfunction;

// Pour les système sous-déterminés
function result = solve_diag_v2(A, b)
    if size(A, "r") == size(A, "c") then
        if size(A, "r") == size(b, "r") then
            for i=1:size(A, "r")
                if(A(i,i) == 0)
                    result = "Equation sous-déterminée"
                    break;
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


// Pour les système sur/sous-déterminés
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

// Test de la première matrice
M1 = [3 0; 0 -1];
M1result = [2; -1];

disp( solve_diag(M1, M1result), "La première matrice : ");

// Test de la seconde matrice

M2 = [1 0 0; 0 5 0; 0 0 -1];
M2result = [-2; 3; 1];

disp( solve_diag(M2, M2result), "La seconde matrice : ");

// Test de la matrice random
indice = 10;
Mrandom = rand(indice, indice);
MrandomResult = rand(indice, 1);

disp(solve_diag(Mrandom, MrandomResult), "Résultat de la matrice random : ", MrandomResult, "b", Mrandom, "A")
