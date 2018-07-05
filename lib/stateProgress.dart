import 'package:flutter/material.dart';

class StateProgress extends StatefulWidget {
  StateProgress({Key key, this.current = 0.5, this.aware = false}) : super(key: key);

  final double current;
  final bool aware;

  @override
  State<StatefulWidget> createState() => new ProgressState();
}

class ProgressState extends State<StateProgress> with SingleTickerProviderStateMixin{
  double _lastValue = 0.0;
  AnimationController _controller;
  Animation<double> _animation;
  double value;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );


    _lastValue = widget.current;
    _animation = new Tween(begin: 0.0, end:widget.current)
    .chain(CurveTween(
      curve: Curves.easeIn,
    )).animate(_controller);
    _controller.forward();

  }

  @override
  Widget build(BuildContext context) {
    if(widget.aware){
      _checkValue();
    } else {
      _buildAnimation();
    }

    return new AnimatedBuilder(
        animation: _animation,
        builder: (c,w) => LinearProgressIndicator(value: _animation.value)
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _buildAnimation({double start = 0.0}){

    setState(() {
      this._lastValue = widget.current;

      _animation = new Tween(begin: start, end:widget.current).chain(CurveTween(
        curve: Curves.easeInOut,
      )).animate(_controller);
    });
    _controller.reset();
    _controller.forward();
  }

  void _checkValue() {
    if(this._lastValue != widget.current){
      _controller.stop(canceled: false);
      _buildAnimation(start: _animation.value);
    }
  }
}