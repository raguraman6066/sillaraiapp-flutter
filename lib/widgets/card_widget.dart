import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_const.dart';

class CardWidget extends StatefulWidget {
  final int index;

  CardWidget({Key? key, required this.index}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isClicked = false;
  int quantity = 1; // Initial quantity

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            coinsNames[widget.index].imageUrl,
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.width * 0.28,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 5),
          Text(
            coinsNames[widget.index].note,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            child: Text(
              'Request',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            int amount = 0; // Initialize amount to 0
            int bundles20 = 0;
            int bundles10 = 0;
            if (widget.index == 0) {
              // For coins
              amount = quantity * 1000;
            } else {
              // For notes
              if (quantity <= 4) {
                amount = quantity * 1000;
                bundles20 = quantity;
              } else if (quantity == 5) {
                amount = 5000;
                bundles20 = 4;
                bundles10 = 1;
              } else if (quantity < 10) {
                amount = 4000 + (quantity - 4) * 1000;
                bundles20 = quantity;
                bundles10 = 1;
              } else if (quantity == 10) {
                amount = 10000;
                bundles20 = 8;
                bundles10 = 2;
              }
            }

            return AlertDialog(
              title: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Request Quantity',
                    style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                            });
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              if (quantity < 10) {
                                quantity++;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Total amount: ₹$amount',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                           SizedBox(height: 10,),
                    if (widget.index == 1) // Display bundle details only for notes
                      Column(
                        children: [
                          Text(
                            'Bundles of ₹20: $bundles20',
                            style: TextStyle(fontSize: 14),
                          ),
                          if (bundles10 > 0)
                            Text(
                              'Bundles of ₹10: $bundles10',
                              style: TextStyle(fontSize: 14),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: isClicked
                      ? null
                      : () async {
                          setState(() {
                            isClicked = true; // Show circular loading
                          });

                          // Hide keyboard
                          FocusScope.of(context).unfocus();

                          // Update Firestore
                          _updateFirestore(quantity);

                          // Simulate a delay (remove this line in your actual implementation)
                          await Future.delayed(Duration(seconds: 1));
                          setState(() {
                            isClicked = false; // Show circular loading
                          });
                          // Show toast and close dialog
                          _showToast(context);
                          Navigator.pop(context);
                        },
                  child: isClicked
                      ? CircularProgressIndicator()
                      : Text('Submit'), // Change label based on isClicked
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Your request has been sent.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _updateFirestore(int quantity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? mobileNumber = sharedPreferences.getString('mobileNumber');

    String requestType;
    if (widget.index == 0) {
      requestType = 'Coins';
    } else {
      requestType = 'Notes';
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(mobileNumber)
        .collection('requests')
        .add({
      'requestType': requestType,
      'quantity': quantity,
      'status': 'Pending',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

