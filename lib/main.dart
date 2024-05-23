import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_const.dart';
import 'pages/contact_us.dart';
import 'providers/theme_provider.dart';
import 'theme.dart';
import 'util.dart';
import 'widgets/card_widget.dart';

void main() {
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
      title: '$app_name',
      theme: darkTheme.isDarkTheme == true ? theme.dark() : theme.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, _) => IconButton(
              onPressed: () {
                themeNotifier.toggleTheme();
              },
              icon: Icon(Icons.g_translate),
            ),
          ),
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, _) => IconButton(
              onPressed: () {
                themeNotifier.toggleTheme();
              },
              icon: Icon(Icons.dark_mode),
            ),
          ),
        ],
        title: Text('Coins App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.amber,
                    // backgroundImage: AssetImage(
                    //     'assets/profile_image.jpg'), // Provide your image path
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '+91-9089786756',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // You can navigate to the home page here if you have one
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // You can navigate to the home page here if you have one
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // You can navigate to the home page here if you have one
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ContactUsPage(),
                    transitionDuration: Duration(milliseconds: 400),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5),
        itemCount: coinsList.length, // Number of cards

        itemBuilder: (context, index) {
          return CardWidget(index: index);
        },
      ),
    );
  }





}


class Coin {
  final String imageUrl;
  final String note;

  Coin({required this.imageUrl, required this.note});
}