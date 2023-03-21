# Microondas
Diseñe un TIMER programable. 
Funcionamiento: 
- [X] Teclado matricial
  - [X] Programa Minutos y Segundos, se agregan de manera cíclica, es decir que si se presionan 4 números por lo menos 1234, si se presiona 5, ahora se mostrara 2435
  - [X] Start/Pausa (en la misma tecla). 
    - [X] Si esta pausado, inicia el conteo descendente
    - [X] Si esta corriendo, detiene el conteo descendiente
  - [X] Reset
    - [X] si esta pausado, se pone el timer en 0   
    - [X] si esta corriendo
- [ ] Para simular el horno 
  - [X] Motor DC encendido mientras temporizador esta en ON 
  - [ ] Buzzer que generará 3 beep después de agotado el Tiempo. 
- [X] Se debe observar en los displays el tiempo que se esta ajustando tal cual lo hace el horno comercial 
- [X] Una vez establecido el tiempo se espera por cualquier orden
  - [X] Start/Pausa
  - [X] Reset
  - [X] reajustar el tiempo.
- [ ] El conteo será descendente
  - [X] Partiendo del valor ajustado hasta cero 
    - [X] detiene el motor
    - [ ] Se generan los 3 beep. 
- [X] Hardware
  - [X] Se usaran 4 display.
  - [X] Un motor
  - [X] Un speaker
Observación: Para todos los casos en modo ajuste los datos deberán estar presente en los displays; en otras 
palabras, estos no deben apagarse mientras se ajusta los datos.

## Iteraciones
- [X] Primera
  - [X] implementar display
  - [X] implementar teclado matricial
  - [X] implementar asignarles números del teclado al led

- [X] Segunda
  - [X] guardar el valor que se presione en el teclado, de manera rotativa

- [X] Tercera
  - [X] Cuando se presione start Aplicar temporizador de manera regresiva 
  - [X] Cuando se presione reset reiniciar a valores 0000 