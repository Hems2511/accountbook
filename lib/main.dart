import 'package:ac_demo/Controller.dart';
import 'package:ac_demo/MyDatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'Account.dart';
import 'TransactionPage.dart';

void main() {
  runApp(GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  TextEditingController t1=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Controller c=Get.put(Controller());
    c.getacc();
    return Scaffold(
      appBar: AppBar(),
      body: (Obx(() =>ListView.builder(itemCount:c.list.length,
        itemBuilder: (context, index) {
          Account a=Account.frommap(c.list.value[index]);
          print(c.creditlist);
          print(c.debitlist);
          return InkWell(
            onTap: () {
              Get.to(TransactionPage(a));
            },
            child: Column(
             children: [
               Row(
                 children: [
                   Expanded(child: Text("${a.name}")),
                   IconButton(onPressed: () {
                     showDialog(context: context, builder: (context) {
                       t1.text=a.name!;
                       return AlertDialog(
                         title: Text("Update Account"),
                         content: TextField(controller: t1,),
                         actions: [
                           TextButton(onPressed: () {
                             c.update_acc(t1.text,a.id!);
                             Navigator.pop(context);
                             t1.text="";
                           }, child: Text("OK")),
                           TextButton(onPressed: () {
                             Navigator.pop(context);
                           }, child: Text("Cancel")),
                         ],
                       );
                     },);
                   }, icon: Icon(Icons.edit)),
                   IconButton(onPressed: () {
                   }, icon: Icon(Icons.delete)),
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Obx(() => Text("Credit:${c.creditlist[index]}")),
                   Obx(() => Text("Debit:${c.debitlist[index]}")),
                   Obx(() => Text("Total:${c.totallist[index]}")),
                 ],
               )
             ],
            ),
          );
        },),)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("Add new Account"),
              content: TextField(controller: t1,),
              actions: [
                TextButton(onPressed: () {
                  c.insert(t1.text);
                  Navigator.pop(context);
                  t1.text="";
                }, child: Text("OK")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Cancel")),
              ],
            );
          },);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

