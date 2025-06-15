import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  /// Pide todos los permisos necesarios para Android 13/14
  static Future<bool> requestAllPermissions() async {
    // Permisos de almacenamiento
    final storageStatus = await Permission.manageExternalStorage.request();
    final notificationStatus = await Permission.notification.request();

    // Si alguno es denegado, devolver false
    if (storageStatus.isDenied || notificationStatus.isDenied) {
      return false;
    }

    // En Android 13+ se requiere esto también
    await Permission.videos.request();
    await Permission.audio.request();
    await Permission.photos.request();

    return true;
  }

  /// Verifica si todos los permisos fueron otorgados
  static Future<bool> hasPermissions() async {
    final storageGranted = await Permission.manageExternalStorage.isGranted;
    final notificationGranted = await Permission.notification.isGranted;

    return storageGranted && notificationGranted;
  }
}
