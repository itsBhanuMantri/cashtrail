import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputField extends StatefulWidget {
  final String? hintText;
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  const AppInputField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.autofocus = false,
    this.maxLines,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.onSubmitted,
    this.textInputAction,
  });

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  final FocusNode _focusNode = FocusNode();
  double borderWidth = 1;
  Color borderColor = Colors.grey.shade400;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          borderWidth = 1;
          borderColor = Colors.indigo.shade400;
        });
      } else {
        setState(() {
          borderWidth = 1;
          borderColor = Colors.grey.shade400;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: widget.readOnly,
                      onTap: widget.onTap,
                      controller: widget.controller,
                      focusNode: _focusNode,
                      autofocus: widget.autofocus,
                      keyboardType: widget.keyboardType,
                      inputFormatters: widget.inputFormatters,
                      maxLines: widget.maxLines ?? 1,
                      minLines: widget.minLines,
                      textInputAction:
                          widget.textInputAction ?? TextInputAction.done,
                      onSubmitted: (value) {
                        print('bhanu onSubmitted $value');
                        widget.onSubmitted?.call(value);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: widget.hintText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                      ),
                      style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.suffixIcon != null) widget.suffixIcon!,
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
