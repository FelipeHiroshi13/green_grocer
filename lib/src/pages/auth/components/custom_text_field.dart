import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final bool isInputNumber;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {Key? key,
      required this.icon,
      required this.label,
      this.isSecret = false,
      this.isInputNumber = false,
      this.inputFormatters})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        keyboardType:
            widget.isInputNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            suffix: widget.isSecret
                ? InkWell(
                    child: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onTap: () {},
                  )
                : null,
            labelText: widget.label,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
