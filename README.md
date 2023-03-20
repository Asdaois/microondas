# Microondas
Diseñe un TIMER programable. 
Funcionamiento: 
- [ ] Teclado matricial
  - [ ] Programa Minutos y Segundos, se agregan de manera cíclica, es decir que si se presionan 4 números por lo menos 1234, si se presiona 5, ahora se mostrara 2435
  - [ ] Start/Pausa (en la misma tecla). 
    - [ ] Si esta pausado, inicia el conteo descendente
    - [ ] Si esta corriendo, detiene el conteo descendiente
  - [ ] Reset
    - [ ] si esta pausado, se pone el timer en 0   
    - [ ] si esta corriendo
- [ ] Para simular el horno 
  - [ ] Motor DC encendido mientras temporizador esta en ON 
  - [ ] Buzzer que generará 3 beep después de agotado el Tiempo. 
- [ ] Se debe observar en los displays el tiempo que se esta ajustando tal cual lo hace el horno comercial 
- [ ] Una vez establecido el tiempo se espera por cualquier orden
  - [ ] Start/Pausa
  - [ ] Reset
  - [ ] reajustar el tiempo.
- [ ] El conteo será descendente
  - [ ] Partiendo del valor ajustado hasta cero 
    - [ ] detiene el motor
    - [ ] Se generan los 3 beep. 
- [ ] Hardware
  - [ ] Se usaran 4 display.
  - [ ] Un motor
  - [ ] Un speaker
Observación: Para todos los casos en modo ajuste los datos deberán estar presente en los displays; en otras 
palabras, estos no deben apagarse mientras se ajusta los datos.

## Iteraciones
- [X] Primera
  - [X] implementar display
  - [X] implementar teclado matricial
  - [X] implementar asignarles números del teclado al led

- [ ] Segunda
  - [ ] guardar el valor que se presione en el teclado, de manera rotativa
