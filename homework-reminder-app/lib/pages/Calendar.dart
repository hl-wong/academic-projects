import 'package:flutter/material.dart';
import 'package:homework_reminder_app/components/TaskCard.dart';
import 'package:homework_reminder_app/data.dart';
import 'package:homework_reminder_app/pages/AddTask.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return _Calendar();
  }
}

class _Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<_Calendar> {
  bool update = false;

  void changeData() {
    setState(() {
      update = true;
    });
  }

  void _handleCheckboxChanged(int index, bool checked) {
    setState(() {
      tasksList[index][4] = checked;
    });
  }

  DateTime currentDay = DateTime.now();

  DateTime selectedDay = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDay = day;
    });
  }

  List<Widget> _buildTaskCards(DateTime selectedDay) {
    List<Widget> taskCards = [];

    for (List<dynamic> task in tasksList) {
      String taskName = task[0];
      DateTime dueDate = task[1];
      TimeOfDay dueTime = task[2];
      String priority = task[3];
      bool isChecked = task[4];

      DateTime? reminderDate = task[5][0];
      TimeOfDay? reminderTime = task[5][1];

      if (selectedDay.year == dueDate.year && 
          selectedDay.month == dueDate.month &&
          selectedDay.day == dueDate.day) {
        
        taskCards.add(
          TaskCard(
            title: taskName,
            priority: priority,
            isChecked: isChecked,
            dueDate: dueDate,
            dueTime: dueTime,
            onCheckboxChanged: (index, checked) {
              _handleCheckboxChanged(index, checked);
            },
            reminderDate: reminderDate,
            reminderTime: reminderTime,
          ),
        );
      }
    }

    return taskCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calendar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )
        ),
        backgroundColor: Color(0xFF5D557D),
      ),
      body: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1,
                  )
                )
              ),
              child: TableCalendar(
                focusedDay: selectedDay, 
                firstDay: currentDay, 
                lastDay: DateTime.utc(currentDay.year + 10, currentDay.month, currentDay.day),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
              ),
            ),

            Expanded(
              child: _buildTaskCards(selectedDay).isNotEmpty ? 
                ListView(
                  padding: EdgeInsets.all(16.0),
                  children: _buildTaskCards(selectedDay)
                ) 
                : 
                Center(
                  child: Text(
                    "No tasks on that selected day",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFD9D9D9)
                    )
                  )
                )
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? refresh = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask())
          );

          if (refresh == 'refresh') {
            changeData();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF5D557D),
        shape: CircleBorder(),
      ),
    );
  }
}