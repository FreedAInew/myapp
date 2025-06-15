import 'dart:io';
import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final File file;
  final VoidCallback onTap;

  const FileTile({
    super.key,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final filename = file.path.split('/').last;

    return ListTile(
      leading: const Icon(Icons.description_outlined),
      title: Text(filename),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
