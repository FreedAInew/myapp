import 'dart:io';
import 'package:flutter/material.dart';

class EditorScreen extends StatefulWidget {
  final File file;

  const EditorScreen({super.key, required this.file});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadFileContent();
  }

  Future<void> _loadFileContent() async {
    final content = await widget.file.readAsString();
    _controller.text = content;
  }

  Future<void> _saveFile() async {
  setState(() => _isSaving = true);
  await widget.file.writeAsString(_controller.text);

  if (!mounted) return; // ✅ ¡Chequea si el widget sigue montado!

  setState(() => _isSaving = false);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Archivo guardado')),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.path.split('/').last),
        actions: [
          IconButton(
            icon: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.save),
            onPressed: _isSaving ? null : _saveFile,
            tooltip: 'Guardar',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe aquí...',
          ),
        ),
      ),
    );
  }
}
