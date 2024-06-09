import 'package:flutter/material.dart';
import 'package:homework_reminder_app/components/TaskCard.dart';
import 'package:homework_reminder_app/data.dart';
import 'package:homework_reminder_app/pages/AddTask.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return _Tasks();
  }
}

class _Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<_Tasks> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )
        ),
        backgroundColor: Color(0xFF5D557D),
      ),

      body: tasksList.isNotEmpty ? 
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: update ? _buildTaskCards() : _buildTaskCards(),
              )
            )
          )
        ) 
        : 
        Center(
          child: Text(
            "No tasks has created",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFD9D9D9)
            )
          )
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? refresh = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
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

  List<Widget> _buildTaskCards() {
    List<Widget> taskCards = [];

    for (List<dynamic> task in tasksList) {
      String taskName = task[0];
      DateTime dueDate = task[1];
      TimeOfDay dueTime = task[2];
      String priority = task[3];
      bool isChecked = task[4];

      DateTime? reminderDate = task[5][0];
      TimeOfDay? reminderTime = task[5][1];

      taskCards.add(
        TaskCard(
          title: taskName,
          dueDate: dueDate,
          dueTime: dueTime,
          priority: priority,
          isChecked: isChecked,
          onCheckboxChanged: (index, checked) => _handleCheckboxChanged(index, checked),
          reminderDate: reminderDate,
          reminderTime: reminderTime,
        ),
      );
    }

    return taskCards;
  }
}
