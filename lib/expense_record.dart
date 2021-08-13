import 'package:flutter/material.dart';
import 'themes/AppColor.dart';


class ExpenseRecordListTile extends StatelessWidget {
  
  final description;
  final amount;
  final timestamp;
  final date;
  const ExpenseRecordListTile({
    Key key,
    this.description,
    this.amount,
    this.timestamp,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 10.0),
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.textColor,
              width: 2.0
            )
          ),
          child: CircleAvatar(
            backgroundColor: AppColor.bodyColor,
            child: Text(date,
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                ),
              ),
          ),
        ),
        title: Text(description),
        trailing: Text('Rs. $amount',style: TextStyle(
          color: AppColor.textColor,
          fontWeight: FontWeight.w500,
          fontSize: 15.0 
        )),
        subtitle: Text(timestamp),
      ),
    );
  }
}