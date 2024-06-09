import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homework_reminder_app/pages/MainScreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomePage();
  }
}

class _HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/task_reminder_illustration.svg',
                height: 350,
                width: 350,
              ),

              Text(
                "Homework Reminder App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )
              ),

              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 48,
                    right: 48,
                    bottom: 32,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => MainScreen())
                      );
                    }, 
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF5D557D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                    )
                  ),
                ),
              )
            ]
          )
        )
      )
    );
  }
}

// class _HomePageState extends State<_HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.red,
//               width: 1,
//             )
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Homework Reminder App",
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
          
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context, 
//                     MaterialPageRoute(builder: (context) => MainScreen())
//                   );
//                 },
//                 child: Text("Main Screen")
//               )
//             ],
//           ),
//         )
//       )
//     );
//   }
// }