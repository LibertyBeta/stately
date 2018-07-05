import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'statelessProgress.dart';
import 'stateProgress.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Progressbar State Example',
      theme: new ThemeData(
          primarySwatch: Colors.green,
          textTheme: new TextTheme(
            title: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
            body1: new TextStyle(
              fontSize: 18.0,
            ),
            body2: new TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
            ),
          )),
      home: new StatelessHome(title: 'Stately Progress'),
    );
  }
}

class StatelessHome extends StatelessWidget {
  StatelessHome({Key key, this.title}) : super(key: key);

  final String title;
  final EdgeInsets _subTextInsert = new EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(this.title),
        ),
        body: new SingleChildScrollView(
          child: new SafeArea(
            child: new StreamBuilder<double>(
                stream: Stream.periodic(Duration(seconds: 10), _nextDouble),
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  double value;
                  if (snapshot.data != null) {
                    value = snapshot.data;
                  } else {
                    value = 0.5;
                  }

                  return new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'There are many ways to understand State. Below are three LinearProgressIndicators. Each one handles the State differently',
                          style: theme.textTheme.body1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Text(
                          'The Current Value is ${(value * 100).floor()}%',
                          style: theme.textTheme.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new StatelessProgress(current: value),
                      ),
                      Padding(
                        padding: _subTextInsert,
                        child: Text(
                          'This indicator doesn\'t track its State. It draws the current value from the parent. It is therefore \'stateless\'',
                          style: theme.textTheme.body2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new StateProgress(current: value, aware: false),
                      ),
                      Padding(
                        padding: _subTextInsert,
                        child: Text(
                          'This indicator tracks its own internal State, but doesn\'t listen to its widget for changes from the parent. It will animates the bar from zero to the current value. Each step changes its internal State. It is \'stateful\'',
                          style: theme.textTheme.body2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new StateProgress(current: value, aware: true),
                      ),
                      Padding(
                        padding: _subTextInsert,
                        child: Text(
                          'This indicator tracks its own internal State, and is aware of the parents input. It animates the values between the parent\'s current value and the previous value of its own State. It is \'stateful\' as well.',
                          style: theme.textTheme.body2,
                        ),
                      ),

                    ],
                  );
                }),
          ),
        ));
  }

  double _nextDouble(int computationCount) {
    return Random().nextDouble();
  }
}
