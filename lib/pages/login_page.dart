import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sillaraiapp/pages/home_page.dart';
import 'package:sillaraiapp/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(child: LoginForm()),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Don\'t have an account?'),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        RegisterForm(),
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
              child: Text('Register'))
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _mobileNumberController = TextEditingController();
  bool _loading = false;
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                
                focusNode: _focusNode,
                controller: _mobileNumberController,
                decoration: InputDecoration(
                   prefix: Text('+91 '),
                    labelText: 'Mobile Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  } else if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _focusNode.unfocus();
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });

                    String mobileNumber = _mobileNumberController.text.trim();

                    var userQuery = await FirebaseFirestore.instance
                        .collection('users')
                        .where('mobileNumber', isEqualTo: mobileNumber)
                        .get();

                    if (userQuery.docs.isNotEmpty) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('mobileNumber', mobileNumber);

                      Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    MyHomePage(),
                            transitionDuration: Duration(milliseconds: 400),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                          (route) => false);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Login Failed'),
                          content: Text(
                              'User with this mobile number does not exist.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }

                    setState(() {
                      _loading = false;
                    });
                  }
                },
                child: _loading
                    ? CircularProgressIndicator()
                    : Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }
}
