import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rupiya/themes/AppColor.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rupiya/ux/snackbars.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void _checkConnectivity() async {
      final connectionState = await Connectivity().checkConnectivity();
      switch (connectionState) {
        case ConnectivityResult.wifi:
          {
            ///this code snippet actually checks whether it has internet access or not
            try {
              final result = await InternetAddress.lookup('example.com');
              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                Navigator.pushNamed(context, '/sign_up_screen');
                print('connected');
              }
            } on SocketException catch (_) {
              print('not connected');
              showSnackBar(context,'No Internet Connection. Try again');
            }
            break;
          }
        case ConnectivityResult.mobile:
          {
            try {
              final result = await InternetAddress.lookup('example.com');
              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                Navigator.pushNamed(context, '/sign_up_screen');
                print('connected');
              }
            } on SocketException catch (_) {
              print('not connected');
              showSnackBar(context,'No Internet Connection. Try again');
            }
            break;
          }
        case ConnectivityResult.none:
          {
            showSnackBar(context,'No Internet Connection. Try again');
            break;
          }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding:
              EdgeInsets.only(left: 50.0, right: 50.0, top: 40.0, bottom: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Image.asset('images/start_page_image.png'),
              ),
              Column(
                children: [
                  Text('Expense',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center),
                  SizedBox(height: 20.0),
                  Text(
                    'Easily track your Monthly and Yearly expenses',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.lightTextColor,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.0),
              RawMaterialButton(
                splashColor: AppColor.textColor,
                onPressed: () {
                  _checkConnectivity();
                },
                padding: EdgeInsets.all(20.0),
                elevation: 0,
                fillColor: AppColor.buttonBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text('Get Started',
                    style: TextStyle(color: AppColor.bodyColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
