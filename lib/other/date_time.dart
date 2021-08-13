import 'package:intl/intl.dart';

class Date {

    // var date = DateTime.now();
    final date;
    Date({this.date});
    var day,month,year,dateFormat,monthYearTime,dateTime;

    void getDate() {
       day = DateFormat.d().format(date);
       month = DateFormat.MMM().format(date).toUpperCase();
       year = DateFormat.y().format(date);
       dateFormat = DateFormat.yMMMd().format(date);
       monthYearTime = DateFormat.yMMM().add_Hm().format(date);
       dateTime = DateFormat.yMMMd().add_Hm().format(date);
    }
    
}