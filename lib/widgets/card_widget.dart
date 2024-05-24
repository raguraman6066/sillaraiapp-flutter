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
          SizedBox(
            height: 5,
          ),
          Text(
            coinsNames[widget.index].note,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
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
        String amount = '';
        String message = '';

        return AlertDialog(
          title: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              'Request Amount',
              style: TextStyle(
                  color: Theme.of(context).canvasColor, fontSize: 20),
            )),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Amount', border: OutlineInputBorder()),
                onChanged: (value) {
                  amount = value;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Message', border: OutlineInputBorder()),
                onChanged: (value) {
                  message = value;
                },
                maxLines: 3, // Allow multiline input
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _showToast(context);
                _updateFirestore();
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Your request has been sent.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _updateFirestore() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? mobileNumber=sharedPreferences.getString('mobileNumber');
    setState(() {
      isClicked = true;
    });

    // Update Firestore based on the index clicked
    if (widget.index == 0) {
      FirebaseFirestore.instance.collection('users').doc(mobileNumber).update({
        'isCoins': true,
      });
    } else if (widget.index == 1) {
      FirebaseFirestore.instance.collection('users').doc(mobileNumber).update({
        'isTen': true,
      });
    } else if (widget.index == 2) {
      FirebaseFirestore.instance.collection('users').doc(mobileNumber).update({
        'isTwinty': true,
      });
    }
  }
}

class Coin {
  final String imageUrl;
  final String note;

  Coin({required this.imageUrl, required this.note});
}

List<Coin> coinsList = [
  Coin(imageUrl: 'path_to_image', note: 'Note for image 1'),
  Coin(imageUrl: 'path_to_image', note: 'Note for image 2'),
  Coin(imageUrl: 'path_to_image', note: 'Note for image 3'),
];
