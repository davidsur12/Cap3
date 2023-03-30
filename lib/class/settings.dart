import 'package:flutter/material.dart';
import 'package:cap_3/class/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("app 3"),
        ),
        body: Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime = 0;
  int shortBreak = 0;
  int longBreak = 0;
  SharedPreferences? prefs;

  @override
  void initState() {
    //son los controladores y se crean al iniciar la pantalla
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();//leo los valores
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 24);
    return Container(
      color: Colors.blue,
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          //word
          Text(
            "Word",
            style: style,
          ),
          Text(""),
          Text(""),
          SettingButton(Colors.green, "-", -1, updateSetting, WORKTIME),
          TextField(
            style: style,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingButton(Colors.green, "+", 1, updateSetting, WORKTIME),

          //short
          Text(
            "Short",
            style: style,
          ),
          Text(""),
          Text(""),
          SettingButton(Colors.green, "-", -1, updateSetting, SHORTBREAK),
          TextField(
              style: style,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: txtShort),
          SettingButton(Colors.green, "+", 1, updateSetting, SHORTBREAK),

          //long
          Text(
            "Long",
            style: style,
          ),
          Text(""),
          Text(""),
          SettingButton(Colors.green, "-", -1, updateSetting, LONGBREAK),
          TextField(
              style: style,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: txtLong),
          SettingButton(Colors.green, "+", 1, updateSetting, LONGBREAK),
        ],
      ),
    );
  }

  void readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs?.getInt(WORKTIME);
    if (workTime == null) {
      // workTime=30;
      await prefs?.setInt(WORKTIME, int.parse('30'));
    }

    int? shortBreak = prefs?.getInt(SHORTBREAK);
    if (shortBreak == null) {
      // shortBreak=30;
      await prefs?.setInt(SHORTBREAK, int.parse('30'));
    }
    int? longBreak = prefs?.getInt(LONGBREAK);
    if (longBreak == null) {
      // longBreak= 30;
      await prefs?.setInt(LONGBREAK, int.parse('39'));
    }

    setState(() {
      /*
      txtWork?.text = workTime.toString();
      txtShort?.text = shortBreak.toString();
      txtLong?.text = longBreak.toString();
*/
      txtWork?.text=prefs!.getInt(WORKTIME)!.toString();
      txtLong?.text=prefs!.getInt(LONGBREAK)!.toString();
      txtShort?.text=prefs!.getInt(SHORTBREAK)!.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        int? workTime = prefs?.getInt(key);
        workTime = (workTime != null) ? (workTime + value) : null;

        if (workTime != null) {
//workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs?.setInt(key, workTime);
            setState(() {
              txtWork?.text = workTime.toString();
              txtShort?.text = shortBreak.toString();
              txtLong?.text = longBreak.toString();
            });
          }
        }

        break;

      case SHORTBREAK:
        int? shortBreak = prefs?.getInt(key);
        shortBreak = (shortBreak != null) ? (shortBreak + value) : null;

        if (shortBreak != null) {
//workTime += value;
          if (shortBreak >= 1 && shortBreak <= 180) {
            prefs?.setInt(key, shortBreak);
            setState(() {
              txtShort?.text = shortBreak.toString();
            });
          }
        }

        break;
      case LONGBREAK:
        int? longBreak = prefs?.getInt(key);
        longBreak = (longBreak != null) ? (longBreak + value) : null;

        if (longBreak != null) {
//workTime += value;
          if (longBreak >= 1 && longBreak <= 180) {
            prefs?.setInt(key, longBreak);
            setState(() {
              txtLong?.text = longBreak.toString();
            });
          }
        }

        break;
    }
  }
}

/*
  void goToSettings (BuildContext context){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>{

      SettingsScreem();
    }));
  }*/