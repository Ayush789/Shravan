import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmait/bloc.dart';

class TextToGesture extends StatefulWidget {
  @override
  _TextToGestureState createState() => _TextToGestureState();
}

class _TextToGestureState extends State<TextToGesture> {
  @override
  Widget build(BuildContext context) {
    VGIBloc vbloc = BlocProvider.of<VGIBloc>(context);
    return BlocBuilder<VGIEvent, VGIState>(
      bloc: vbloc,
      builder: (context, state) {
        print("State Change");
        return showWidget(state.text);
      },
    );
  }
}

class showWidget extends StatefulWidget {
  String text;

  showWidget(this.text);

  @override
  _showWidgetState createState() => _showWidgetState();
}

class _showWidgetState extends State<showWidget> {
  String letter = "a";

  List<TextSpan> span = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: span.length > 0 ? span : [TextSpan(text: widget.text)],
          ),
        ),
        Container(
          child: Text(
            letter,
            style: TextStyle(
              fontFamily: "Hands",
              fontSize: 120.0,
              // height: 10.0,
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () async {
            for (int i = 0; i < widget.text.length; i++) {
              print(i);
              span = getspan(widget.text, i);
              print(span);
              letter = widget.text[i];
              setState(() {});
              await Future.delayed(Duration(milliseconds: 500));

            }

            span = getspan(widget.text, -1);
            letter = widget.text[0];
            setState(() {

            });
          },
          child: Icon(Icons.play_arrow),
        )
      ],
    ));
  }

  List<TextSpan> getspan(String text, int x) {
    List<TextSpan> ans = [];
    List<String> letters = text.split('');

    for (int i = 0; i < letters.length; i++) {
      ans.add(TextSpan(
        text: letters[i],
        style: TextStyle(
          color: i == x ? Colors.red : Colors.black,
        ),
      ));
    }
    return ans;
  }
}
