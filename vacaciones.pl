% ¿ Cómo elegir dónde ir de vacaciones ?.

% Armar un programa que nos permita conocer donde puede ir de vacaciones una persona. Se conoce la siguiente información:
 
%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).

% Desarrollar los siguientes predicados totalmente inversibles:

% puedeIr/3, relaciona una persona, con el lugar y el alojamiento.
% Para que una persona pueda alojarse en un lugar, debe alcanzarle el dinero disponible y cumplirse las siguientes condiciones.
% • Si es un hotel la cantidad de estrellas debe ser mayor a 3.
% • Si es una casa debe tener garaje.
% • Si es una quinta debe tener pileta.
% • Y en caso de una carpa solo le debe alcanzar el dinero.

puedeIr(Persona, Lugar, Alojamiento):-
  puedeGastar(Persona, CantidadDeDias, DineroDisponible),
  lugar(Lugar, Alojamiento),
  cumpleCondiciones(Alojamiento, MontoDiario), DineroDisponible >= CantidadDeDias * MontoDiario.

%Polimorfico porque alojamiento tiene distintos tipos
%Si traigo otro alojamiento tengo que agregar otra funcion cumpleCondiciones
cumpleCondiciones(hotel(_, Estrellas, MontoDia), MontoDia):- Estrellas > 3.
cumpleCondiciones(casa(garage, MontoDia), MontoDia).
cumpleCondiciones(quinta(_, pileta, MontoDia), MontoDia).
cumpleCondiciones(carpa(MontoDia), MontoDia).

% 2) Conocer las personas que pueden ir a cualquier lugar ya que en todos los lugares tienen al menos un alojamiento en donde le alcanza el dinero para ir.

puedeIrACualquierLugar(Persona):- 
  persona(Persona),
  forall(lugar(Lugar,_), puedeIr(Persona, Lugar, _)).
  
persona(Persona):-
  puedeGastar(Persona, _, _).

%Me da false por principio de universo cerrado

