import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sillaraiapp/pages/home_page.dart';
import 'package:sillaraiapp/pages/login_page.dart';
import 'app_const.dart';
import 'firebase_options.dart';
import 'providers/theme_provider.dart';
import 'theme.dart';
import 'util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<ThemeNotifier>(context);

    TextTheme textTheme = createTextTheme(context, "Poppins", "Open Sans");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$app_name',
      theme: darkTheme.isDarkTheme == true ? theme.dark() : theme.light(),
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) 
         {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return snapshot.data == true ? MyHomePage() : LoginPage();
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobileNumber') != null;
  }
}