import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'user_form_view.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
  final token = await AuthService.getToken();
  final response = await http.get(
    Uri.parse('http://192.168.0.14:8000/api/users'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    setState(() {
      users = jsonDecode(response.body);
      isLoading = false;
    });
  }
}


  Future<void> deleteUser(int id) async {
    final token = await AuthService.getToken();
    await http.delete(
      Uri.parse('http://192.168.0.14:8000/api/users/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuarios"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadUsers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserFormView()),
          );
          if (result == true) loadUsers();
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name'] ?? 'Sin nombre'),
                  subtitle: Text(user['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UserFormView(user: user),
                            ),
                          );
                          if (result == true) loadUsers();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteUser(user['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
