import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmait/bloc.dart';
import 'package:hackmait/selector.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    VGIBloc vbloc = BlocProvider.of<VGIBloc>(context);
    return BlocBuilder(
      bloc: vbloc,
      builder: (context, state) {
        double h = MediaQuery.of(context).size.height;
        double w = MediaQuery.of(context).size.width;
        print("h $h w $w");
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xFFFEC194),
                          Color(0xFFFF0061),
                        ],
                        end: Alignment(1, 1),
                        begin: Alignment(-1, -1),
                      )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xFF02FDEE),
                          Color(0xFF548BED),
                        ],
                        end: Alignment(1, 1),
                        begin: Alignment(-1, -1),
                      )),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(h * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 2.0, color: Colors.red),
                        color: Colors.white,
                      ),
                      height: h * 0.4,
                      width: w * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          (state.top is Selector)
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                      ),
                                      onPressed: () {
                                        vbloc.dispatch(WidgetChange(
                                            newwidget: Selector(0), Place: 0));
                                      },
                                    )
                                  ],
                                ),
                          state.top
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(h * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 2.0, color: Colors.blue),
                        color: Colors.white,
                      ),
                      height: h * 0.4,
                      width: w * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          (state.bottom is Selector)
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                      ),
                                      onPressed: () {
                                        vbloc.dispatch(WidgetChange(
                                            newwidget: Selector(1), Place: 1));
                                      },
                                    )
                                  ],
                                ),
                          state.bottom
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: (h * 0.5 - 28)),
                    child: Center(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: Image.asset(
                          "assets/swap.png",
                          height: 30.0,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
