import 'package:flutter/material.dart';
import 'form_view.dart';
import 'joke_list_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomePage> with TickerProviderStateMixin {
  late final TabController _controller = TabController(length: 3, vsync: this);
  bool _isActive = false;
  double _sliderValue = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("🟢 initState() ejecutado");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("🔵 didChangeDependencies() ejecutado");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🟡 build() ejecutado");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Página de Inicio"),
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(icon: Icon(Icons.grid_view), text: "Elementos"),
              Tab(icon: Icon(Icons.tune), text: "Configuración"),
              Tab(icon: Icon(Icons.navigation), text: "Ir a Vistas"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            _buildElementGrid(),
            _buildSettings(),
            _buildNavigationPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildElementGrid() => GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 6,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormView(textoInicial: "Elemento $index"),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              "Elemento $index",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );

  Widget _buildSettings() => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Activar opción:", style: TextStyle(fontSize: 18)),
              Switch(
                value: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
              ),
              const SizedBox(height: 10),
              Text(_isActive ? "Activo" : "Inactivo"),
              const SizedBox(height: 30),
              const Text("Valor del Slider:", style: TextStyle(fontSize: 18)),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 10,
                label: _sliderValue.round().toString(),
                onChanged: (val) => setState(() => _sliderValue = val),
              ),
              Text("Valor actual: ${_sliderValue.round()}",
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );

  Widget _buildNavigationPanel() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.people),
            label: const Text("Ver Estudiantes"),
            onPressed: () => Navigator.pushNamed(context, '/students'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.timer),
            label: const Text("Contador"),
            onPressed: () => Navigator.pushNamed(context, '/counter'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.memory),
            label: const Text("Tarea Pesada"),
            onPressed: () => Navigator.pushNamed(context, '/heavy'),
          ),
          ElevatedButton.icon(
  icon: const Icon(Icons.sentiment_very_satisfied),
  label: const Text("Chistes de Chuck Norris"),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const JokeListView()),
    );
  },
),

        ],
        
      );

  @override
  void dispose() {
    _controller.dispose();
    debugPrint("🔴 dispose() ejecutado");
    super.dispose();
  }
}