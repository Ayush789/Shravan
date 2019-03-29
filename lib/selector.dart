import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmait/bloc.dart';
import 'package:hackmait/gesturetotext.dart';
import 'package:hackmait/speechtotext.dart';
import 'package:hackmait/text.dart';
import 'package:hackmait/texttogesture.dart';
import 'package:hackmait/texttospeech.dart';

class Selector extends StatefulWidget {
  int place;

  Selector(this.place);

  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  String value = "Text To Speech";

  @override
  Widget build(BuildContext context) {
    VGIBloc vbloc = BlocProvider.of<VGIBloc>(context);
    return BlocBuilder<VGIEvent, VGIState>(
      bloc: vbloc,
      builder: (context, state) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    items: [
                      DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.text_fields),
                            Icon(Icons.arrow_right),
                            Icon(Icons.volume_up),
                          ],
                        ),
                        value: "Text To Speech",
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.text_fields),
                          ],
                        ),
                        value: "Text",
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.mic),
                            Icon(Icons.arrow_right),
                            Icon(Icons.text_fields),
                          ],
                        ),
                        value: "Speech To Text",
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.text_fields),
                            Icon(Icons.arrow_right),
                            Text(
                              "A",
                              style: TextStyle(
                                fontFamily: "Hands",
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                        value: "Text To ASL",
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "A",
                              style: TextStyle(
                                fontFamily: "Hands",
                                fontSize: 25.0,
                              ),
                            ),
                            Icon(Icons.arrow_right),
                            Icon(Icons.text_fields),
                          ],
                        ),
                        value: "ASL To Text",
                      ),
                    ],
                    onChanged: (newval) {
                      setState(() {
                        value = newval;
                      });
                    },
                    value: value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        child: Icon(Icons.check),
                        onPressed: () {
                          switch (value) {
                            case "Text To Speech":
                              vbloc.dispatch(
                                WidgetChange(
                                    newwidget: TextToSpeech(),
                                    Place: widget.place),
                              );
                              break;
                            case "Text":
                              vbloc.dispatch(
                                WidgetChange(
                                    newwidget: Txt(),
                                    Place: widget.place),
                              );
                              break;
                            case "Speech To Text":
                              vbloc.dispatch(
                                WidgetChange(
                                    newwidget: SpeechToText(),
                                    Place: widget.place),
                              );
                              break;
                            case "Text To ASL":
                              vbloc.dispatch(
                                WidgetChange(
                                    newwidget: TextToGesture(),
                                    Place: widget.place),
                              );
                              break;
                            case "ASL To Text":
                              vbloc.dispatch(
                                WidgetChange(
                                    newwidget: GestureToText(),
                                    Place: widget.place),
                              );
                              break;
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
