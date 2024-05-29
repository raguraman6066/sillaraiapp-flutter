import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesRequestPage extends StatefulWidget {
  @override
  _NotesRequestPageState createState() => _NotesRequestPageState();
}

class _NotesRequestPageState extends State<NotesRequestPage> {
  int selectedOption = 0; // Initialize with the index of the first option
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    int amount = 0;
    List<Map<String, dynamic>> bundleOptions = [
      {'amount': 5000, 'bundles20': 2, 'bundles10': 1},
      {'amount': 7000, 'bundles20': 3, 'bundles10': 1},
      {'amount': 10000, 'bundles20': 4, 'bundles10': 2}
    ];

    if (selectedOption >= 0 && selectedOption < bundleOptions.length) {
      amount = bundleOptions[selectedOption]['amount'];
    }

    int deliveryCharge = (amount * 0.01).ceil(); // Calculating 1% of the total amount as delivery charge

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select bundle option:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...List.generate(
                  bundleOptions.length,
                  (index) => CheckboxListTile(
                    title: Text(
                      '₹${bundleOptions[index]['amount']}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '₹20 bundle(${bundleOptions[index]['bundles20']}) + ₹10 bundle(${bundleOptions[index]['bundles10']})',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: selectedOption == index,
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          selectedOption = index;
                        } else {
                          selectedOption = -1; // Deselect option
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Total amount:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '₹$amount',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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

                      await _updateFirestore(amount, deliveryCharge);

                      setState(() {
                        isClicked = false;
                      });

                      Navigator.of(context).pop();
                      _showSnackbar(context);
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

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _updateFirestore(int amount, int deliveryCharge) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? mobileNumber = sharedPreferences.getString('mobileNumber');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(mobileNumber)
        .collection('requests')
        .add({
      'requestType': 'Notes',
      'amount': amount,
      'deliveryCharge': deliveryCharge,
      'status': 'Pending',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
