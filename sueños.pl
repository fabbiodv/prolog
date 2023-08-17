cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

%diego no cree en nadie.
quiere(gabriel, ganarLoteria([5, 9])).
quiere(juan, futbolista(arsenal)).
quiere(juan, cantante(100000)).
quiere(macarena, cantante(10000)).

persona(Persona) :-
    quiere(Persona, _).

esAmbiciosa(Persona) :-
    persona(Persona),
    sumaTotalDificultades(Persona, Total),
    Total>20.

sumaTotalDificultades(Persona, Total) :-
    findall(Dificultad, dificultad(Persona, Dificultad), ListaDificultades),
    sumlist(ListaDificultades, Total).

dificultad(Persona, Dificultad) :-
    quiere(Persona, Suenio),
    nivelDificultad(Suenio, Dificultad).

nivelDificultad(cantante(Discos), 6) :-
    Discos>500000.
nivelDificultad(cantante(Discos), 4) :-
    Discos=<500000.
nivelDificultad(ganarLoteria(Numeros), Dificultad) :-
    length(Numeros, Cant),
    Dificultad is Cant*10.
nivelDificultad(futbolista(Equipo), 3) :-
    equipoChico(Equipo).

nivelDificultad(futbolista(Equipo), 16) :-
    not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).


tieneQuimica(Personaje, Persona) :-
    cree(Persona, Personaje),
    verificarCondicion(Persona, Personaje).

verificarCondicion(Persona, campanita) :-
    dificultad(Persona, Dificultad),
    Dificultad<5.

verificarCondicion(Persona, Personaje) :-
    Personaje\=campanita,
    todosLosSueniosPuros(Persona),
    not(esAmbiciosa(Persona)).

  
  todosLosSueniosPuros(Persona) :-
    forall(quiere(Persona, Suenio), puro(Suenio)).
  
  puro(futbolista(_)).

puro(cantante(Discos)) :-
    Discos<200000. 
  
  
  puedeAlegrar(Personaje, Persona) :-
    quiere(Persona, _),
    tieneQuimica(Personaje, Persona),
    cumpleCondicionesParaAlegrar(Personaje).

cumpleCondicionesParaAlegrar(Personaje) :-
    not(enfermo(Personaje)).

cumpleCondicionesParaAlegrar(Personaje) :-
    backup(Personaje, Backup),
    cumpleCondicionesParaAlegrar(Backup).

backup(Personaje, OtroPersonaje) :-
    esAmigo(Personaje, OtroPersonaje).

backup(Personaje, OtroPersonaje) :-
    esAmigo(Personaje, Backup),
    backup(Backup, OtroPersonaje).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).

esAmigo(campanita, reyesMagos).
esAmigo(campanita, conejoDePascua).
esAmigo(conejoDePascua, cavenaghi).
