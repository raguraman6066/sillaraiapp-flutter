import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class RequestHistory extends StatelessWidget {
  Future<String?> _getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobileNumber');
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMMM yyyy, hh:mm a').format(dateTime);
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

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(mobileNumber)
                .collection('requests')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var requests = snapshot.data!.docs;

              if (requests.isEmpty) {
                return Center(child: Text('No requests made yet.'));
              }
              return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  var request = requests[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text('Type: ${request['requestType']}'),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount: ${request['amount']}'),
                            Text('Status: ${request['status']}'),
                            Text('Date: ${_formatTimestamp(request['timestamp'])}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
