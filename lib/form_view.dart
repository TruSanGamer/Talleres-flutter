import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  final String textoInicial; // Recibe el texto del elemento seleccionado

  const FormView({super.key, required this.textoInicial});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  String textoTipado = "";

  @override
  void initState() {
    super.initState();
    print("initState() → Se ejecuta cuando FormView se crea.");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
      "didChangeDependencies() → Se ejecuta cuando cambian las dependencias.",
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build() → Se ejecuta cada vez que FormView se redibuja.");

    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla Secundaria")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ✅ Muestra el parámetro recibido desde MyHomePage
          Text(
            "Texto recibido: ${widget.textoInicial}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // ✅ Campo de texto
          SizedBox(
            width: 250,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  print(
                    "setState() → Se ejecuta cuando cambia el contenido del TextField.",
                  );
                  textoTipado = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ingrese texto",
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ✅ Botón para regresar a la pantalla principal
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Volver"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("dispose() → Se ejecuta cuando FormView es eliminada.");
    super.dispose();
  }
}
