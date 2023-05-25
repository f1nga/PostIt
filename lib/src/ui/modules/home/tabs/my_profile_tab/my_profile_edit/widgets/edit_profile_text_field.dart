import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final TextInputType textInputType;

  const EditProfileTextField({
    super.key,
    required this.label,
    required this.textController,
    this.textInputType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: label),
              controller: textController,
              keyboardType: textInputType,
            ),
          ),
          IconButton(
            onPressed: () => textController.clear(),
            icon: const Icon(
              Icons.close,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
