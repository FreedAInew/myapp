import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ClipboardListener {
  String? _lastCopied;
  Timer? _timer;
  File? _targetFile;

  /// Inicia la escucha continua del portapapeles
  void startListening({File? chosenFile}) async {
    _targetFile = chosenFile ?? await _getDefaultFile();

    _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      final copiedText = data?.text?.trim();

      if (copiedText != null && copiedText.isNotEmpty && copiedText != _lastCopied) {
        _lastCopied = copiedText;
        await _appendToFile(copiedText);
        print('📋 Copiado guardado: $copiedText');
      }
    });
  }

  /// Detiene la escucha
  void stopListening() {
    _timer?.cancel();
  }

  /// Guarda el texto al final del archivo sin borrar el anterior
  Future<void> _appendToFile(String text) async {
    if (_targetFile == null) return;
    await _targetFile!.writeAsString('$text\n', mode: FileMode.append);
  }

  /// Obtiene un archivo .txt predeterminado o lo crea
  Future<File> _getDefaultFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/clipboard_notes.txt');

    if (!(await file.exists())) {
      await file.create(recursive: true);
    }

    return file;
  }
}
//2