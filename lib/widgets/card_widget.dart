import 'package:flutter/material.dart';

import '../app_const.dart';
import '../pages/coins_request.dart';
import '../pages/note_request.dart';


class CardWidget extends StatefulWidget {
  final int index;

  CardWidget({Key? key, required this.index}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
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
              if (widget.index == 0) {
                _navigateToPage(context, CoinsRequestPage());
              } else {
                _navigateToPage(context, NotesRequestPage());
              }
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

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(_createRoute(page));
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
