import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'establishment_form_view.dart';

class EstablishmentListView extends StatefulWidget {
  const EstablishmentListView({super.key});

  @override
  State<EstablishmentListView> createState() => _EstablishmentListViewState();
}

class _EstablishmentListViewState extends State<EstablishmentListView> {
  List<dynamic> establishments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEstablishments();
  }

  Future<void> loadEstablishments() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('http://192.168.0.14:8000/api/establecimientos'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        establishments = jsonDecode(response.body);
        isLoading = false;
      });
    }
  }

  Future<void> deleteEstablishment(int id) async {
    final token = await AuthService.getToken();
    await http.delete(
      Uri.parse('http://192.168.0.14:8000/api/establecimientos/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    loadEstablishments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Establecimientos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EstablishmentFormView()),
          );
          if (result == true) loadEstablishments();
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: establishments.length,
              itemBuilder: (_, index) {
                final est = establishments[index];
                return ListTile(
                  leading: est['imagen'] != null
                      ? Image.network(
                          'http://192.168.0.14:8000/storage/${est['imagen']}',
                          width: 50, height: 50, fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_not_supported),
                  title: Text(est['nombre']),
                  subtitle: Text(est['direccion']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EstablishmentFormView(est: est),
                            ),
                          );
                          if (result == true) loadEstablishments();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteEstablishment(est['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
