import 'package:flutter/material.dart';
import 'package:rupiya/themes/AppColor.dart';
import 'package:rupiya/ux/alertdialogs.dart';
import 'package:rupiya/models/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final firebaseUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Container(
        height: size.height,
        width: size.width,
        color: AppColor.bodyColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColor.textColor),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(firebaseUser.displayName ?? 'Sumit',
                        style: TextStyle(
                          color: AppColor.bodyColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(firebaseUser.email,
                        style: TextStyle(
                          color: AppColor.bodyColor,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) =>editUsernameAlert(context));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit_rounded ,color: AppColor.textColor,size: 20.0),
                        SizedBox(width: 20.0),
                        Text('Edit Username',style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.photo_rounded ,color: AppColor.textColor,size: 20.0),
                        SizedBox(width: 20.0),
                        Text('Choose Avatar',style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/history_screen'),
                    child: Row(
                      children: [
                        Icon(Icons.history_rounded ,color: AppColor.textColor,size: 20.0),
                        SizedBox(width: 20.0),
                        Text('History',style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/about_screen'),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline_rounded,color: AppColor.textColor,size: 20.0),
                        SizedBox(width: 20.0),
                        Text('About me',style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthenticationService>().signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout_rounded,color: AppColor.textColor,size: 20.0),
                        SizedBox(width: 20.0),
                        Text('Log Out',style: Theme.of(context).textTheme.headline4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
