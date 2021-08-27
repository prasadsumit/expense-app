import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rupiya/themes/AppColor.dart';
import 'package:rupiya/models/authentication_service.dart';
import 'package:rupiya/ux/snackbars.dart';
import 'package:rupiya/ux/loading_screen.dart';

 //regular expression for checking email validity
    final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final emailController = TextEditingController();

  bool isLoading = false; 
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return isLoading ? LoadingScreen() : Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40.0,),
            Center(child: Text('Reset Password',style: Theme.of(context).textTheme.headline2)),
            SizedBox(height: 20.0,),
            Text('A reset link will be sent to your email. Go to the link provided in the email to reset your password',style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 40.0,),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.lightTextColor),
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle),
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                      if(!emailRegex.hasMatch(value))
                        return 'Not a valid email';
                      else if(value==null || value.isEmpty) 
                        return 'This field can\'t be empty';
                      else 
                        return null;
                    },
                      cursorColor: AppColor.textColor,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      style: TextStyle(
                          color: AppColor.textColor, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                            color: AppColor.lightTextColor,
                            fontWeight: FontWeight.w400),
                        contentPadding: EdgeInsets.all(0),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0,),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RawMaterialButton(
                  splashColor: AppColor.textColor,
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                          setState(() => isLoading = !isLoading);
                          var status = await context.read<AuthenticationService>().resetPassword(
                            email: emailController.text.trim(),
                            );
                          if(status == 'Sent') { 
                              setState(() => isLoading = !isLoading);
                              showSnackBar(context,'Request sent. Check your email.');
                            }
                          else {
                              setState(() => isLoading = !isLoading);
                              showSnackBar(context,'Request sent failed. Try again');
                          }
                        }
                      },
                    padding: EdgeInsets.all(20.0),
                    elevation: 0,
                    fillColor: AppColor.buttonBackgroundColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Text('Send Request',style: TextStyle(color: AppColor.bodyColor)),
                  )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
