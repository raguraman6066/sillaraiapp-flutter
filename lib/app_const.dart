import 'models/coin.dart';
import 'widgets/card_widget.dart';

const app_name="Coins App";

final List<Coin> coinsNames = [
  Coin(imageUrl: 'images/coins.jpeg', note: 'Coins'),
  Coin(imageUrl: 'images/notes.png', note: 'Notes'),
];

class Coin {
  final String imageUrl;
  final String note;

  Coin({required this.imageUrl, required this.note});
}
 const String packageName = 'com.kathiravanagency.sillaraiapp';