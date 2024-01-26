import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:great_places/ui/bottom_sheet/bottom_sheet.component.dart';

class ImageInput extends StatefulWidget {
  final void Function(File image) onPickImage;

  const ImageInput({
    required this.onPickImage,
    super.key,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _openBottomSheet,
      icon: const Icon(
        Icons.camera,
      ),
      label: const Text(
        'Take a picture',
      ),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _openBottomSheet,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        firstLabel: 'Take a picture',
        firstOnClick: _takePicture,
        secondLabel: 'Choose from gallery',
        secondOnClick: _choosePictureFromGallery,
      ),
    );
  }

  final imagePicker = ImagePicker();

  void _takePicture() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) return;
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(_selectedImage!);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _choosePictureFromGallery() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onPickImage(_selectedImage!);
    } else {
      return;
    }
    widget.onPickImage(_selectedImage!);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
