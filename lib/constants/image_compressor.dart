import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File> compressImage(File image) async {
  List<int>? compressedBytes = await FlutterImageCompress.compressWithFile(
    image.absolute.path,
    minWidth: 500,
    quality: 50,
  );

  File compressedImage = File('${image.path}_compressed.jpg');
  await compressedImage.writeAsBytes(compressedBytes!);
  return compressedImage;
}
