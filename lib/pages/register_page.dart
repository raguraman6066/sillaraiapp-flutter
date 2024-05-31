import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sillaraiapp/pages/home_page.dart';
import 'package:sillaraiapp/pages/login_page.dart';
class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  bool _isRegistering = false;

  void _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isRegistering = true;
      });

      String userName = _userNameController.text.trim();
      String mobileNumber = _mobileNumberController.text.trim();
      String address = _addressController.text.trim();
      String pincode = _pincodeController.text.trim();

      try {
        var existingUserQuery = await FirebaseFirestore.instance
            .collection('users')
            .where('mobileNumber', isEqualTo: mobileNumber)
            .get();

        if (existingUserQuery.docs.isNotEmpty) {
          throw 'User with this mobile number already exists.';
        } else {
          await FirebaseFirestore.instance
            .collection('users')
            .doc(mobileNumber)
            .set({
          'userName': userName,
          'mobileNumber': mobileNumber,
          'address': address,
          'pincode': pincode,
   
          });

          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("mobileNumber", mobileNumber);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        }
      } catch (error) {
        setState(() {
          _isRegistering = false;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Failed'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your user name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _mobileNumberController,
                  
                  decoration: const InputDecoration(
                    prefix: Text('+91 '),
                    
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
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
                SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _pincodeController,
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pincode';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isRegistering ? null : () => _registerUser(context),
                  child: _isRegistering ? CircularProgressIndicator() : Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
          bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Have an account?'),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LoginPage(),
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
              child: Text('Login'))
        ],
      ),
   
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _mobileNumberController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }
}
