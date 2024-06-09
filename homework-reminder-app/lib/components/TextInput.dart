import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  String label;
  String? placeholder;
  IconData? icon;
  final Function(String)? onChanged;

  TextInput({required this.label, this.placeholder, this.icon, this.onChanged});
  
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        TextField(
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: OutlineInputBorder(),
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          ),
          controller: _controller,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          }
        )
      ],
    );
  }
}