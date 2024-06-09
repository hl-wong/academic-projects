import 'package:flutter/material.dart';
import 'package:homework_reminder_app/components/CheckboxInput.dart';
import 'package:homework_reminder_app/components/DateSelector.dart';
import 'package:homework_reminder_app/components/DropdownInput.dart';
import 'package:homework_reminder_app/components/TextInput.dart';
import 'package:homework_reminder_app/components/TimePicker.dart';
import 'package:homework_reminder_app/data.dart';
import 'package:homework_reminder_app/notification.dart';

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _AddTask();
  }
}

class _AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<_AddTask> {
  String? taskName;
  DateTime? dueDate;
  TimeOfDay? dueTime;

  String? selectedPriority;
  List<String> priority = ['High', 'Medium', 'Low'];

  bool isButtonEnabled = false;

  bool reminderIsChecked = false;
  void _handleCheckboxChanged(bool checked) {
    setState(() {
      reminderIsChecked = checked;
    });
  }

  DateTime? reminderDate;
  TimeOfDay? reminderTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )
        ),
        backgroundColor: Color(0xFF5D557D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        )
      ),
      
      body: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextInput(
                  label: "Task Name",
                  placeholder: "Enter your task name",
                  icon: Icons.task_rounded,
                  onChanged: (value) {
                    taskName = value;
                    _updateButtonState();
                  }
                ),
          
                SizedBox(height: 24),
                DateSelector(
                  label: "Due Date",
                  placeholder: "Select due date",
                  icon: Icons.calendar_month_rounded,
                  onDateSelected: (value) {
                    dueDate = value;
                    _updateButtonState();
                  }
                ),
          
                SizedBox(height: 24),
                TimePicker(
                  label: "Due Time",
                  placeholder: "Select due time",
                  icon: Icons.access_time_filled_rounded,
                  onTimeSelected: (value) { 
                    dueTime = value;
                    _updateButtonState();
                  }
                ),
          
                SizedBox(height: 24),
                DropdownInput(
                  label: "Priority",
                  placeholder: "Select priority",
                  icon: Icons.flag,
                  items: priority,
                  onChanged: (value) {
                    selectedPriority = value;
                    _updateButtonState();
                  }
                ),

                SizedBox(height: 24),
                CheckboxInput(
                  label: "Reminder", 
                  isChecked: reminderIsChecked, 
                  onCheckboxChanged: (checked) { 
                    _handleCheckboxChanged(checked);
                    _updateButtonState();
                  }
                ),

                Column(
                  children: reminderIsChecked ? [
                    SizedBox(height: 16),
                    DateSelector(
                      label: "Date",
                      placeholder: "Select reminder date",
                      onDateSelected: (value) { 
                        reminderDate = value; 
                        _updateButtonState();
                      },
                      icon: Icons.calendar_month_rounded,
                    ),

                    SizedBox(height: 24),
                    TimePicker(
                      label: "Time",
                      placeholder: "Select reminder time",
                      onTimeSelected: (value) {
                        reminderTime = value;
                        _updateButtonState();
                      },
                      icon: Icons.access_time_filled_rounded,
                    )
                  ] : []
                )
              ],
            )
          ),
        )
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ElevatedButton(
          child: Text(
            "Create",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: isButtonEnabled ? () => addTask(taskName!, dueDate!, dueTime!, selectedPriority!, reminderDate, reminderTime) : null,
          style: ElevatedButton.styleFrom(
            primary: isButtonEnabled ? Color(0xFF5D557D) : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
          )
        )
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _isInputValid();
    });
  }

  bool _isInputValid() {
    if (taskName != null && taskName!.isNotEmpty && dueDate != null && dueTime != null && selectedPriority != null) {
      if (reminderIsChecked != true) {
        return true;
      }
      else {
        if (reminderDate != null && reminderTime != null) {
          return true;
        }
        else {
          return false;
        }
      }
    }
    else {
      return false;
    }
  }

  void addTask(String taskName, DateTime dueDate, TimeOfDay dueTime, String selectedPriority, DateTime? reminderDate, TimeOfDay? reminderTime) {
    List<dynamic> newTask = [taskName, dueDate, dueTime, selectedPriority, false, [reminderDate, reminderTime]];

    // if user have checked reminder checkbox, and set reminder date and time
    if (reminderDate != null && reminderTime != null) {
      DateTime reminderDateTime = DateTime(
        reminderDate.year, 
        reminderDate.month, 
        reminderDate.day, 
        reminderTime.hour, 
        reminderTime.minute
      );

      // schedule the notification
      NotificationHelper.scheduleNotification(
        id: reminderId, 
        title: taskName,
        body: "This is a scheduled reminder from Homework Reminder App", 
        reminderDateTime: reminderDateTime
      );

      // increment whenever a reminder have set
      reminderId++;
    }

    // add newTask array into Tasks array as nested array
    tasksList.add(newTask);
    Navigator.pop(context, 'refresh');
  }
}