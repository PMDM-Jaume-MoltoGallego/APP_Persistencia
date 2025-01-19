import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  late Database database;
  List<Map<String, dynamic>> routines = [];

  Future<void> _initializeDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'routines.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE routines(id INTEGER PRIMARY KEY, name TEXT, description TEXT)",
        );
      },
      version: 1,
    );
    _loadRoutines();
  }

  Future<void> _addRoutine(String name, String description) async {
    await database.insert('routines', {'name': name, 'description': description});
    _loadRoutines();
  }

  Future<void> _deleteRoutine(int id) async {
    await database.delete('routines', where: 'id = ?', whereArgs: [id]);
    _loadRoutines();
  }

  Future<void> _loadRoutines() async {
    final data = await database.query('routines');
    setState(() {
      routines = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Rutinas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre de la rutina',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Descripción de la rutina'),
                    content: TextField(
                      onSubmitted: (desc) {
                        _addRoutine(value, desc);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: routines.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(routines[index]['name']),
                      subtitle: Text(routines[index]['description']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteRoutine(routines[index]['id']);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
