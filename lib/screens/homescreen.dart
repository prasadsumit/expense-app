import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rupiya/models/database_service.dart';
import 'package:rupiya/models/loading_model.dart';
import 'package:rupiya/themes/AppColor.dart';
import 'package:rupiya/other/money_container.dart';
import 'package:provider/provider.dart';
import 'package:rupiya/other/date_time.dart';
import 'package:rupiya/screens/side_drawer.dart';
import 'package:rupiya/ux/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rupiya/expense_record.dart';

final descRegEx = new RegExp(r"[.!%#$%&'*<>();:+/=?^_`{|\[\]}~-]");

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // declared this key globally which caused an exception, 'Multiple keys using the same global key'
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void dispose() { 
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final isLoading = context.watch<LoadingScreenModel>().isLoading;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    Date today = Date(date: DateTime.now());
    today.getDate();
    
    return Container(
      height: size.height,
      width: size.width,
      child:isLoading ? LoadingScreen() : Scaffold(
        key: _scaffoldKey,
        drawer: SideDrawer(),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      alignment: Alignment.centerLeft,
                      splashRadius: 80.0,
                      iconSize: 25.0,
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      icon: Icon(Icons.menu_rounded),
                    ),
                    Text('Expense',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: DatabaseService(uid:firebaseUser.uid).monthlyExpenseStream(today.year, today.month),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                              return MoneyContainer(
                              money: snapshot.data['value'].toString(),
                              calender: today.month,
                              );
                          } else {
                              return MoneyContainer(
                              money: '0',
                              calender: today.month,
                              );
                          }
                        }
                      ),
                    ),
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService(uid: firebaseUser.uid).getYearlyExpenseStream(today.year),
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              int yearlyExpense = 0;
                              snapshot.data.docs.forEach((DocumentSnapshot doc) {
                                  yearlyExpense = yearlyExpense + doc['value'];
                               });
                              return MoneyContainer(
                                money: yearlyExpense.toString() ?? 0,
                                calender: today.year,
                              );
                            } else {
                              return MoneyContainer(
                                money: '0',
                                calender: today.year,
                              );
                            }
                          }
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text('  Add Expense',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.headline2),
                SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    padding:EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.lightTextColor),
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle),
                    child: TextFormField(
                      controller: descriptionController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                          if(value==null || value.isEmpty) {
                            return 'This field can\'t be empty';
                          } 
                          else if(descRegEx.hasMatch(value)) {
                            return 'Symbols are not allowed';
                          }
                          else {
                            return null;
                          }
                      },
                      cursorColor: AppColor.textColor,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      style: TextStyle(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintText: 'Enter Description',
                        hintStyle: TextStyle(
                            color: AppColor.lightTextColor,
                            fontWeight: FontWeight.w400),
                        contentPadding: EdgeInsets.all(0),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                SizedBox(height: 20.0),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    padding:EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.lightTextColor),
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle),
                    child: TextFormField(
                      controller: amountController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                          if(value==null || value.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          else {
                            try {
                              var integer = int.parse(value);
                              return null;
                            } catch (e) {
                              return 'Invalid Amount';
                            }
                          }
                      },
                      cursorColor: AppColor.textColor,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      style: TextStyle(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        hintStyle: TextStyle(
                            color: AppColor.lightTextColor,
                            fontWeight: FontWeight.w400),
                        contentPadding: EdgeInsets.all(0),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  )
                    ]
                  ),
                ),
                SizedBox(height: 40.0),
                Consumer<LoadingScreenModel>(
                  builder: (_,loadingscreenmodel,child) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: RawMaterialButton(
                      splashColor: AppColor.textColor,
                        onPressed: () async{
                          if(_formKey.currentState.validate()) {
                            
                            loadingscreenmodel.loadingScreen();
                            int amount = int.parse(amountController.text.trim());
                            var dataUpdated = await DatabaseService(uid: firebaseUser.uid).updateUserData(today.year, today.month, amount);
                            var recordUpdated = await DatabaseService(uid: firebaseUser.uid).updateUserRecord(descriptionController.text.trim(), amountController.text.trim());
                            
                            if(dataUpdated == 'ok' && recordUpdated == 'ok') {
                              loadingscreenmodel.loadingScreen();
                            } else {
                              loadingscreenmodel.loadingScreen();
                              print('failed!!');
                            }
                          }
                        },
                        padding: EdgeInsets.all(20.0),
                        elevation: 0,
                        fillColor: AppColor.buttonBackgroundColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: Text('ADD',style: TextStyle(color: AppColor.bodyColor)),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text('  Recently Added',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.headline2),
                SizedBox(height: 20.0),
                StreamBuilder<QuerySnapshot>(
                    
                    stream: DatabaseService(uid: firebaseUser.uid).userRecordStream() ?? null,
                    builder: (context, snapshot) {

                      if(snapshot.hasData) {
                        final expenseList = snapshot.data.docs;
                        if(expenseList.length >= 2) {
                          var data = expenseList[0];
                          var data2 = expenseList[1];
                          var today1 = Date(date: data['created'].toDate());
                          var today2 = Date(date: data2['created'].toDate());
                          today1.getDate();
                          today2.getDate();
                          return Column(
                            children: [
                              Card(
                                color: AppColor.bodyColor,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                elevation: 2.0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal:15.0),
                                  child: ExpenseRecordListTile(
                                        description: data['Description'],
                                        amount: data['Amount'],
                                        timestamp: today1.monthYearTime,
                                        date: today1.day,
                                        ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Card(
                                color: AppColor.bodyColor,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                elevation: 2.0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal:15.0),
                                  child: ExpenseRecordListTile(
                                        description: data2['Description'],
                                        amount: data2['Amount'],
                                        timestamp: today2.monthYearTime,
                                        date: today2.day,
                                        ),
                                      ),
                                    ),
                                  ],
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
                    
              ],
            ),
          ),
        )),
      ),
    );
  }
}


