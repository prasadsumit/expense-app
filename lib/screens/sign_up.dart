import 'package:flutter/material.dart';
import 'package:rupiya/themes/AppColor.dart';
import 'package:rupiya/models/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:rupiya/ux/snackbars.dart';
import 'package:rupiya/ux/loading_screen.dart';

//regular expression for checking email validity
final RegExp emailRegex = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20.0),
            Text('Hi there,\n\nWelcome to Expense.',style: Theme.of(context).textTheme.headline1),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Let\'s create an account',style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.lightTextColor),
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: AppColor.textColor,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!emailRegex.hasMatch(value))
                          return 'Not a valid email';
                        else if (value == null || value.isEmpty)
                          return 'This field can\'t be empty';
                        else
                          return null;
                      },
                      autofocus: false,
                      style: TextStyle(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
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
                    padding: EdgeInsets.fromLTRB(20.0, 5.0, 0, 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.lightTextColor),
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: passwordController,
                            cursorColor: AppColor.textColor,
                            obscureText: obscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'This field can\'t be empty';
                              else if(value.length < 6 || value.length > 12)
                                return 'Password should be between 6-12 characters';
                            /// TODO: make a strong password
                              else
                                return null;
                            },
                            autofocus: false,
                            style: TextStyle(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: 'Set a password',
                              hintStyle: TextStyle(
                                  color: AppColor.lightTextColor,
                                  fontWeight: FontWeight.w400),
                              contentPadding: EdgeInsets.all(0),
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        IconButton(
                          splashRadius: 20.0,
                          icon: Icon(Icons.remove_red_eye_rounded,color: obscurePassword ? AppColor.lightTextColor : AppColor.textColor,size: 20.0), 
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() => obscurePassword = !obscurePassword);
                          } 
                        ),
                      ],
                    ),
                  ),
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
                          var status = await context.read<AuthenticationService>().signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          if(status == 'Signed Up') {
                              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                            }
                          else if(status == 'email-already-in-use') {
                            setState(() => isLoading = !isLoading);
                            showSnackBar(context,'Email already in use. Please Login');
                          }
                          else if(status == 'auth/weak-password') {
                            setState(() => isLoading = !isLoading);
                            showSnackBar(context,'Weak Password');
                          }
                        }
                  },
                  padding: EdgeInsets.all(20.0),
                  elevation: 0,
                  fillColor: AppColor.buttonBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Register',style: TextStyle(color: AppColor.bodyColor)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/login_screen'),
                  child: Text('Already have an account? Login',style: TextStyle(color: AppColor.textColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
