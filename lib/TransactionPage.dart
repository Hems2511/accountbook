import 'package:ac_demo/Account.dart';
import 'package:ac_demo/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller.dart';

class TransactionPage extends StatelessWidget {
  TextEditingController date=TextEditingController();
  TextEditingController amount=TextEditingController();
  TextEditingController reason=TextEditingController();
  Account a;
  TransactionPage(this.a);
  Controller c=Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    if(a!=null)
      {
        c.get_transaction(a.id!);
      }
    return Scaffold(
      appBar: AppBar(
        title: Text("${a.name}"),
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Add Transaction"),
                actions: [
                  TextButton(onPressed: () {
                    c.insert_transaction(date.text, amount.text, c.gvalue.value, reason.text, a.id!);
                    date.text="";
                    amount.text="";
                    reason.text="";
                    Navigator.pop(context);
                    }, child: Text("OK")),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Cancel")),
                ],
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    TextField(
                      controller:date,
                      readOnly: true,
                      onTap: () {
                        showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000,1,1),
                            lastDate: DateTime(2030,1,1)).then((value) {
                           print(value);
                           date.text="${value!.day}/${value.month}/${value.year}";
                        });

                      },
                    ),
                    TextField(controller:amount,),
                    Obx(() => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Radio(value:c.r1, groupValue: c.gvalue.value, onChanged: (value) {
                            c.gvalue.value=c.r1;
                          },),
                          Text("Credit"),
                          Radio(value: c.r2, groupValue: c.gvalue.value, onChanged: (value) {
                            c.gvalue.value=c.r2;
                          },),
                          Text("Debit"),
                        ]),),
                    TextField(controller:reason,),
                  ],),
                )
              );

            },);

          }, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Date"),
            Text("Reason"),
            Text("Credit"),
            Text("Debit"),
          ],),
          Obx(() => ListView.builder(shrinkWrap:true,itemCount:c.trans_list.length,
            itemBuilder: (context, index) {
              Transaction t=Transaction.fromMap(c.trans_list.value[index]);
              print(t);
              return InkWell(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return SimpleDialog(
                      children: [
                        TextButton(onPressed: () {
                          date.text=t.date;
                          amount.text='${t.amount}';
                          reason.text=t.reason;
                          c.gvalue.value=t.type;
                          Navigator.pop(context);
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                                title: Text("Add Transaction"),
                                actions: [
                                  TextButton(onPressed: () {
                                    c.update_transaction(date.text, amount.text, c.gvalue.value, reason.text, t.id,a.id!);
                                    date.text="";
                                    amount.text="";
                                    reason.text="";
                                    Navigator.pop(context);
                                  }, child: Text("OK")),
                                  TextButton(onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text("Cancel")),
                                ],
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller:date,
                                        readOnly: true,
                                        onTap: () {
                                          showDatePicker(context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000,1,1),
                                              lastDate: DateTime(2030,1,1)).then((value) {
                                            print(value);
                                            date.text="${value!.day}/${value.month}/${value.year}";
                                          });

                                        },
                                      ),
                                      TextField(controller:amount,),
                                      Obx(() => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Radio(value:c.r1, groupValue: c.gvalue.value, onChanged: (value) {
                                              c.gvalue.value=c.r1;
                                            },),
                                            Text("Credit"),
                                            Radio(value: c.r2, groupValue: c.gvalue.value, onChanged: (value) {
                                              c.gvalue.value=c.r2;
                                            },),
                                            Text("Debit"),
                                          ]),),
                                      TextField(controller:reason,),
                                    ],),
                                )
                            );

                          },);
                        }, child: Text("Edit")),
                        TextButton(onPressed: () {
                          c.delete_transaction(t.id, a.id!);
                          Navigator.pop(context);
                        }, child: Text("Delete")),
                      ],
                    );
                  },);
                  //
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${t.date}"),
                    Text("${t.reason}"),
                    t.type=="credit"?Text("${t.amount}"):Text("0"),
                    t.type=="debit"?Text("${t.amount}"):Text("0"),
                  ],
                ),
              );
            },))
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => Text("Credit:${c.credit}")),
          Obx(() => Text("Debit:${c.debit}")),
          Obx(() => Text("Total:${c.total}")),

        ],
      )
    );
  }
}
