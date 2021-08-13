import 'package:flutter/material.dart';
import 'package:rupiya/themes/AppColor.dart';

class MoneyContainer extends StatelessWidget {

  final String money;
  final String calender;
  MoneyContainer({this.money,this.calender});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColor.buttonBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
          Text(money,
            style: TextStyle(
              color: AppColor.bodyColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(calender,
          style: TextStyle(
              color: AppColor.bodyColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w200,
              letterSpacing: 3.0,
            ),
          )
        ],
      ),
    );
  }
}
