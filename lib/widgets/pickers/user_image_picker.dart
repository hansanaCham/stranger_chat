import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePickFN, {super.key});
  final Function(File pickedImage) imagePickFN;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFN(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          radius: 40,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text(
            'Add Image',
            style: TextStyle(
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
