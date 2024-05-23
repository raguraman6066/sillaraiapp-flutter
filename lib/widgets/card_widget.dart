import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../app_const.dart';

class CardWidget extends StatelessWidget {
  final int index;

  CardWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         // FancyShimmerImage(
          //  imageUrl: coinsList[index].imageUrl,
          Image.asset(
             coinsList[index].imageUrl,
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.width * 0.28,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 5,
          ),
          Text(coinsList[index].note,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
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
            decoration: BoxDecoration(color: Theme.of(context).dividerColor,borderRadius: BorderRadius.circular(20)),
            child: Center(child: Text('Enter Amount',style: TextStyle(color: Theme.of(context).canvasColor,fontSize: 20),))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                
                decoration: InputDecoration(labelText: 'Amount',border: OutlineInputBorder()),
                onChanged: (value) {

                  amount = value;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message',border: OutlineInputBorder()),
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
                // Submit request logic here
                _showToast(context, amount, message);
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showToast(BuildContext context, String amount, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Your request has been sent.'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class Coin {
  final String imageUrl;
  final String note;

  Coin({required this.imageUrl, required this.note});
}
