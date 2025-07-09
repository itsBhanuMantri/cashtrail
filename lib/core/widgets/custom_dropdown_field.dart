import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'category_dialog.dart';
import 'clay_input_field.dart';

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.optionsWidget,
  });

  final String labelText;
  final Function(String) onChanged;
  final Widget Function() optionsWidget;
  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClayInputField(
      labelText: widget.labelText,
      controller: controller,
      readOnly: true,
      suffixIcon: Icon(Icons.arrow_drop_down),
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => widget.optionsWidget()),
            )
            .then((value) {
              if (value != null) {
                controller.text = value;
                widget.onChanged(value);
              }
            });
      },
    );

    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.arrow_drop_down),
      ),
      controller: controller,
      readOnly: true,
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => widget.optionsWidget()),
            )
            .then((value) {
              if (value != null) {
                controller.text = value;
                widget.onChanged(value);
              }
            });
      },
    );
  }
}
