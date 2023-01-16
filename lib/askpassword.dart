import 'package:ac_demo/lockScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class askpassword extends StatefulWidget {
  const askpassword({Key? key}) : super(key: key);

  @override
  State<askpassword> createState() => _askpasswordState();
}

class _askpasswordState extends State<askpassword> {

  TextEditingController t=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpassword();
  }
  getpassword() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('password');
    if(action==null)
      {
        print("password not set");
      }
    else{
      print("password set");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return lockScreen();
      },));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(controller: t,),
          ElevatedButton(onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('password', t.text);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return lockScreen();
            },));
          }, child: Text("Submit"))
        ],
      ),

    );
  }
}
