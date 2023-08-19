viveEn(remy, gusteaus).
viveEn(emile, chezMilleBar).
viveEn(django, pizzeriaJeSuis).

sabeCocinar(linguini, ratatouille, 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonAsado, 9).
sabeCocinar(horst, ensaladaRusa, 8).

trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

estaEnMenu(Plato, Restaurant) :-
    sabeCocinar(Cocinero, Plato, _),
    trabajaEn(Cocinero, Restaurant).

cocinaBien(Plato, Cocinero) :-
    sabeCocinar(Cocinero, Plato, Experiencia),
    Experiencia>7.

cocinaBien(Plato, Cocinero) :-
    tutor(Cocinero, Tutor),
    cocinaBien(Plato, Tutor).

tutor(linguini, Tutor) :-
    trabajaEn(linguini, Lugar),
    viveEn(Tutor, Lugar).

tutor(skinner, amelie).

cocinaBien(Plato, remy) :-
    sabeCocinar(_, Plato, _).

chef(Cocinero, Restaurant) :-
    trabajaEn(Cocinero, Restaurant),
    cumpleCondiciones(Cocinero, Restaurant).

cumpleCondiciones(Cocinero, Restaurant) :-
    forall(estaEnMenu(Plato, Restaurant), cocinaBien(Plato, Cocinero)).

cumpleCondiciones(Cocinero, _) :-
    findall(Nivel, sabeCocinar(Cocinero, _, Nivel), Lista),
    sumlist(Lista, Total),
    Total>=20.

encargada(Plato, Persona, Restaurant) :-
    experienciaDe(Plato, Persona, Restaurant, Experiencia),
    forall(experienciaDe(Plato, _, Restaurant, OtraExperiencia),
           Experiencia>=OtraExperiencia).

experienciaDe(Plato, Persona, Restaurant, Experiencia) :-
    sabeCocinar(Persona, Plato, Experiencia),
    trabajaEn(Persona, Restaurant).

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(256)).

platoSaludable(Plato) :-
    plato(Plato, TipoPlato),
    cantCalorias(TipoPlato, Calorias),
    Calorias<75.

cantCalorias(entrada(Ingredientes), TotalCalorias) :-
    length(Ingredientes, Cantidad),
    TotalCalorias is Cantidad*15.

cantCalorias(principal(Guarnicion, Minutos), TotalCalorias) :-
    caloriasGuarnicion(Guarnicion, Cantidad),
    TotalCalorias is 5*Minutos+Cantidad.

cantCalorias(postre(Calorias), Calorias).

caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).

reseniaPositiva(Critico, Restaurant) :-
    not(viveEn(_, Restaurant)),
    criterioCritico(Critico, Restaurant).

criterioCritico(antonEgo, Restaurant) :-
    esEspecialista(ratatouille, Restaurant).

esEspecialista(Plato, Restaurant) :-
    forall(trabajaEn(Cocinero, Restaurant), cocinaBien(Plato, Cocinero)).

criterioCritico(cormillot, Restaurant) :-
    forall(estaEnMenu(Plato, Restaurant), platoSaludable(Plato)).

criterioCritico(martiniano, Restaurant) :-
    chef(Cocinero, Restaurant),
    not(chef(otroCocinero, Restaurant)),
    otroCocinero\=Cocinero.

criterioCritico(gordonRamsey).