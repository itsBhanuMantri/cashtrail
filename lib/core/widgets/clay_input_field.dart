import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClayInputField extends StatefulWidget {
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

  const ClayInputField({
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
  });

  @override
  State<ClayInputField> createState() => _ClayInputFieldState();
}

class _ClayInputFieldState extends State<ClayInputField> {
  final FocusNode _focusNode = FocusNode();

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
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.indigo.shade400, width: 2),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 0,
                      bottom: 4,
                    ),
                    child: Text(
                      widget.labelText,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
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
                                  maxLines: widget.maxLines,
                                  minLines: widget.minLines,
                                  decoration: InputDecoration(
                                    isDense: true,
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
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
