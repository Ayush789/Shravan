import 'package:flutter/material.dart';
import 'package:hackmait/base.dart';
import 'package:hackmait/bloc.dart';
import 'package:hackmait/speechtotext.dart';
import 'package:hackmait/text.dart';
import 'package:hackmait/texttogesture.dart';
import 'package:hackmait/texttospeech.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    VGIBloc vbloc = VGIBloc();
    return BlocProvider<VGIBloc>(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BasePage(),
      ),
      bloc: vbloc,
    );
  }
}

TextEditingController controller =
    TextEditingController.fromValue(TextEditingValue(text: "Hi There"));

class BoxWid extends StatefulWidget {
  Widget child;

  BoxWid(
    this.child,
  );

  @override
  _BoxWidState createState() => _BoxWidState();
}

class _BoxWidState extends State<BoxWid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
