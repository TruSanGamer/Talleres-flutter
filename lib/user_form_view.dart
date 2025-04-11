import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class UserFormView extends StatefulWidget {
  final Map<String, dynamic>? user;
  const UserFormView({super.key, this.user});

  @override
  State<UserFormView> createState() => _UserFormViewState();
}

class _UserFormViewState extends State<UserFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    if (user != null) {
      isEdit = true;
      _nameController.text = user['name'];
      _emailController.text = user['email'];
    }
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    final token = await AuthService.getToken();
    final uri = isEdit
        ? Uri.parse('http://192.168.0.14:8000/api/users/${widget.user!['id']}')
        : Uri.parse('http://192.168.0.14:8000/api/users');

    final body = {
      'name': _nameController.text,
      'email': _emailController.text,
      if (!isEdit) 'password': _passController.text,
    };

    final response = isEdit
        ? await http.put(uri, headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }, body: jsonEncode(body))
        : await http.post(uri, headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar usuario')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Usuario' : 'Nuevo Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              if (!isEdit)
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) =>
                      value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submit,
                child: Text(isEdit ? 'Actualizar' : 'Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
