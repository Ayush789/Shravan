import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmait/bloc.dart';

class Txt extends StatefulWidget {
  @override
  _TxtState createState() => _TxtState();
}

class _TxtState extends State<Txt> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    VGIBloc vbloc = BlocProvider.of<VGIBloc>(context);
    return BlocBuilder<VGIEvent, VGIState>(
      builder: (context, state) {
        controller.text = state.text;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(),
                      maxLines: null,
                      controller: controller,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          vbloc
                              .dispatch(EditingComplete(text: controller.text));
                        },
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            controller.text = "";
                            vbloc.dispatch(
                                EditingComplete(text: controller.text));
                          });
                        },
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.clear,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      bloc: vbloc,
    );
  }
}
