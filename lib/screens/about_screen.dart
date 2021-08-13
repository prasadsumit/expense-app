import 'package:flutter/material.dart';
import 'package:rupiya/themes/AppColor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.0),
                CircleAvatar(
                  child: Image.asset('images/sumit.png'),
                  radius: 70.0,
                ),
                SizedBox(height: 20.0),
                Text('Sumit Prasad',style: Theme.of(context).textTheme.headline2),
                SizedBox(height: 20.0),
                Text('Flutter Developer',
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 20.0),
                Text('Hi, I am Sumit. I am a 3rd year undegraduate in \n'+
                  'NIT Silchar. This is my first project based on a real life problem. I have been always overwhelmed by the experience and ease that '+
                  'Flutter provides. I hope you are satisfied with problem it tackles.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.darkTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 60.0,
                  child: Divider(
                    color: AppColor.lightTextColor,
                    thickness: 1.0,
                    endIndent: 60.0,
                    indent: 60.0,
                    ),
                  ),
                Text('Feel free to connect with me on',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.darkTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      iconSize: 25.0,
                      onPressed: () => Navigator.pushNamed(context, '/goto_facebook'),
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      ),
                      IconButton(
                      padding: EdgeInsets.all(0.0),
                      iconSize: 25.0,
                      onPressed: () => Navigator.pushNamed(context, '/goto_linkedin'),
                      icon: Icon(FontAwesomeIcons.linkedin),
                      ),
                ],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UrlWebView extends StatelessWidget {

  final String url;
  UrlWebView(this.url);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close_rounded,size: 25.0),
            ),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 30.0,
          title: Text(url,
          style: TextStyle(
              color: AppColor.bodyColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}