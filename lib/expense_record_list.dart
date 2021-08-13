import 'package:flutter/material.dart';
import 'expense_record.dart';
import 'models/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'themes/AppColor.dart';
import 'other/date_time.dart';

class ExpenseRecordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    Date today;

    return Container(
      height: size.height,
      width: size.width,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History',
          textAlign: TextAlign.justify,
            style: TextStyle(color: AppColor.textColor),
          ),
          
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService(uid: firebaseUser.uid).userRecordStream(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      final expenseList = snapshot.data.docs;
                      return ListView.builder(
                        itemCount: expenseList.length,
                        itemBuilder: (context, index) {
                          var data = expenseList[index];
                          today = Date(date: data['created'].toDate());
                          today.getDate();
                          return ExpenseRecordListTile(
                            description: data['Description'],
                            amount: data['Amount'],
                            timestamp: today.monthYearTime,
                            date: today.day,
                            );
                        }
                        );
                    } else {
                        return Card(
                              color: AppColor.bodyColor,
                              elevation: 2.0,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: SizedBox(
                                height: 70.0,
                                child: Center(child: Text('Your recent entries will appear here.',
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ),
                              ),
                            );
                    } 
                  }
                ),
          ),
        ),
      ),
    );
  }
}
