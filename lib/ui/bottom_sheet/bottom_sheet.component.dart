import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final void Function() firstOnClick;
  final void Function() secondOnClick;

  const CustomBottomSheet({
    required this.firstLabel,
    required this.secondLabel,
    required this.firstOnClick,
    required this.secondOnClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 8,
          ),
          const Divider(
            height: 4,
            endIndent: 80,
            indent: 80,
          ),
          const SizedBox(
            height: 32,
          ),
          OutlinedButton.icon(
            style: const ButtonStyle(
              fixedSize: MaterialStatePropertyAll(
                Size(
                  200,
                  40,
                ),
              ),
            ),
            onPressed: firstOnClick,
            icon: const Icon(
              Icons.camera,
            ),
            label: Text(
              firstLabel,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          OutlinedButton.icon(
            style: const ButtonStyle(
              fixedSize: MaterialStatePropertyAll(
                Size(
                  200,
                  40,
                ),
              ),
            ),
            onPressed: secondOnClick,
            icon: const Icon(
              Icons.photo,
            ),
            label: Text(
              secondLabel,
            ),
          ),
        ],
      ),
    );
  }
}
