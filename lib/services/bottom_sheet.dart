import 'dart:io';

import 'package:checkgasusage/widgets/modal_bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<File> onImagePickerBottomSheet(BuildContext context, String title)async {
  File result = await showModalBottomSheet<File>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return ImagePickerBottomSheet(title: title );
    },
  );
  return result;
}