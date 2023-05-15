import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/icons.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.textFieldController,
    required this.onPressed,
    required this.onSubmitted,
    required this.onChanged,
    this.focusNode,
  });

  final TextEditingController textFieldController;
  final Function(String)? onChanged, onSubmitted;
  final VoidCallback onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      height: 40,
      decoration: BoxDecoration(
        color: tertiaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textFieldController,
              onChanged: onChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: "Buscar en PostIt",
              ),
              textInputAction: TextInputAction.search,
              focusNode: focusNode,
              onSubmitted: onSubmitted,
            ),
          ),
          IconButton(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.zero,
            splashColor: transparentColor,
            onPressed: onPressed,
            icon: textFieldController.text != ""
                ? const Icon(closeIcon)
                : const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
