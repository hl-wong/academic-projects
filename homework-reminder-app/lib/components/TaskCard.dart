import 'package:flutter/material.dart';
import 'package:homework_reminder_app/data.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatefulWidget {
  String title;
  DateTime dueDate;
  TimeOfDay dueTime;
  String priority;
  bool isChecked;
  final Function(int, bool) onCheckboxChanged;
  DateTime? reminderDate;
  TimeOfDay? reminderTime;

  TaskCard({required this.title, required this.dueDate, required this.dueTime, required this.priority, required this.isChecked, required this.onCheckboxChanged, this.reminderDate, this.reminderTime});

  @override
  _TaskCard createState() => _TaskCard();
}

class _TaskCard extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 10,
              decoration: BoxDecoration(
                color: widget.priority == "High" ? Colors.red : widget.priority == "Medium" ? Colors.orange : Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                )
              )
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Checkbox(
                        value: widget.isChecked, 
                        onChanged: (bool? value) {
                          int index = -1;
                          for (int i = 0; i < tasksList.length; i++) {
                            if (tasksList[i][0] == widget.title) {
                              index = i;
                              break;
                            }
                          }

                          if (index != -1) {
                            widget.onCheckboxChanged(index, value ?? false);
                          }
                        }
                      ),

                      SizedBox(width: 16),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        decoration: widget.isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                                      ),
                                    ),
                                                          
                                    Text(
                                      "${DateFormat('E, MMM dd, yyyy').format(widget.dueDate)}, ${widget.dueTime.hour}:${widget.dueTime.minute.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                        decoration: widget.isChecked ? TextDecoration.lineThrough : TextDecoration.none
                                      )
                                    ),
                                    
                                    Row(
                                      children: widget.reminderDate != null && widget.reminderTime != null ? [
                                        Icon(Icons.notifications),
                                        SizedBox(width: 8),
                                        Text("${DateFormat("MM/dd/yyyy").format(widget.reminderDate!)}, ${widget.reminderTime!.hour}:${widget.reminderTime!.minute.toString().padLeft(2, '0')}")
                                      ] : []
                                    )
                                  ]
                                ),
                              ),

                              IconButton(
                                onPressed: () {}, 
                                icon: Icon(Icons.edit_rounded)
                              )
                            ]
                          ),
                        ),
                      )
                    ],
                  )
                )
              ),
            )
          ]
        )
      )
    );
  }
}
