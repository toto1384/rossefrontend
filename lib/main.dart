import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rosse/data/data.dart';
import 'data/web/webData.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/welcome_page.dart';
import 'utils/get_widget_utils.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget{

  
  static bool isDarkMode = false;
  static bool firstTime = true;
  static bool snapToEnd = true;
  static bool isEnglish = false;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<MyAppState>().restartApp();
  }

  @override
  MyAppState createState() {
    return MyAppState();
  }

}

class MyAppState extends State<MyApp>{

  Key key = new UniqueKey();

  void restartApp() {
    this.setState(() {
      key = new UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(kIsWeb){

      MyApp.isDarkMode=WebData.getDarkMode()??false;
      MyApp.firstTime = WebData.getTimesOpened()==0??false;
        
      return MaterialApp(
        title: 'Rosse',
        theme: getAppTheme(),
        darkTheme: getAppDarkTheme(),
        home: MyApp.firstTime?WelcomePage():HomePage(),
        debugShowCheckedModeBanner: false,
        themeMode: MyApp.isDarkMode?ThemeMode.dark:ThemeMode.light,
      );

    }else{

      return FutureBuilder(
        future: Data.initData(context),
        builder: (context,AsyncSnapshot<Data> snapshot){

          MyApp.isDarkMode=snapshot.hasData?snapshot.data.mobileData.dataHelper.getDarkMode():false;
          MyApp.firstTime = snapshot.hasData?snapshot.data.mobileData.dataHelper.getTimesOpened()==0:false;
            
            return MaterialApp(
              title: 'Rosse',
              theme: getAppTheme(),
              darkTheme: getAppDarkTheme(),
              home: snapshot.hasData?MyApp.firstTime?WelcomePage():HomePage():Center(child: CircularProgressIndicator(),),
              debugShowCheckedModeBanner: false,
              themeMode: MyApp.isDarkMode?ThemeMode.dark:ThemeMode.light,
          );
          
        },
      );

    }

  }

}
