import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;

  const CustomAlertDialog({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(
                'Close',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
