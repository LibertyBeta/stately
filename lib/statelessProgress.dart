import 'package:flutter/material.dart';

class StatelessProgress extends StatelessWidget{
  StatelessProgress({Key key, @required this.current}) : super(key:key);
  final double current;

  @override
  Widget build(BuildContext context){
    return new LinearProgressIndicator(value: this.current);
  }
}