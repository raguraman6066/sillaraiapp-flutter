import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_const.dart';
import '../providers/theme_provider.dart';
import '../widgets/card_widget.dart';
import 'contact_us.dart';
import 'login_page.dart';
import 'request_history.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int localVersion = 1; // Local version code
  late int firestoreVersion = 0; // Firestore version code
  late String userName = ''; // Initialize with an empty string
  late String mobileNumber = '';
  @override
  void initState() {
    super.initState();
    getMobileNumber().then((value) {
      getUserInfo(mobileNumber);
    });
    checkVersion();
  }

  Future<void> getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileNumber = prefs.getString('mobileNumber') ??
          ''; // Get mobile number from SharedPreferences
    });
  }

  Future<void> getUserInfo(String mobileNumber) async {
    try {
      var userQuery = await FirebaseFirestore.instance
          .collection('users')
          .doc(mobileNumber)
          .get();
print(userQuery);
      if (userQuery.exists) {
        setState(() {
          userName = userQuery.get('userName');
          mobileNumber = userQuery.get('mobileNumber');
        });
      } else {
        // Handle the case where the user document does not exist
      }
    } catch (error) {
      print('Error fetching user information: $error');
      // Handle the error appropriately
    }
  }

  void _launchPlayStore() async {
    const url = 'https://play.google.com/store/apps/details?id=$packageName';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  

  Future<void> checkVersion() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('app_info') // Adjust the collection name
              .doc('version') // Adjust the document name
              .get();

      setState(() {
        firestoreVersion = snapshot.get('appVersion');
      });

      if (firestoreVersion > localVersion) {
        // Show an alert dialog
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Update Available'),
              content: Text(
                  'A new version of the app is available. Please update to the latest version.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _launchPlayStore();
                  },
                  child: Text('Update'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error checking version: $error');
    }
  }

  late FirebaseMessaging _firebaseMessaging;

  Future<void> _storeFCMToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', token);
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Consumer<ThemeNotifier>(
          //   builder: (context, themeNotifier, _) => IconButton(
          //     onPressed: () {
          //       themeNotifier.toggleTheme();
          //     },
          //     icon: Icon(Icons.g_translate),
          //   ),
          // ),
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
                    child: Icon(Icons.person,size: 50,color: Colors.white,),
                    // backgroundImage: AssetImage(
                    //     'assets/profile_image.jpg'), // Provide your image path
                  ),
                  SizedBox(height: 5),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    mobileNumber,
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
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Request History'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestHistory()),
                );
              },
            ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.person),
            //   title: Text('About Us'),
            //   onTap: () {
            //     Navigator.pop(context); // Close the drawer
            //   },
            // ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _launchURL(context);
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
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _logout(context);
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
        itemCount: coinsNames.length, // Number of cards
        itemBuilder: (context, index) {
          return CardWidget(index: index);
        },
      ),
    );
  }
    _launchURL(BuildContext context) async {
    const url = 'https://raguraman6066.github.io/sillarai-app-privacy-policy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
    }
  }
}
