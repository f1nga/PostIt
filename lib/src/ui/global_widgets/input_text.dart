import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/icons.dart';
import 'custom_form.dart';

/// Input text widget class
class InputText extends StatefulWidget {
  final Widget? prefixIcon;
  final String? Function(String)? validator;
  final bool obscureText;
  final void Function(String)? onchanged;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String labelText;

  const InputText({
    super.key,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onchanged,
    this.onSubmitted,
    this.textInputAction,
    this.keyboardType,
    required this.labelText,
  });

  @override
  State<InputText> createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  String? _errorText = "";
  late bool _obscureText;
  CustomFormState? _formState;

  String? get errorText => _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formState = CustomForm.of(context);
      _formState?.register(this);
    });
  }

  @override
  void deactivate() {
    _formState?.remove(this);
    super.deactivate();
  }

  /// Function that is called every time the input text change and validate the text
  /// @param {String} The input text
  void _validate(String text) {
    if (widget.validator != null) {
      _errorText = widget.validator!(text);
      setState(() {});
    } else {
      _errorText = null;
    }

    if (widget.onchanged != null) {
      widget.onchanged!(text);
    }
  }

  /// Function that is called when the view password button is clicked and change the text state
  void _onVisibleChange() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: tertiaryColor,
              )),
      child: TextField(
        onChanged: _validate,
        obscureText: _obscureText,
        onSubmitted: widget.onSubmitted,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        cursorColor: tertiaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? MaterialButton(
                  minWidth: 25,
                  padding: const EdgeInsets.all(10),
                  onPressed: _onVisibleChange,
                  child: Icon(
                    _obscureText ? viewPasswordIcon : unviewPasswordIcon,
                    color: tertiaryColor,
                  ),
                )
              : widget.validator != null
                  ? Icon(
                      Icons.check_circle,
                      color: _errorText == null ? success : tertiaryColor,
                    )
                  : null,
        ),
      ),
    );
  }
}
