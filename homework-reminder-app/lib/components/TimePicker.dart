import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  String label;
  String? placeholder;
  IconData? icon;
  final ValueChanged<TimeOfDay>? onTimeSelected;

  TimePicker({required this.label, this.placeholder, this.icon, this.onTimeSelected});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TextEditingController _controller = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectTime = await showTimePicker(
      context: context, 
      initialTime: selectedTime,
    );
    if (selectTime != null && selectTime != selectedTime) {
      setState(() {
        selectedTime = selectTime;
        _controller.text = "${selectedTime.format(context)}";
      });
    }
    if (widget.onTimeSelected != null) {
      widget.onTimeSelected!(selectedTime);
    }
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
          ),
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: OutlineInputBorder(),
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
            suffixIcon: Icon(Icons.arrow_drop_down)
          ),
          readOnly: true,
          controller: _controller,
          onTap: () => _selectTime(context),
        )
      ]
    );
  }
}