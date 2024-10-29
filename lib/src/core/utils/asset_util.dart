import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';

class AssetUtil {
  static Future<String?> uploadImage(PlatformFile file) async {
    int sizeInBytes = file.size;

    double sizeInMb = sizeInBytes / (1024 * 1024);

    if (sizeInMb > 2) {
      // This file is Longer the
      return null;
    }

    String? description = await client.file.getUploadDescription(
      'notes/images/${DateTime.now().millisecondsSinceEpoch}/${file.name}',
    );

    if (description == null) {
      return null;
    }

    description = description.replaceAll(
      'tradely.s3-us-east-1.amazonaws.com',
      'tradely.s3.us-east-1.amazonaws.com',
    );

    var uploader = FileUploader(description);

    if (file.bytes == null) {
      return null;
    }

    var upload = await uploader.uploadByteData(
      ByteData.view(file.bytes!.buffer),
    );

    if (upload) {
      Map map = jsonDecode(description);

      return map['url'] + '/' + map['request-fields']['key'];
    }

    return null;
  }
}
