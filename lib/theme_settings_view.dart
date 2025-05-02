import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Configuración de Tema")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Modo oscuro"),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (val) => themeProvider.toggleTheme(val),
            ),
            const SizedBox(height: 20),
            const Text("Color principal:", style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 10,
              children: [
                _colorButton(context, 'red', Colors.red),
                _colorButton(context, 'green', Colors.green),
                _colorButton(context, 'blue', Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(BuildContext context, String label, MaterialColor color) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () => themeProvider.setPrimaryColor(label),
      child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.white)),
    );
  }
}

