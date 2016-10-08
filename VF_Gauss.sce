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

//[EXO2]
function result = solve_trisup3(A, b)
    sizeMatrixL = size(A, "r");
    sizeMatrixC = size(A, "c");
 
    if(sizeMatrixL <= sizeMatrixC)
      //Lecture de la matrice de bas en haut
      for i=(sizeMatrixC):-1:1
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
                    disp( "Equation non carré  sur-déterminée à la ligne "+ string(i) + " [ b = " + string(b(i)) + "]");
                    result = 0;
                    break;  //La bonne méthode pour sortir d'une fonction
                else
                    disp("Equation sous-déterminée à la ligne " + string(i) );
                    result(i, 1) = 0;
         //           result(:, size(result, "c")+1) = A(:,i);
//                    break;
                end
            else
                //Calcul de xi
                tempTotal = b(i)-tempResult;
                result(i,1) = tempTotal/A(i, i);
            end
        end
    else    //Matrice non-carrée
      //Lecture de la matrice de bas en haut
      for i=(sizeMatrixC):-1:1
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
                    disp( "Equation non carré  sur-déterminée à la ligne "+ string(i) + " [ b = " + string(b(i)) + "]");
                    result = 0;
                    break;  //La bonne manière de sortir d'une fonction
                else
                    disp("Equation non carré sous-déterminée à la ligne "+ string(i));
                    result(i, 1) = 0;
         //           result(:, size(result, "c")+1) = A(:,i);
//                    break;
                end
            else
                //Calcul de xi
                tempTotal = b(i)-tempResult;
                result(i,1) = tempTotal/A(i, i);
            end
        end
        //S'il existe une matrice résultat (1 => a real or complex matrix of double.)
        if (type(result) == 1 ) then
          //Vérif ligne supp'
            pasDerreur = 0;
            for i= sizeMatrixL:-1:sizeMatrixC 
              resultCalcul = 0;
                for j=1:sizeMatrixC
                    resultCalcul = resultCalcul + A(i,j)*result(j);
                end
                if(resultCalcul <> b(i))
                    pasDerreur = 1;
                end
            end
            //Resultat final
            if(pasDerreur == 1)
                result = "Equation pas carré sur-déterminée";
                break;  //La bonne méthode de sortir d'une fonction
            end
        end
    end
endfunction

function result = echelonnage(A)
    
    nbrCol = size(A, "c"); 
    nbrLn = size(A, "r");
    
    // Pivot de Gauss
    for i=1:nbrCol   //Voyage par colonne
        
       // Vérif que l'indice soit non-nul
       [pivot, ln] = ChoixPivot(A, i);
       if(i <= nbrLn)   // Pour s'il n'y rien (0) en A(i,i)
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
    
    result = A;
endfunction

// Parce que je suis un flemmard
function result = myLinsolve(A)
    A = echelonnage(A);
    disp("Le linsolve par Brugiere et Tournois");
    disp( solve_trisup3( A(:,1:(size(A, "c") - 1)), A(:,size(A, "c")) ) );
    disp("Le linsolve par Scilab");
    [res1, res2]= linsolve(A(:,1:(size(A, "c") - 1)), -A(:,size(A, "c"))) ;
    disp(res1, res2);
    result = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"; // #EasterEgg #needToDisplay
endfunction

// Test matrice devoir
//      Matrices valides
M4 = [2 -1 1 1; -6 1 -2 -1; -5 2 -1 0]
//M4 = [1 2 -1 3 22; 2 -1 4 -5 -38; -1 -2 1 2 3; 3 -4 2 5 6]
//      Matrices sur-déterminée
//M4 = [2 3 5 1; 3 -5 2 0; 1 -8 -3 1]
//M4 = [1 -2 1 1 1; 1 -2 1 -1 -1; 1 -2 1 5 5; 1 -2 1 -1 -1; 1 -2 1 5 5]
//      Matrices sous-déerminée/
//M4 = [2 3 5 1; 3 -5 2 0; 5 -2 7 1]

//      The Big Devil Matrix    [8x8]
//M4 = [2. 2. 2. 14. 14. 2. 28. 14. 0; 8. 17. 8. 113. 104. 8. 232. 104. 0; -10. -10. -10. -62. -62. -10. -122. -62. 0; 12. 12. 12. 84. 84. 12. 169. 84. 0; 4. 31. 4. 215. 188. 4. 452. 188. 0; -52. -52. -52. -364. -364. -52. -733. -364. 0; 52. 115. 52. 763. 700. 52. 1568. 700. 0; 80. 80. 80. 544. 544. 80. 1089. 544. 0]

myLinsolve(M4);
