import 'package:flutter/material.dart';
import 'package:flutter_floor/database/database.dart';
import 'package:flutter_floor/model/person.dart';
import 'package:uuid/uuid.dart';

import 'dao/persondao.dart';

Future<void> main() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(MyApp(database));
}

void databaseAccess() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  //final person = await database.personDao.findPersonById(1);

  // await database.personDao.insertPerson(personToSave);
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp(this.database);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          MyHomePage(title: 'Flutter Demo Home Page', dao: database.personDao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.dao}) : super(key: key);

  final String title;

  final PersonDao dao;

  @override
  _MyHomePageState createState() => _MyHomePageState(dao);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final PersonDao dao;

  _MyHomePageState(this.dao);

  void _incrementCounter() {
    setState(() {
      Person personToSave = Person(Uuid().v4().toString(), "Shido");

      dao.insertPerson(personToSave);

      countRegisters();
    });
  }

  void countRegisters() async {
    List<Person> totalPersons = await dao.findAllPersons();
    _counter = totalPersons.length;
  }

  @override
  Widget build(BuildContext context) {
    countRegisters();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'There are this many people on your database:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
