import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  String label;
  String? placeholder;
  IconData? icon;
  final ValueChanged<DateTime>? onDateSelected;

  DateSelector({required this.label, this.placeholder, this.icon, this.onDateSelected});

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  TextEditingController _controller = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, 
      firstDate: DateTime.now(), 
      lastDate: DateTime.utc(DateTime.now().year + 10),
    );
    if (selectDate != null && selectDate != selectedDate) {
      setState(() {
        selectedDate = selectDate;
        _controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(selectedDate);
      }
    }
  }

  // if previous page is Calendar, automatically set the date selected from Calendar page to Add Task page.
  // @override
  // void initState() {
  //   super.initState();
  //   _controller.text = "${selectedDate.toLocal()}".split(' ')[0];
  //   if (widget.onDateSelected != null) {
  //     widget.onDateSelected!(DateTime.now());
  //   }
  // }

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
            suffixIcon: Icon(Icons.arrow_drop_down)
          ),
          readOnly: true,
          controller: _controller,
          onTap: () => _selectDate(context),
        )
      ],
    );
  }
}