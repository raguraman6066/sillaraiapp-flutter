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

  bool _isRegistering = false; // Flag to track registration state

  void _registerUser(BuildContext context) async {
      _focusNode1.unfocus(); 
      _focusNode2.unfocus(); 
      _focusNode3.unfocus(); 
      _focusNode4.unfocus(); 
  try {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isRegistering = true;
      });

      String userName = _userNameController.text.trim();
      String mobileNumber = _mobileNumberController.text.trim();
      String address = _addressController.text.trim();
      String pincode = _pincodeController.text.trim();

      // Check if user with the same mobile number already exists
      var existingUserQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('mobileNumber', isEqualTo: mobileNumber)
          .get();

      if (existingUserQuery.docs.isNotEmpty) {
        // User already exists with the same mobile number
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Failed'),
            content: Text('User with this mobile number already exists.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        
        // User does not exist, proceed with registration
        await FirebaseFirestore.instance.collection('users').doc(mobileNumber).set({
          'userName': userName,
          'mobileNumber': mobileNumber,
          'address': address,
          'pincode': pincode,
        'isCoins':'false',
        'isTen':'false',
        'isTwinty':'false',
        });
        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
sharedPreferences.setString("mobileNumber", mobileNumber);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }
  } catch (error) {
    print('Error registering user: $error');
    // Handle error here
  } finally {
    setState(() {
      _isRegistering = false;
    });
  }
}

FocusNode _focusNode1 = FocusNode();
FocusNode _focusNode2 = FocusNode();
FocusNode _focusNode3 = FocusNode();
FocusNode _focusNode4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                        focusNode: _focusNode1,

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
                        focusNode: _focusNode2,

                controller: _mobileNumberController,
                decoration: const InputDecoration(
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
                        focusNode: _focusNode3,

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
                        focusNode: _focusNode4,

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
                onPressed: _isRegistering
                    ? null
                    : () {
                        _registerUser(context);
                      },
                child: _isRegistering
                    ? CircularProgressIndicator() // Show loader if registering
                    : Text('Register'),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account?'),
          TextButton(onPressed: (){
Navigator.push(
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
          }, child: Text('Login'))
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
