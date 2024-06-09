import 'package:flutter/material.dart';

class DropdownInput extends StatefulWidget {
  String label;
  String? placeholder;
  IconData? icon;
  List<String> items;
  final Function(String)? onChanged;

  DropdownInput({required this.label, this.placeholder, this.icon, required this.items, this.onChanged});

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          )
        ),
        SizedBox(height: 12),
        DropdownButtonFormField<String>(
          items: widget.items.map((String priority) {
            return DropdownMenuItem(
              value: priority,
              child: Text(priority),
            );
          }).toList(), 
          onChanged: (String? value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value!);
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(widget.icon),
          ),
          hint: Text("${widget.placeholder}"),
          iconDisabledColor: Colors.black,
        )
      ]
    );
  }
}