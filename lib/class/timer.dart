import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import './timermodel.dart';

class CountDownTimer {
  int shortBreak = 5;
  int longBreak = 20;
  int work = 30;
  double radius = 1.0;
  bool _isSctive = true;
  Timer? time;
  Duration _time = Duration();
  Duration _fullTime = Duration();

  void startWork() async {
    //es una especie de future
    await readSettings(); //esta funcio lo que hace es obtener los valores del sharepreferencs que contiene los datos guardadso en el dispocitivo
    radius = 1.0; //el radio deve tener valores double  de 0 a 1 ejemplo 0.9
    _time = Duration(
        minutes: this.work, seconds: 0); //gurada el tiempo que debe durar
    _fullTime = _time;
  }

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    //cada segundo se resta un segundo al tiempo total y el radio se actualiza cada segundo
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (this._isSctive) {
        //si esta activo se resta un segundo
        _time = _time - Duration(seconds: 1);
        radius = _time.inSeconds / _fullTime.inSeconds; // inSeconds;
        // print(radius);
        if (_time.inSeconds <= 0) {
          //si el tiempo llega a 0 se desactiva el conteo
          _isSctive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time,
          radius); //regresamos un objeto TimerModel que contiene el tiempo y el radio para poder acceder los datos desde el homepage
    });
  }

  void stopTimer() {
    this._isSctive = false;
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      this._isSctive = true;
    }
  }

  void startBreak(bool inShort) {
     radius = 1;
    _time = Duration(minutes: (inShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  Future readSettings() async {
    //se obtine un objeto de sharedpreferences que sirve para obtener los valores guardados de los tiempos
    SharedPreferences prefs = await SharedPreferences.getInstance();

    work = (prefs.getInt('workTime') == null) ? 30 : prefs.getInt('workTime')!;
    shortBreak =
        prefs.getInt('shortBreak') == null ? 30 : prefs.getInt('shortBreak')!;
    longBreak =
        prefs.getInt('longBreak') == null ? 30 : prefs.getInt('longBreak')!;
  }
}
