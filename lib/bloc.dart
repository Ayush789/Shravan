import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hackmait/selector.dart';

class VGIBloc extends Bloc<VGIEvent, VGIState> {
  @override
  VGIState get initialState =>
      VGIState(
        text: "Have A Nice Day",
        top: Selector(0),
        bottom: Selector(1),
      );

  @override
  Stream<VGIState> mapEventToState(VGIEvent event) async* {
    if (event is EditingComplete) {
      print("Event is Editing Complete ${event.text}");
      yield VGIState(
        text: event.text,
        top: currentState.top,
        bottom: currentState.bottom,
      );
    }

    if (event is WidgetChange) {
      print("Widget Change");
      if (event.Place == 0) {
        yield VGIState(
            text: currentState.text,
            top: event.newwidget,
            bottom: currentState.bottom
        );
      } else {
        yield VGIState(
          text: currentState.text,
          top: currentState.top,
          bottom: event.newwidget,
        );
      }
    }
  }
}

abstract class VGIEvent {}

class WidgetChange extends VGIEvent {
  int Place;
  Widget newwidget;

  WidgetChange({
    @required this.newwidget,
    @required this.Place,
  });
}

class EditingComplete extends VGIEvent {
  String text;

  EditingComplete({
    @required this.text,
  });
}

class VGIState {
  String text;
  Widget top, bottom;

  VGIState({
    @required this.text,
    @required this.top,
    @required this.bottom,
  });
}
