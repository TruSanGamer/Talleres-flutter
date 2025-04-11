import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'auth_service.dart';

class EstablishmentFormView extends StatefulWidget {
  final Map<String, dynamic>? est;
  const EstablishmentFormView({super.key, this.est});

  @override
  State<EstablishmentFormView> createState() => _EstablishmentFormViewState();
}

class _EstablishmentFormViewState extends State<EstablishmentFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  File? _image;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.est != null) {
      isEdit = true;
      _nameController.text = widget.est!['nombre'];
      _addressController.text = widget.est!['direccion'];
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final token = await AuthService.getToken();
    final uri = isEdit
        ? Uri.parse('http://192.168.0.14:8000/api/establecimientos/${widget.est!['id']}')
        : Uri.parse('http://192.168.0.14:8000/api/establecimientos');

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['nombre'] = _nameController.text;
    request.fields['direccion'] = _addressController.text;

    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('imagen', _image!.path));
    }

    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar establecimiento')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Establecimiento' : 'Nuevo Establecimiento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 10),
              _image == null
                  ? const Text('No se seleccionó imagen.')
                  : Image.file(_image!, height: 150),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text("Seleccionar Imagen"),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEdit ? 'Actualizar' : 'Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
