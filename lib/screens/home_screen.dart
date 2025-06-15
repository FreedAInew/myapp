import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // <- Este es el fix principal
import '../utils/permission_manager.dart';
import '../services/clipboard_listener.dart';
import '../widgets/file_tile.dart';
//import '../utils/file_saver.dart'; // <- Bórralo si no lo usas aquí
import 'editor_screen.dart';
import 'file_picker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // <- Limpieza moderna

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ClipboardListener _clipboardListener = ClipboardListener();
  bool _listening = false;
  List<File> _files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final granted = await PermissionManager.requestAllPermissions();
    if (!granted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permisos requeridos para funcionar')),
      );
    }
  }

  Future<void> _loadFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final allFiles = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.txt'))
        .toList();
    if (mounted) {
      setState(() {
        _files = allFiles;
      });
    }
  }

  void _startListening() {
    _clipboardListener.startListening();
    setState(() {
      _listening = true;
    });
  }

  void _stopListening() {
    _clipboardListener.stopListening();
    setState(() {
      _listening = false;
    });
  }

  void _openEditor(File file) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditorScreen(file: file)),
    ).then((_) => _loadFiles());
  }

  void _openFilePicker() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FilePickerScreen()),
    ).then((selectedFile) {
      if (selectedFile != null && selectedFile is File) {
        _openEditor(selectedFile);
      }
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Clipboard Auto Saver')),
    body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Pantalla cargada correctamente'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _listening ? null : _startListening,
                child: const Text('Iniciar Escucha'),
              ),
              ElevatedButton(
                onPressed: _listening ? _stopListening : null,
                child: const Text('Detener Escucha'),
              ),
              ElevatedButton(
                onPressed: _openFilePicker,
                child: const Text('Seleccionar/Crear Archivo'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _files.isEmpty
              ? const Center(child: Text('No hay archivos guardados'))
              : ListView.builder(
                  itemCount: _files.length,
                  itemBuilder: (context, index) {
                    final file = _files[index];
                    return FileTile(
                      file: file,
                      onTap: () => _openEditor(file),
                    );
                  },
                ),
        ),
      ],
    ),
  );
}
}