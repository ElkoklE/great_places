import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:great_places/models/place_location.model.dart';
import 'package:great_places/providers/user_places.provider.dart';
import 'package:great_places/ui/alert_dialog.component.dart';
import 'package:great_places/ui/image_input/image_input.component.dart';
import 'package:great_places/ui/location_input/location_input.component.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new place',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text(
                  'Title',
                ),
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ImageInput(onPickImage: (image) {
              _selectedImage = image;
            }),
            const SizedBox(
              height: 16,
            ),
            LocationInput(onSelectLocation: (location) {
              _selectedLocation = location;
            }),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Add place'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const CustomAlertDialog(title: 'Title is empty!'),
      );
      return;
    } else if (enteredText.trim().length <= 8) {
      showDialog(
        context: context,
        builder: (context) =>
            const CustomAlertDialog(title: 'Title is too short!'),
      );
      return;
    } else if (enteredText.trim().length >= 50) {
      showDialog(
        context: context,
        builder: (context) =>
            const CustomAlertDialog(title: 'Title is too long!'),
      );
      return;
    } else if (_selectedImage == null || _selectedLocation == null) {
      showDialog(
        context: context,
        builder: (context) =>
            const CustomAlertDialog(title: 'There is no picture or location!'),
      );
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(
          title: enteredText,
          image: _selectedImage!,
          location: _selectedLocation!,
        );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
