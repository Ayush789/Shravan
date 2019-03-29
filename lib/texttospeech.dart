import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hackmait/bloc.dart';

FlutterTts flutterTts = FlutterTts();

class TextToSpeech extends StatefulWidget {

  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  @override
  Widget build(BuildContext context) {
    VGIBloc vbloc = BlocProvider.of<VGIBloc>(context);
    return BlocBuilder<VGIEvent, VGIState>(
      bloc: vbloc,
      builder: (context, state) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                state.text,
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    await flutterTts.setLanguage("en-US");

                    await flutterTts.setSpeechRate(1.0);

                    //await flutterTts.setVolume(1.0);

                    //await flutterTts.setPitch(1.0);

                    //await flutterTts.isLanguageAvailable("en-US");

                    var res = await flutterTts.speak(state.text);
                    print(res);
                  },
                  child: Icon(Icons.play_arrow),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
