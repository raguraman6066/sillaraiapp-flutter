import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsRequestPage extends StatefulWidget {
  @override
  _CoinsRequestPageState createState() => _CoinsRequestPageState();
}

class _CoinsRequestPageState extends State<CoinsRequestPage> {
  int quantity = 1;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    int amount = quantity * 1000;
    int deliveryCharge = (amount * 0.01).round();

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Coins'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
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
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Total amount: ₹$amount',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              'Delivery charge: ₹$deliveryCharge',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isClicked
                  ? null
                  : () async {
                      setState(() {
                        isClicked = true;
                      });

                      await _updateFirestore(quantity, amount, deliveryCharge);

                      setState(() {
                        isClicked = false;
                      });

                  
                    },
              child: isClicked
                  ? CircularProgressIndicator()
                  : Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> _updateFirestore(int quantity, int amount, int deliveryCharge) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? mobileNumber = sharedPreferences.getString('mobileNumber');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(mobileNumber)
        .collection('requests')
        .add({
      'requestType': 'Coins',
      'quantity': quantity,
      'amount': amount,
      'deliveryCharge': deliveryCharge,
      'status': 'Pending',
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.of(context).pop(); // Close the current page
    _showSnackbar(context); // Show a snackbar
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request submitted successfully!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}
