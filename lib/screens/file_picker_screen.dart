import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FilePickerScreen extends StatefulWidget {
  const FilePickerScreen({super.key});

  @override
  State<FilePickerScreen> createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  List<File> _files = [];
  final TextEditingController _newFileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final allFiles = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.txt')).toList();
    setState(() {
      _files = allFiles;
    });
  }

  Future<void> _createNewFile() async {
  final name = _newFileController.text.trim();
  if (name.isEmpty) return;

  final dir = await getApplicationDocumentsDirectory();
  final newFile = File('${dir.path}/$name.txt');

  if (!(await newFile.exists())) {
    await newFile.create();
    await newFile.writeAsString('');
    _newFileController.clear();
    await _loadFiles();
  } else {
    if (!mounted) return; // ✅ Aquí está la solución
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('El archivo "$name.txt" ya existe')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar o Crear Archivo')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _newFileController,
              decoration: const InputDecoration(
                labelText: 'Nuevo archivo (sin extensión)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _createNewFile(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _createNewFile,
              child: const Text('Crear Archivo'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _files.isEmpty
                  ? const Center(child: Text('No hay archivos .txt disponibles'))
                  : ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        final file = _files[index];
                        final filename = file.path.split('/').last;
                        return ListTile(
                          title: Text(filename),
                          onTap: () => Navigator.pop(context, file),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
