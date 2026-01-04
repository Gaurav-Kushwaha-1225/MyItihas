import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'dart:io';

Future<bool> downloadTextFile({
  required String textContent,
  required String fileName,
  required Function(String message, Color color) onStatusChange,
}) async {
  try {
    // Validate inputs
    if (textContent.isEmpty) {
      onStatusChange('❌ Please enter some text!', Colors.red);
      return false;
    }

    if (fileName.isEmpty) {
      onStatusChange('❌ Please enter a filename!', Colors.red);
      return false;
    }

    onStatusChange('Requesting permissions...', Colors.orange);

    // Request storage permission
    final hasPermission = await Permission.manageExternalStorage.request();
    if (!hasPermission.isGranted) {
      onStatusChange('❌ Storage permission denied!', Colors.red);
      return false;
    }

    onStatusChange('Preparing file...', Colors.orange);

    // Ensure filename has .txt extension
    final String finalFileName = fileName.contains('.txt') ? fileName : '$fileName.txt';

    if (Platform.isAndroid) {
      // Android: Use temporary directory and file dialog
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = '${tempDir.path}/$finalFileName';
      final File tempFile = File(tempPath);
      await tempFile.writeAsString(textContent);

      onStatusChange('Opening save dialog...', Colors.blue);

      final params = SaveFileDialogParams(
        sourceFilePath: tempPath,
        fileName: finalFileName,
      );
      final result = await FlutterFileDialog.saveFile(params: params);

      if (result != null) {
        onStatusChange('✅ File saved to: $result', Colors.green);
        return true;
      } else {
        onStatusChange('❌ Save cancelled', Colors.red);
        return false;
      }
    } else if (Platform.isIOS) {
      // iOS: Save to app documents directory
      final Directory docDir = await getApplicationDocumentsDirectory();
      final String iosPath = '${docDir.path}/$finalFileName';
      final File iosFile = File(iosPath);
      await iosFile.writeAsString(textContent);

      onStatusChange('✅ File saved to Documents: $finalFileName', Colors.green);
      return true;
    } else {
      onStatusChange('❌ Platform not supported', Colors.red);
      return false;
    }
  } catch (e) {
    onStatusChange('❌ Error: ${e.toString()}', Colors.red);
    return false;
  }
}
