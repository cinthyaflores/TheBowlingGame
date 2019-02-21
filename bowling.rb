puts "* BOWLING GAME *" #Cinthya Flores

$total= 0; #Variable Global para llevar la puntuación total del juego

def init()
    cont=0; #Contar el número de turnos (10 turnos en total) 
    no_bonus = 0; #Contar el número de bonus del jugador: spare = 1 bonus, strike = 2 bonus
    ultimotiro = 2; # Variable para controlar los tiros del utlimo turno (turno 10). Es igual a 2 porque se inicializó 
        #tomando en cuenta que puede que el jugador haga un strike en el turno 10 y tenga derecho a 2 tiros más
    turno(cont, no_bonus, ultimotiro)
end

def turno(cont, no_bonus, ultimotiro) #Llevar el control de los turnos del usuario
    if cont >=10
        fin()
    else
        puts "- - - ROUND #{cont+1} - - - "
        tiro1(cont, no_bonus, ultimotiro)
    end
end

def tiro1(cont, no_bonus, ultimotiro) #Método para el primer tiro del turno
    cont+=1
    primer = Random.rand(0..10); #Para saber cuantos bolos tiró
    puts "1st Try: #{primer}";
    $total = $total + primer
    if no_bonus>=1 #Si el numero de bonus del jugador es mayor o igual a 1, se manda al método bonus
        no_bonus = bonus(primer, no_bonus)
    end
    if primer==10 #Si tiró los 10 bolos es un strike y se le otorgan 2 bonus al jugador
        no_bonus=2
        puts "STRIKE * * "
        if cont<10 #Si el total de turnos es menor a 10 se regresa al inicio del turno
            turno(cont, no_bonus, ultimotiro)
        else #Si no, el turno 10 tiene 3 tiros, y se va al metodo tiro3 para 
                #realizar los 2 tiros restantes dados en la variable ultimotiro
            tiro3(cont, no_bonus, ultimotiro)
        end
    else #Si no tiró los 10 bolos se pasa al segundo intento
        tiro2(primer, cont, no_bonus, ultimotiro)
    end
end

def tiro2 (primer, cont, no_bonus, ultimotiro)
    dif = 10 - primer
    segundo = Random.rand(0..dif)
    puts "2nd Try: #{segundo}";
    $total = $total + segundo
    total_tiro = primer+segundo
    if no_bonus >= 1 #Si el jugador tiene bonus se va al metodo bonus
        no_bonus = bonus(segundo, no_bonus)
    end
    if total_tiro==10 #Si la puntuación del primero y la del segundo tiro = 10 es un SPARE
        puts "SPARE *"
        no_bonus=1 #Se le da 1 bonus al jugador por este tiro
        if cont == 10 #Si es el ultimo turno y el jugador hace spare, puede hacer otro tiro.
            ultimotiro=1; #Solo le va a quedar 1 tiro limpio (con los 10 bolos)
            tiro3(cont, no_bonus, ultimotiro)
        else
            turno(cont, no_bonus, ultimotiro)
        end
    elsif total_tiro<10 && cont == 10 #Si no tiró los 10 en el turno numero 10, su tercer tiro va a tener los bolos restantes
        tiro3restantes(primer, segundo, cont, no_bonus)
    else
        turno(cont, no_bonus, ultimotiro)
    end
        
end

def tiro3(cont, no_bonus, ultimotiro)
    if ultimotiro > 0 #Si al jugador le queda 1 o 2 tiros limpios en su tercer turno entra a este metodo
        ultimotiro-=1 
        tercer = Random.rand(1..10)
        puts "3rd Try: #{tercer}"
        $total = $total + tercer
        if no_bonus >= 1 #Si el jugador tiene bonus se va al metodo bonus
            no_bonus = bonus(tercer, no_bonus)
        end
        if tercer == 10
            puts "STRIKE * *"
            no_bonus=2
            tiro3(cont, no_bonus, ultimotiro)
        elsif ultimotiro>0 #Si no hizo strike y ultimo tiro es mayor a 0, o sea todavia le queda un tiro restante, se va a tiro2
            cont+=1 #Para que en el metodo no entre a las condiciones del tiro 3, ya que si llega a esta instancia ya no le van a quedar más tiros
            tiro2(tercer, cont, no_bonus)
        else
            fin()
        end
    else #Si ya se acabaron los tiros y como ya es el ultimo turno, se va al metodo fin
        fin()
    end
end

def tiro3restantes(primer, segundo, cont, no_bonus)
    dif = 10 - (primer + segundo) 
    tercer = Random.rand(0..dif)
    puts "3rd Try: #{tercer}"
    $total = $total + tercer
    fin()
end

def bonus (tirobonus, no_bonus) #Método para sumar los bonus a la puntuación total
    $total = $total + tirobonus 
    puts "Bonus: +#{tirobonus}"
    no_bonus-=1 #Al contador de no. de bonus se le resta uno y se lo regresa al método 
    return no_bonus
end

def fin()
    puts "* FIN DEL JUEGO * \nPUNTUACIÓN TOTAL: #{$total}"
end

init() #Inicio del programa
