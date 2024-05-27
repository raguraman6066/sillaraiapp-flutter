import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class RequestHistoryPage extends StatelessWidget {
  Future<String?> _getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobileNumber');
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMMM yyyy hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request History'),
      ),
      body: FutureBuilder<String?>(
        future: _getMobileNumber(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          String? mobileNumber = snapshot.data;
          if (mobileNumber == null) {
            return Center(child: Text('No mobile number found.'));
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(mobileNumber)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var userDoc = snapshot.data!;
              var amount = userDoc['amount'] ?? '';
              var message = userDoc['message'] ?? '';
              var status = userDoc['status'] ?? 'N/A';
              var timestamp = userDoc['timestamp'] ?? Timestamp.now();

              if (amount.isEmpty) {
                return Center(child: Text('No requests made yet.'));
              }

              return ListView(
                children: [
                  Card(
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Amount: $amount'),
                          Text('Message: $message'),
                          Text('Date: ${_formatTimestamp(timestamp)}'),
                          Text('Status: $status'),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
