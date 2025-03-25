import 'package:flutter/material.dart';
import 'form_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Cambiado a 3 tabs
    print("🟢 initState() de MyHomePage"); // Se ejecuta al iniciar el widget
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("🔵 didChangeDependencies() de MyHomePage"); // Cambian dependencias
  }

  @override
  Widget build(BuildContext context) {
    print("🟡 build() de MyHomePage"); // Se reconstruye la UI
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Principal"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Lista"),
            Tab(text: "Opciones"),
            Tab(text: "Info"), // Nuevo tab
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ✅ 1. GridView con elementos (Lista)
          GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columnas
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("➡ Navegando a FormView con Elemento $index");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              FormView(textoInicial: "Elemento $index"),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Elemento $index",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            },
          ),

          // ✅ 2. Switch como segundo widget
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Activar opción:", style: TextStyle(fontSize: 18)),
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                    print("⚡ setState() de MyHomePage - Cambio en Switch");
                  });
                },
              ),
              Text(
                _isSwitched ? "Opción activada" : "Opción desactivada",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // ✅ 3. Nuevo Widget: ExpansionTile
          ListView(
            children: const [
              ExpansionTile(
                title: Text("Información General"),
                children: [
                  ListTile(title: Text("Este proyecto está hecho en Flutter.")),
                  ListTile(title: Text("Utiliza Tabs y navegación con rutas.")),
                ],
              ),
              ExpansionTile(
                title: Text("Créditos"),
                children: [
                  ListTile(title: Text("Desarrollado por: Tu Nombre")),
                  ListTile(title: Text("Versión: 1.0.0")),
                ],
              ),
              ExpansionTile(
                title: Text("Soporte"),
                children: [
                  ListTile(title: Text("Contacto: soporte@ejemplo.com")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    print("🔴 dispose() de MyHomePage"); // Al cerrar el widget
    super.dispose();
  }
}
