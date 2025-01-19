import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController _controller = TextEditingController();
  String _content = "";

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/study_notes.txt";
  }

  Future<void> _saveToFile(String content) async {
    final path = await _getFilePath();
    final file = File(path);
    await file.writeAsString(content);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Nota guardada exitosamente.')));
  }

  Future<void> _loadFromFile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      String content = await file.readAsString();
      setState(() {
        _content = content;
      });
    } catch (e) {
      setState(() {
        _content = "Error leyendo el archivo.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anotaciones Rápidas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escribe tus anotaciones:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe tus ideas o apuntes rápidos...',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await _saveToFile(_controller.text);
                  },
                  icon: Icon(Icons.save),
                  label: Text('Guardar'),
                ),
                ElevatedButton.icon(
                  onPressed: _loadFromFile,
                  icon: Icon(Icons.download),
                  label: Text('Cargar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            _content.isNotEmpty
                ? Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
