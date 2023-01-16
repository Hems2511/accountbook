import 'package:ac_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class lockScreen extends StatefulWidget {
  const lockScreen({Key? key}) : super(key: key);

  @override
  State<lockScreen> createState() => _lockScreenState();
}

class _lockScreenState extends State<lockScreen> {
  String ans="0000";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpassword();
  }
  getpassword() async {
    final prefs = await SharedPreferences.getInstance();
    ans = prefs.getString('password')!;
    setState(() {

    });
   print("ans=$ans");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScreenLock(
        // context: context,
        correctString: ans,
        maxRetries: 2,
        onMaxRetries: (value) {
          print(value);

        },
        footer: Text("Hello"),
        onValidate:  (input) async {
          print(input);
         if(input==ans)
           {
             return await Future.value(true);
           }
         else
           {
             return await Future.value(false);
           }
        },
        deleteButton: IconButton(icon: Icon(Icons.add),onPressed: () {

      },),
        onCancelled: () {

        },
        cancelButton: IconButton(icon: Icon(Icons.cancel),onPressed: () {

        },),
        onUnlocked: () {
          print("hello");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return MyApp();
          },));
        },
      ),
    );
  }
}
