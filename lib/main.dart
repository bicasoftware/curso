import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pos;

  @override
  initState(){
    super.initState();
    pos = 1;
  }

  setPos(int p) => setState(() => pos = p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pos,
        onTap: (p) => setPos(p),
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
      ),
    );
  }
}
