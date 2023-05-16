import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/home_tab/home_tab_controller.dart';

import '../../utils/colors.dart';
import 'package:provider/provider.dart';

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
    final HomeTabController controller = context.watch<HomeTabController>();

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: controller.focusNode.hasFocus ? primaryColor : tertiaryColor, // Color del borde
          width: 1.0, // Ancho del borde
        ),
        borderRadius: BorderRadius.circular(10), // Radio de borde
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textFieldController,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: controller.focusNode.hasFocus ? "¿Qué estás buscando?" : "Buscar en PostIt",
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
            icon: controller.focusNode.hasFocus
                ? const Icon(closeIcon)
                : const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
