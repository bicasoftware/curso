import 'package:curso/MainState.dart';
import 'package:curso/bloc/bloc_main/BlocMain.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  BlocMain _bloc = BlocMain();

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        fontFamily: "FiraSans",
        brightness: Brightness.dark,
      ),
      home: BlocProvider<BlocMain>(
        bloc: _bloc,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("iCurso"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              return Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Opa"),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text("Exemplo"),
        ),
      ),
      bottomNavigationBar: BlocBuilder<MainEvents, MainState>(
        bloc: b,
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.navPos,
            onTap: (p) => b.dispatch(SetPosition(p)),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_day),
                title: Text("Periodos"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range),
                title: Text("Hoje"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted),
                title: Text("Curso"),
              ),
            ],
          );
        },
      ),
    );
  }
}
