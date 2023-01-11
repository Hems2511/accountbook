import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'MyDatabase.dart';

class Controller extends GetxController{
  MyDatabase myDatabase=MyDatabase();
  RxList list=[].obs;
  RxList templist=[].obs;
  RxList trans_list=[].obs;
  RxString gvalue="credit".obs;
  String r1="credit";
  String r2="debit";
  RxInt credit=0.obs;
  RxInt debit=0.obs;
  RxInt total=0.obs;
  RxInt credit1=0.obs;
  RxInt debit1=0.obs;
  RxInt total1=0.obs;
  RxList creditlist=[].obs;
  RxList debitlist=[].obs;
  RxList totallist=[].obs;
  getacc() {
    //select * from account join accnt_trans on account.id=accnt_trans.acid where account.id=1
    myDatabase.createdb().then((value) {
      String q="select * from account";
      value.rawQuery(q).then((value){
       list.value=value;
       list.forEach((element) {
         getaccbyid(element['id']);
       });
      });
      // print("list=$list");
    });
  }
  getaccbyid(int id) {

    //select * from account join accnt_trans on account.id=accnt_trans.acid where account.id=1
    myDatabase.createdb().then((value) {
      String q="select * from account join accnt_trans on account.id=accnt_trans.acid where account.id=$id";
      value.rawQuery(q).then((value){
        credit1.value=0;
        debit1.value=0;
        total1.value=0;
        templist.value=value;
        templist.forEach((element) {
          print(element['amount']);
          if(element['type']=="credit")
          {
            credit1.value=credit1.value+element['amount'] as int;
          }
          if(element['type']=="debit")
          {
            debit1.value=debit1.value+element['amount'] as int;
          }
        });
        total1.value=credit1.value-debit1.value;
        creditlist.add(credit1.value);
        debitlist.add(debit1.value);
        totallist.add(total1.value);
      });
      // print("templist=${templist.value}");
    });
  }
  get_transaction(int id) {
    credit.value=0;
    debit.value=0;

    myDatabase.createdb().then((value) {
      String q="select * from accnt_trans where acid=$id";
      value.rawQuery(q).then((value){
        trans_list.value=value;
        trans_list.forEach((element) {
          print(element['amount']);
          if(element['type']=="credit")
          {
            credit.value=credit.value+element['amount'] as int;
          }
          if(element['type']=="debit")
          {
            debit.value=debit.value+element['amount'] as int;
          }
        });
        print(credit.value);
        print(debit.value);

        total.value=credit.value-debit.value;
      });
      print(trans_list.value);
    });
  }
  insert(String name)
  {
    myDatabase.createdb().then((value) {
      String q="insert into account values (null,'$name')";
      value.rawInsert(q).then((value){
        print(value);
        if(value>=1)
          {
            getacc();
          }
      });
    });
  }
  update_transaction(String date,String amount,String type,String reason,int id,int acid)
  {
    //acid INTEGER, date TEXT, amount INTEGER,type TEXT,reason TEXT
    myDatabase.createdb().then((value) {
      String q="update accnt_trans set date='$date',amount='$amount',type='$type',reason='$reason' where id='$id'";
      value.rawUpdate(q).then((value){
        print(value);
        if(value==1)
        {
          get_transaction(acid);
        }
      });
    });
  }
  insert_transaction(String date,String amount,String type,String reason,int id)
  {
    //id INTEGER PRIMARY KEY, acid INTEGER, date TEXT, amount INTEGER,type TEXT,reason TEXT
    myDatabase.createdb().then((value) {
      String q="insert into accnt_trans values (null,'$id','$date','$amount','$type','$reason')";
      value.rawInsert(q).then((value){
        print(value);
        if(value>=1)
        {
          get_transaction(id);
        }
      });
    });
  }
  delete_transaction(int id,int acid)
  {
    //id INTEGER PRIMARY KEY, acid INTEGER, date TEXT, amount INTEGER,type TEXT,reason TEXT
    myDatabase.createdb().then((value) {
      String q="delete from accnt_trans where id=$id";
      value.rawInsert(q).then((value){
        print(value);
        if(value>=1)
        {
          get_transaction(acid);
        }
      });
    });
  }
  update_acc(String name,int id)
  {
    myDatabase.createdb().then((value) {
      String q="update account set name='$name' where id=$id";
      value.rawUpdate(q).then((value){
        print(value);
        if(value==1)
        {
          getacc();
        }
      });
    });
  }
}