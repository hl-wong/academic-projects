import 'package:flutter/material.dart';

class CheckboxInput extends StatefulWidget {
  String label;
  bool isChecked;
  final Function(bool) onCheckboxChanged;

  CheckboxInput({required this.label, required this.isChecked, required this.onCheckboxChanged});

  @override
  _CheckboxInput createState() => _CheckboxInput();
}

class _CheckboxInput extends State<CheckboxInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isChecked, 
          onChanged: (bool? value) {
            widget.onCheckboxChanged(value ?? false);
          }
        ),

        SizedBox(width: 8),

        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          )
        )
      ],
    );
  }
}