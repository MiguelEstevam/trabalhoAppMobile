// services/file_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  static Future<File> _getFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName.json');
  }

  static Future<void> saveData(String fileName, List<Map<String, dynamic>> data) async {
    final file = await _getFile(fileName);
    await file.writeAsString(jsonEncode(data));
  }

  static Future<List<Map<String, dynamic>>> readData(String fileName) async {
    try {
      final file = await _getFile(fileName);
      if (!(await file.exists())) return [];
      final contents = await file.readAsString();
      return List<Map<String, dynamic>>.from(jsonDecode(contents));
    } catch (e) {
      return [];
    }
  }
}
