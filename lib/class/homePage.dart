import 'package:cap_3/class/settings.dart';
import 'package:cap_3/class/timermodel.dart';
import 'package:flutter/material.dart';
import 'package:cap_3/class/button.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cap_3/class/timer.dart';

//https://github.com/PacktPublishing/Flutter-Projects/blob/master/ch_03/lib/main.dart
enum SampleItem { itemOne, itemTwo, itemThree }

class TimerHomePage extends StatelessWidget {
  double defaultPadding = 15.0;
  double width = 0.0;
  double availableWidth = 0.0;

  final CountDownTimer timer = CountDownTimer();// creo un objeto del CountDownTimer
  var selectedItem = '';
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    timer.startWork();
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("app 3"),
        actions: [
          PopupMenuButton<SampleItem>(
            icon: Image.network(
                "https://img.freepik.com/vector-gratis/panda-lindo-trabajando-ilustracion-icono-vector-dibujos-animados-portatil-concepto-icono-tecnologia-animal-aislado-vector-premium-estilo-dibujos-animados-plana_138676-3487.jpg?w=740&t=st=1678500594~exp=1678501194~hmac=9e315837a45a01bd509aa3cbb2d176b43f17b7ed81d5f05558932093a96cf34f"),
            initialValue: selectedMenu,
            color: Colors.white,
            // Callback that sets the selected popup menu item.
            onSelected: (SampleItem item) {
              selectedMenu = item;
              if (item.index == 0) {
                goToSettings(context);
              }
              print("cambio " + item.index.toString());
            },

            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: Text('Item 1'),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: Text('Item 2'),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: Text('Item 3'),
              ),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constrains) {
        availableWidth = constrains.maxWidth;
        return (Column(
          children: [
            fila1(),
            Expanded(child: circ3()),
            fila2(),
            SizedBox(
              width: 1.0,
              height: 2.0,
            )
          ],
        ));
      }),
    );
  }

  void goToSettings(BuildContext context) {
    //metodo que lleva a otra pantalla
    print('in gotoSettings');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  Widget circ3() {
    return StreamBuilder(
        //esta dentro de un stream builder para que se actualice
        initialData: '00:00',
        stream: timer.stream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          TimerModel timer = (snapshot.data == '00:00')//conmparo los datos si el tiempo es 0 regreso el  la informacion  en 0  lo contraio
              ? TimerModel('00:00', 1)
              : snapshot.data;//el dato o la informacion que regresa el stream
          return Expanded(
              child: CircularPercentIndicator(//el widget
            radius: availableWidth / 3,// tamaño del radio entre mas grande el numero mas pequeño el circulo
            lineWidth: 10.0,//el grosor de la linea
            percent: timer.porcentaje,//porcentaje a  mostrar del objeto TimerModel
            center:
                Text(timer.time, style: Theme.of(context).textTheme.headline4),
            progressColor: Color(0xff009688),
          ));
        });
  }

  Widget circ2(BuildContext context) {
    return (CircularPercentIndicator(
      radius: availableWidth / 5,
      lineWidth: 10.0,
      percent: timer.radius,
      center: Text((timer.time == null) ? "00:00" : timer.time.toString(),
          style: Theme.of(context).textTheme.headline4),
      progressColor: Color(0xff009688),
    ));
  }

  Widget circ(double width) {
    return CircularPercentIndicator(
      radius: width / 5,
      lineWidth: 15.0,
      percent: 1.0,
      center: new Text("100%"),
      progressColor: Colors.green,
    );
  }

  Widget fila1() {
    double size = 40.0;
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
            child: ProductButton(
                Colors.blue, "Work", size, () => timer.startWork())),
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
            child: ProductButton(Colors.blue, "Space break", size,
                () => timer.startBreak(true))),
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
            child: ProductButton(
                Colors.blue, "Long break", size, () => timer.startBreak(false)))
      ],
    );
  }

  Widget fila2() {
    double size = 40.0;
    return Row(children: [
      Padding(padding: EdgeInsets.all(defaultPadding)),
      Expanded(
          child: ProductButton(
              Colors.blue, "Stop", size, () => timer.stopTimer())),
      Padding(padding: EdgeInsets.all(defaultPadding)),
      Expanded(
          child: ProductButton(
              Colors.blue, "Restar", size, () => timer.startTimer()))
    ]);
  }

  void emptyMethod() {}
}
