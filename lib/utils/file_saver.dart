import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileSaver {
  /// Guarda texto en un archivo .txt, crea el archivo si no existe
  static Future<File> saveTextToFile(String filename, String text) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    if (!(await file.exists())) {
      await file.create(recursive: true);
    }

    // Escribe el texto (sobrescribe contenido previo)
    return file.writeAsString(text);
  }

  /// Añade texto al final del archivo sin borrar lo previo
  static Future<File> appendTextToFile(String filename, String text) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    if (!(await file.exists())) {
      await file.create(recursive: true);
    }

    return file.writeAsString('$text\n', mode: FileMode.append);
  }
}
//3