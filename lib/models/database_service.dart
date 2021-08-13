import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

final firebaseUser = FirebaseAuth.instance.currentUser;
final streamController = StreamController();

class DatabaseService {

  final String uid;
  List<String> monthlyCalender = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
  DatabaseService({this.uid});

  
  CollectionReference userData = FirebaseFirestore.instance.collection('User Data');
  CollectionReference userRecord = FirebaseFirestore.instance.collection('User Record');
  


  Future updateUserData(String year, String month, int amount)  async{
    
    try {
      await userData.doc(uid).collection(year).doc(month).update({
        'value': FieldValue.increment(amount)
      });
      return 'ok';
    } catch (e) {
      // check later if the future fails, then what to return
      print("updateuserData failed because: ${e.toString()}");
      return e.toString();
    }
  }

  Future initializeUserData(String year) async{
    try { 
      for(String month in monthlyCalender) {
        await userData.doc(uid).collection(year).doc(month).set({'value':0});
      }
      return 'ok';
    } catch (e) {
      // check later if the future fails, then what to return
      print("initializeuserData failed because: ${e.toString()}");
      return e.toString();
    }
  }

  Future updateUserRecord(String description, String amount) async {
    try {
      await userRecord.doc(uid).collection('Expense History').doc().set({
        'Description': description,
        'Amount': amount,
        'created': FieldValue.serverTimestamp()
      });
      return 'ok';
    } catch (e) {
      print("updateUserRecord failed because: ${e.toString()}");
      return e.toString();
    }
  }

  Stream<DocumentSnapshot> monthlyExpenseStream (String year, String month) {
    if(firebaseUser!=null)
      return userData.doc(uid).collection(year).doc(month).snapshots();
    else 
      return null;
  }

  Stream<QuerySnapshot> userRecordStream () {
    if(firebaseUser!=null)
      return userRecord.doc(uid).collection('Expense History').orderBy('created',descending: true).snapshots();
    else 
      return null;
    
  }

  Stream<QuerySnapshot> getYearlyExpenseStream(String year) {
    if(firebaseUser!=null) {
      return userData.doc(uid).collection(year).where('value',isGreaterThan: 0).snapshots();
    } else {
      return null;
    }  
    
  }

  // getters are declared without parameters list
  // Stream<DocumentSnapshot> get categoryListfromDocument {
  //   if(firebaseUser!=null) {
  //     return categoryCollectionReference.doc(uid).snapshots();
  //   }
  //   else {
  //     return null;
  //   }
      
  // }
  
}
