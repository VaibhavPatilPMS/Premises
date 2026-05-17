import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;
import 'package:premises/common/utils/utils.dart';

class FileConversionUtility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static String base64StringFromFile(File? data) {
    String convertedString = base64Encode(data!.readAsBytesSync());
    return convertedString;
  }

  static List<String> base64StringList({required List<File?>? fileList}) {
    List<String> base64List = [];
    for (var element in fileList!) {
      String convertedString = base64Encode(element!.readAsBytesSync());
      base64List.add(convertedString);
    }
    return base64List;
  }

  static List<Uint8List> getConvertedFileList(
      {required List<String> base64StringList}) {
    List<Uint8List> uint8List = [];
    for (var element in base64StringList) {
      Uint8List conertedFile = base64Decode(element);
      uint8List.add(conertedFile);
    }
    return uint8List;
  }

  static Future<List<File>> createFileListFromBase64String(
      {required List<String> base64List,
      bool? isExtensionsRequired = false}) async {
    List<File> convertedFileList = [];
    for (var element in base64List) {
      File? file;
      String? fileName;

      final String data =
          element.contains(',') ? element.split(',').last : element;
      Uint8List bytes = base64.decode(data);
      String directoryPath = await FileUtils.getFileDirectoryPath();
      if (isExtensionsRequired!) {
        fileName = randomAlphaNumeric(10).toString() +
            getBase64FileExtension(base64String: data);
      } else {
        fileName = randomAlphaNumeric(10).toString();
      }
      file = File('$directoryPath/$fileName');

      await file.writeAsBytes(bytes);
      convertedFileList.add(file);
    }
    return convertedFileList;
  }

  // static String getBase64FileExtension({required String? base64String}) {
  //   switch (base64String!.characters.first) {
  //     case '/':
  //       return '.jpeg';
  //     case 'i':
  //       return '.png';
  //     case 'R':
  //       return '.gif';
  //     case 'U':
  //       return '.webp';
  //     case 'J':
  //       return '.pdf';
  //     default:
  //       return '.unknown';
  //   }
  // }

  static String getBase64FileExtension({required String? base64String}) {
    if (base64String == null || base64String.isEmpty) {
      return '.unknown';
    }

    try {
      // Decode the first few bytes of the base64 string
      Uint8List bytes = base64Decode(base64String.split(',').last);

      if (bytes.length < 8) {
        return '.unknown';
      }

      // Check for file signatures
      if (_compareBytes(bytes, [0xFF, 0xD8, 0xFF])) {
        return '.jpeg';
      } else if (_compareBytes(
          bytes, [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])) {
        return '.png';
      } else if (_compareBytes(bytes, [0x47, 0x49, 0x46, 0x38])) {
        return '.gif';
      } else if (_compareBytes(bytes, [0x52, 0x49, 0x46, 0x46]) &&
          _compareBytes(bytes.sublist(8), [0x57, 0x45, 0x42, 0x50])) {
        return '.webp';
      } else if (_compareBytes(bytes, [0x25, 0x50, 0x44, 0x46])) {
        return '.pdf';
      } else if (_compareBytes(
          bytes, [0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1])) {
        return '.doc';
      } else if (_compareBytes(bytes, [0x50, 0x4B, 0x03, 0x04]) &&
          base64String.contains('word/')) {
        return '.docx';
      } else {
        return '.unknown';
      }
    } catch (e) {
      CustomLogger.logPrint('Error decoding base64 string: $e');
      return '.unknown';
    }
  }

  static bool _compareBytes(Uint8List bytes, List<int> signature) {
    if (bytes.length < signature.length) return false;
    for (int i = 0; i < signature.length; i++) {
      if (bytes[i] != signature[i]) return false;
    }
    return true;
  }

  static Future<File> createFileFromBase64String(
      {required String base64String}) async {
    File? convertedFile;
    Uint8List bytes = base64.decode(base64String);
    String directoryPath = await FileUtils.getFileDirectoryPath();
    String fileName = randomAlphaNumeric(10).toString();
    convertedFile = File('$directoryPath/$fileName');
    await convertedFile.writeAsBytes(bytes);
    return convertedFile;
  }

  static String reduceBase64ImageSize(
      File? base64Image, int width, int height) {
    String convertedString = base64Encode(base64Image!.readAsBytesSync());
    // Decode the Base64 string to a byte array
    final bytes = base64Decode(convertedString);
    // Decode the byte array to an image
    final convertedImage = image.decodeImage(bytes);
    // Resize the image
    final resizedImage =
        image.copyResize(convertedImage!, width: width, height: height);
    // Re-encode the image to Base64
    final resizedBytes = image.encodeJpg(resizedImage);
    return base64Encode(resizedBytes);
  }
}
