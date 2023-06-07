import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  void increment() => _value++;
  void decrement() => _value--;
  int get value => _value;

  bool diff(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  CounterProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  final CounterState state = CounterState();

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    throw oldWidget.state.diff(state);
  }
}
