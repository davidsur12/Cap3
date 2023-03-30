import 'package:flutter/material.dart';
typedef CallbackSetting = void Function(String, int);
class SettingButton extends StatelessWidget {
Color color;
String text;
int value;
//double size;
String setting;
CallbackSetting callback;

//CallbackSetting callback;
  SettingButton( @required this.color , this.text , this.value , this.callback , this.setting);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(child: Text(this.text , style: TextStyle(color: Colors.white),)
    ,onPressed: ()=> this.callback(this.setting, this.value),
    color: Colors.green,
    minWidth: 10.0,
    );
  }
}
