% https://docs.google.com/document/d/1AW3tONx___GPN0Pt6jTrb2q4DLT-YsufBIBbvrTI8Ic/edit
% https://docs.google.com/document/d/1OgAk03lPH0zWo4cpG2fxxNjXpPDPOIHF7hfQXfqeiL0/edit

%% quedaEn(lugar, lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, caba).
quedaEn(caba, argentina).

nacioEn(dani, caba).
nacioEn(alf, caba).
nacioEn(nico, caba).

hizoTarea(dani, tomarExamen(paradigmaLogico, aula522),  fecha(10,8,2022)).
hizoTarea(dani, hacerUnGol(primeraDivision, caba),  fecha(10,8,2022)).
hizoTarea(alf, hacerDiscurso(0, utn),  fecha(11,8,2022)).

nuncaSalioDeCasa(Trabajador):-
  nacioEn(Trabajador, Lugar),
  forall(
    hizoTarea(Trabajador, TipoTarea, _),
    lugarTarea(TipoTarea, Lugar)
    ).

lugarTarea(tomarExamen(_, Lugar), Lugar).
lugarTarea(hacerUnGol(_, Lugar), Lugar).
lugarTarea(hacerDiscurso(_, Lugar), Lugar).

nuncaSalioDeCasaNot(Trabajador):- 
  nacioEn(Trabajador, Lugar),
  not((hizoTareaEnLugar(Trabajador, OtroLugar), OtroLugar \= Lugar)).

hizoTareaEnLugar(Trabajador, Lugar):- 
  hizoTarea(Trabajador, TipoTarea, _),
  lugarTarea(TipoTarea, Lugar).

esEstresante(Tarea):-
  hizoTarea(_, Tarea, _),
  lugarTarea(Tarea, Lugar),
  pertenece(Lugar, argentina),
  cumpleCondicionEstresante(Tarea).

pertenece(Lugar, OtroLugar):- quedaEn(Lugar, OtroLugar).
pertenece(Lugar, OtroLugar):- quedaEn(Lugar, Lugar2), pertenece(Lugar2, OtroLugar).

cumpleCondicionEstresante(tomarExamen(Tema, _)):-
  esComplejo(Tema).

cumpleCondicionEstresante(hacerDiscurso(Cantidad, _)):-
  Cantidad < 3000.

cumpleCondicionEstresante(hacerUnGol(_, _)).

esComplejo(paradigmaLogico).
esComplejo(analisisMatematico).

% Se quiere averiguar a quién darle el premio "estrés de todos los tiempos",
% por ser la persona que más tareas estresantes ha realizado.

calificacion(Trabajador,Calificacion):-
  persona(Trabajador),
  calificarSegun(Trabajador, Calificacion).

persona(Persona):- hizoTarea(Persona, _, _).

calificarSegun(Persona, zen):- 
  forall(
    hizoTarea(Persona, Tarea, _),
    not(esEstresante(Tarea))
    ).

calificarSegun(Persona, locos):- 
  forall(
    hizoTarea(Persona, Tarea, fecha(_,_, 2022)),
    esEstresante(Tarea)
    ).

calificarSegun(Persona, sabios):-
  realizoTareaEstresante(Persona, Tarea),
  not((realizoTareaEstresante(Persona, OtraTarea), Tarea \= OtraTarea)).

realizoTareaEstresante(Persona, Tarea):-
  hizoTarea(Persona, Tarea, _),
  esEstresante(Tarea).


masChapita(Persona):-
  cantidadTareaEstresante(Persona, Cantidad),
  forall(cantidadTareaEstresante(_, OtraCantidad), Cantidad>=OtraCantidad).

cantidadTareaEstresante(Persona, Cantidad):- 
  persona(Persona),
  findall(Tarea, realizoTareaEstresante(Persona, Tarea), ListaTareas),
  length(ListaTareas, Cantidad).
