import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.initialValue,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.isSecret = false,
    this.isReadOnly = false,
    this.textInputFormatter,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.formFieldKey,
    this.enableSuggestions = true,
    this.textAlign,
  });

  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isSecret;
  final bool isReadOnly;
  final TextInputFormatter? textInputFormatter;
  final TextInputType? textInputType;
  final TextCapitalization textCapitalization;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final GlobalKey<FormFieldState>? formFieldKey;
  final bool enableSuggestions;
  final TextAlign? textAlign;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.controller,
        initialValue: widget.initialValue,
        readOnly: widget.isReadOnly,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        enableSuggestions: widget.enableSuggestions,
        textAlign: widget.textAlign ?? TextAlign.start,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                )
              : widget.suffixIcon != null
                  ? Icon(widget.suffixIcon)
                  : null,
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          isDense: true,
        ),
        inputFormatters: widget.textInputFormatter == null
            ? null
            : [
                FilteringTextInputFormatter.digitsOnly,
                widget.textInputFormatter!,
              ],
        keyboardType: widget.textInputType,
        textCapitalization: widget.textCapitalization,
      ),
    );
  }
}
