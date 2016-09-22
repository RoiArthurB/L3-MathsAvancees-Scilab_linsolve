function result = solve_trisup3(A, b)
    sizeMatrixL = size(A, "r");
    sizeMatrixC = size(A, "c");
    
    if(sizeMatrixL == sizeMatrixC)
      //Lecture de la matrice de bas en haut
      for i=(sizeMatrixL):-1:1
            //Variable tampon
            tempResult = 0;
            //Lecture de la ligne de droite à gauche
            for j=(sizeMatrixC):-1:1
                //Quand on arrive sur la diagonale
                if(j>i)
                    tempResult = tempResult + (A(i, j)*result(j));
                else
                    //Sortie de la boucle colonne
                    continue(1);
                end
            end
            //Si xi est indéterminable
            if( A(i,i) == 0)
                if( b(i) <> 0)
                    result = "Equation sur-déterminée";
                    break;  //La bonne méthode de sortir d'une fonction
                else
                    result = "Equation sous-déterminée";
                    break;
                end
            else
                //Calcul de xi
                tempTotal = b(i)-tempResult;
                result(i) = tempTotal/A(i, i);
            end
        end
    else
        result = "La première matrice n''est pas carrée"
    end
endfunction

M3 = [3 2 1; 0 -1 -2; 0 0 5];
M3result = [2; -1; 3];

disp( solve_trisup3(M3, M3result) );
