import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/utilities/imports.dart';

class ImagePickerProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  ImageSource? get loading => _loading;
  ImageSource? _loading;

  Future<File?> pick({
    required BuildContext context,
    required ImageSource imageSource,
  }) async {
    _loading = imageSource;
    notifyListeners();
    File? result;
    final XFile? image = await _picker.pickImage(source: imageSource);
    if (context.mounted && image != null) {
      result = await cropImage(image: image, context: context);
    }
    _loading = null;
    notifyListeners();
    return result;
  }

  Future<File?> cropImage({
    required XFile? image,
    required BuildContext context,
  }) async {
    if (image?.path == null || image?.path.isEmpty == true) {
      return null;
    }
    var strings = AppLocalizations.of(context);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image?.path ?? "",
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: strings?.cropper ?? '',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: strings?.cropper ?? '',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    return croppedFile?.path == null ? null : File(croppedFile?.path ?? "");
  }
}
