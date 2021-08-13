import 'package:flutter/material.dart';
import 'package:rupiya/themes/AppColor.dart';

void showSnackBar(BuildContext context,String status) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(SnackBar(
        content: Text(
          status,
          style: TextStyle(color: AppColor.bodyColor),
        ),
      ));
    }