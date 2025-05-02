
// student_list_view.dart
import 'package:flutter/material.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({super.key});

  @override
  State<StudentListView> createState() => _StudentListViewLogic();
}

class _StudentListViewLogic extends State<StudentListView> {
  late Future<List<String>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    debugPrint("🟢 StudentListView initialized");
    _studentsFuture = _fetchStudents();
  }

  Future<List<String>> _fetchStudents() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      "Santiago Trujillo",
      "Emanuel Benjumea",
      "Carlos Camacho",
      "Brandon Quintero",
      "Juan David Guarnizo",
    ];
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🟡 Rendering StudentListView");
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Estudiantes")),
      body: FutureBuilder<List<String>>(
        future: _studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) => ListTile(title: Text(data[i])),
            );
          } else {
            return const Center(child: Text("Error al cargar datos"));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    debugPrint("🔴 StudentListView disposed");
    super.dispose();
  }
}
