% Medios de Transporte
% Se tiene una base de conocimiento en el que el predicado transporte/2 
% relaciona a una persona con el medio de transporte que utiliza para viajar.

transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).

% 1) Realizar las consultas que permita conocer quiénes son los que vienen en auto de marca fiat.
% transporte(Quien, auto(_, fiat, _)).
% 2) Definir tardaMucho/1, se verifica si la persona viene caminando o viene en auto y maneja lento. ( debe ser totalmente inversible).
% 3) ¿ Quiénes son las personas que viajan en colectivo?.

tardaMucho(Persona):-
  transporte(Persona, camina).

tardaMucho(Persona):-
  manejaLento(Persona),
  transporte(Persona, auto(_,_,_)).

viajanEnColectivo(Persona):-
  transporte(Persona, Colectivo),
  esColectivo(Colectivo).

esColectivo(colectivo(_)).
esColectivo(colectivo(_,_)).

  