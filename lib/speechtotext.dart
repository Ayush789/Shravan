import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmait/bloc.dart';
import 'package:speech_recognition/speech_recognition.dart';

SpeechRecognition speech = SpeechRecognition();

class SpeechToText1 extends StatefulWidget {
  TextEditingController controller;

  SpeechToText1({
    @required this.controller,
  });

  @override
  _SpeechToText1State createState() => _SpeechToText1State();
}

class _SpeechToText1State extends State<SpeechToText1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.mic),
            onPressed: () {
              speech.activate().then((val) {
                print(val);
              });
              speech.listen(locale: "en_GB").then((result) {
                print('result : ${result.runtimeType} ${result.toString()}');
                widget.controller.text = result;
              }).catchError((e) {
                print("Error $e");
              });
              print("Controller Text ${widget.controller.text}");
              setState(() {});
              speech.cancel();
              speech.stop();
            },
          ),
          Text(widget.controller.text),
        ],
      ),
    );
  }
}

void main() {
  runApp(new SpeechToText());
}

const languages = const [
  const Language('Francais', 'fr_FR'),
  const Language('English', 'en_US'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class SpeechToText extends StatefulWidget {
  @override
  _SpeechToTextState createState() => new _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  //String _currentLocale = 'en_US';
  Language selectedLang = languages[1];

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_SpeechToTextState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    //_speech.setErrorHandler(errorHandler);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  @override
  Widget build(BuildContext context) {
    VGIBloc vbloc = BlocProvider.of<VGIBloc>(context);
    return BlocBuilder<VGIEvent, VGIState>(
      bloc: vbloc,
      builder: (context, state) => Padding(
            padding: new EdgeInsets.all(8.0),
            child: new Center(
              child: new Column(
                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.text,
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  /*
              new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.grey.shade200,
                  child: new Text(transcription)),*/
                  /*_buildButton(
                      onPressed: _speechRecognitionAvailable && !_isListening
                          ? () => start()
                          : null,
                      label: _isListening
                          ? 'Listening...'
                          : 'Listen (${selectedLang.code})',
                    ),
                    _buildButton(
                      onPressed: _isListening ? () => cancel() : null,
                      label: 'Cancel',
                    ),
                    _buildButton(
                      onPressed: _isListening ? () => stop() : null,
                      label: 'Stop',
                    ),*/
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () {
                            if (_isListening) {
                              stop();
                            } else {
                              if (_speechRecognitionAvailable) {
                                start();
                              }
                            }
                          },
                          child:
                              _isListening ? Icon(Icons.stop) : Icon(Icons.mic),
                          backgroundColor:
                              _isListening ? Colors.red : Colors.blue,
                        ),
                        FloatingActionButton(
                          onPressed: cancel,
                          child: Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => new CheckedPopupMenuItem<Language>(
            value: l,
            checked: selectedLang == l,
            child: new Text(l.name),
          ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
      padding: new EdgeInsets.all(12.0),
      child: new RaisedButton(
        color: Colors.cyan.shade600,
        onPressed: onPressed,
        child: new Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ));

  void start() => _speech.listen(locale: selectedLang.code).then((result) {
        print('_SpeechToTextState.start => result $result');
      });

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() => _speech.stop().then((result) {
        setState(() => _isListening = result);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_SpeechToTextState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) => setState(() {
        transcription = text;
        //widget.controller.text = text;
        BlocProvider.of<VGIBloc>(context).dispatch(EditingComplete(text: text));
        //print("Widget Final Text ${widget.controller.text}");
      });

  void onRecognitionComplete() => setState(() => _isListening = false);

  void errorHandler() => activateSpeechRecognizer();
}
