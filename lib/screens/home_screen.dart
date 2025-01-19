import 'package:flutter/material.dart';
import 'notes_screen.dart';
import 'settings_screen.dart';
import 'database_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rutinas de Estudio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Bienvenido a tu organizador de estudio',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuButton(
                    context,
                    icon: Icons.note_alt_outlined,
                    label: 'Anotaciones Rápidas',
                    screen: NotesScreen(),
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.settings,
                    label: 'Configuración',
                    screen: SettingsScreen(),
                  ),
                  _buildMenuButton(
                    context,
                    icon: Icons.school_outlined,
                    label: 'Gestión de Rutinas',
                    screen: DatabaseScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon, required String label, required Widget screen}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.blue),
        title: Text(label, style: TextStyle(fontSize: 18)),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
      ),
    );
  }
}
