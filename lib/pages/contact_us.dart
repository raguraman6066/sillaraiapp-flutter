import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Email: saleskathiravanagenciestpt@gmail.com',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
               GestureDetector(
          onTap: () {
            openDialPad('+91-6369663834'); // Replace with your phone number
          },
          child: Text(
            'Phone: +91-6369663834', // Replace with your phone number
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue, // Change color to indicate it's clickable
              decoration: TextDecoration.underline, // Add underline to indicate it's clickable
            ),
          ),
        ),
      
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Tirupattur',
                  style: TextStyle(fontSize: 16),
                ),
              
               
              ],
            ),
          ),
        ),
      ),
    );
  }
openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
       print("Can't open dial pad.");
    }
}
}