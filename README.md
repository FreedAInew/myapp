# myapp
# 📋 ClipVault (WIP)

> Bloc de notas inteligente con copiado y pegado automático para Android.  
> ⚡ Hecho con Flutter + Dart | Proyecto en evolución  

![ClipVault Banner](assets/banner.png)

---

## 🚀 ¿Qué es ClipVault?

ClipVault es una app móvil que va más allá del típico bloc de notas. Permite guardar todo lo que copias (texto por ahora, imágenes próximamente) y automatiza su pegado en intervalos que tú controlas.

Ideal para:
- Estudiantes que recopilan información.
- Programadores que manejan fragmentos de código.
- Usuarios que hacen tareas repetitivas.
- Cualquiera que quiera ahorrar tiempo con el portapapeles.

---

## ✨ Funciones principales

✅ **Copiado automático:**  
Guarda todo lo que copias en segundo plano.

✅ **Pegado continuo:**  
Pega en intervalos definidos (temporizados o aleatorios).

✅ **Modo programado:**  
Activa/desactiva en horarios específicos o por sesión.

✅ **Diseño minimalista:**  
Pantallas simples, efectivas y sin distracciones.

🚧 **En desarrollo:**  
- Guardado automático de imágenes y capturas de pantalla.  
- Multiportapapeles (historial).  
- Sincronización opcional.

---

## 🖼️ Vista previa

| Inicio | Editor | Configuración |
|-------|--------|---------------|
| ![home](assets/screen1.png) | ![editor](assets/screen2.png) | ![settings](assets/screen3.png) |

> 📷 Puedes agregar tus propias capturas aquí: `assets/screen1.png`, `screen2.png`, etc.

---

## 🛠️ Tecnologías usadas

| Tecnología  | Propósito                          |
|-------------|------------------------------------|
| Flutter     | Framework UI multiplataforma       |
| Dart        | Lenguaje de programación            |
| Android SDK | Plataforma objetivo (por ahora)     |
| Clipboard   | Monitoreo del portapapeles          |
| File I/O    | Guardado local de contenido         |
| Permissions | Gestión de permisos de usuario      |

---

## 📁 Estructura del Proyecto

```bash
lib/
├── main.dart                   # Entry point
├── screens/                   # Pantallas principales
│   ├── home_screen.dart
│   ├── editor_screen.dart
│   └── file_picker_screen.dart
├── services/                  # Lógica de portapapeles
│   └── clipboard_listener.dart
├── utils/                     # Utilidades generales
│   ├── file_saver.dart
│   └── permission_manager.dart
├── widgets/                   # Widgets reutilizables
│   └── file_tile.dart
test/
└── widget_test.dart


⚙️ Cómo usar (modo desarrollador)
Clona el repositorio:

bash
Copiar
Editar
git clone https://github.com/FreedAInew/myapp.git
cd myapp
Asegúrate de tener Flutter instalado y configurado:

bash
Copiar
Editar
flutter doctor
Instala las dependencias:

bash
Copiar
Editar
flutter pub get
Corre la app en tu emulador o dispositivo:

bash
Copiar
Editar
flutter run
🤝 Contribuir
¿Ideas? ¿Mejoras? ¿Bug encontrado? ¡Bienvenido!
Abre un issue o haz un fork y crea un Pull Request.

bash
Copiar
Editar
# Clona tu fork y crea una rama
git checkout -b feature/nueva-funcionalidad
Áreas en las que puedes ayudar:

Guardado de imágenes automáticas

Modo oscuro

Soporte para iOS

Internacionalización (i18n)

📌 Roadmap
 Pegado automático de texto

 Copiado continuo

 Guardado de imágenes

 Multiportapapeles

 Exportación de notas

 Sincronización opcional con la nube (desactivado por defecto)

📄 Licencia
MIT © FreedAInew

💡 Créditos / Inspiración
Este proyecto fue inspirado por la necesidad de automatizar tareas repetitivas del día a día y recopilar información sin esfuerzo.

“Tu portapapeles, pero en esteroides.”