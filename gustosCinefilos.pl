genero(titanic, drama).
genero(gilbertGrape, drama).
genero(atrapameSiPuedes, comedia).
genero(ironMan, accion).
genero(rapidoYFurioso, accion).
genero(elProfesional, drama).

gusta(belen, titanic).
gusta(belen, gilbertGrape).
gusta(belen, elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).


soloLegGustaPeliculaDeGenero(Persona, Genero) :-
    gustaPelicula(Persona),
    generoPelicula(Genero),
    forall(gusta(Persona, Pelicula), genero(Pelicula, Genero)).
  %Para todos los que cumplan esta condicion tiene que cumplirse esta condicion
gustaPelicula(Persona) :-
    gusta(Persona, _).

generoPelicula(Genero) :-
    genero(_, Genero).

peliculasQueLeGustaPorGenero(Persona, Genero, Peliculas) :-
    gustaPelicula(Persona),
    generoPelicula(Genero),
    findall(Pelicula,
            ( gusta(Persona, Pelicula),
              genero(Pelicula, Genero)
            ),
            Peliculas).

sublista([], []).
sublista([Cab|Cola], [Cab|Resto]) :-
    sublista(Cola, Resto).
sublista([_|Cola], Lista) :-
    sublista(Cola, Lista).
