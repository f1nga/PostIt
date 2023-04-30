import 'package:flutter/material.dart';

import 'input_text.dart';

class CustomForm extends StatefulWidget {
  final Widget child;

  const CustomForm({
    super.key,
    required this.child,
  });

  @override
  State<CustomForm> createState() => CustomFormState();

  static CustomFormState? of(BuildContext context) {
    return context.findAncestorStateOfType<CustomFormState>();
  }
}

class CustomFormState extends State<CustomForm> {
  final Set<InputTextState> _fields = <InputTextState>{};

  /// Function that validates every input text in the form
  /// @returns {boolean} Returns true if the every input text is correct
  bool validate() {
    bool isOk = true;
    for (final InputTextState item in _fields) {
      if (item.errorText != null) {
        isOk = false;
        break;
      }
    }

    return isOk;
  }

  void register(InputTextState field) {
    _fields.add(field);
  }

  void remove(InputTextState field) {
    _fields.remove(field);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
