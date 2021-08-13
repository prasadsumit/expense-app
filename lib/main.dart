import 'package:flutter/material.dart';
import 'package:rupiya/models/authentication_service.dart';
import 'package:rupiya/models/database_service.dart';
import 'package:rupiya/screens/about_screen.dart';
import 'package:rupiya/screens/homescreen.dart';
import 'package:rupiya/themes/app_theme.dart';
import 'package:rupiya/screens/start_page.dart';
import 'package:rupiya/ux/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:rupiya/screens/sign_up.dart';
import 'package:rupiya/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rupiya/models/loading_model.dart';
import 'expense_record_list.dart';
import 'package:page_transition/page_transition.dart';


Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance) 
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(uid:FirebaseAuth.instance.currentUser.uid) 
        ),
        ChangeNotifierProvider<LoadingScreenModel>(
          create: (_) => LoadingScreenModel(),
        ),
      ],
      child: MaterialApp(
          home: AuthenticationWrapper(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          routes: <String, WidgetBuilder>{
            '/start_page': (BuildContext context) => StartPage(), 
            // '/home_screen': (BuildContext context) => HomeScreen(),
            '/loading_screen': (BuildContext context) => LoadingScreen(),
            // '/about_screen': (BuildContext context) => About(),
            // '/sign_up_screen' : (BuildContext context) => SignUpPage(),
            // '/login_screen' : (BuildContext context) => LoginPage(),
            // '/history_screen': (BuildContext context) => ExpenseRecordList(),
          },
          onGenerateRoute: (settings) {
            switch(settings.name) {
              case '/login_screen' : {
                return PageTransition(
                  child: LoginPage(),
                  childCurrent: SignUpPage(),
                  type: PageTransitionType.rightToLeftJoined,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                );
              }
              case '/sign_up_screen' : {
                return PageTransition(
                  child: SignUpPage(),
                  childCurrent: StartPage(),
                  type: PageTransitionType.rightToLeftJoined,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                );
              }
              case '/history_screen' : {
                return PageTransition(
                  child: ExpenseRecordList(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                );
              }
              case '/about_screen' : {
                return PageTransition(
                  child: About(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                );
              }
              case '/home_screen' : {
                return PageTransition(
                  child: HomeScreen(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                );
              }
              case '/start_page' : {
                return PageTransition(
                  child: StartPage(),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400),
                );
              }
              case '/goto_facebook' : {
                return PageTransition(
                  child: UrlWebView('https://www.facebook.com/profile.php?id=100040577715972'),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                );
              }
              case '/goto_linkedin' : {
                return PageTransition(
                  child: UrlWebView('https://www.linkedin.com/in/sumit-prasad-9b5022196/'),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                );
              }
              default:
                return null;
            }
          },
        ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final firebaseUser = context.watch<User>();
    if(firebaseUser != null) {
      return HomeScreen();
    }
    return StartPage();

  }
}