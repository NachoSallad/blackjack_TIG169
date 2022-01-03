// klass med en IF sats som returnerar regler och kortvärden

import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'deck_of_cards.dart';

class RuleText {
  Widget returnRules(String chosenRules) {
    if (chosenRules == 'How to play') {
      return const Text(
          ' The goal of blackjack is for you to beat the dealer’s hand without going over 21 in value \n \n \n The face cards is worth 10 in value and the Aces is worth 1 or 11, depends on the situation \n \n \n Before the round starts you make your bet \n \n \n The round starts with the player (you) and the dealer gets two cards, one of the dealer’s cards is facing down, the other one is visible \n \n \n You have the choice to “hit” (asking for another card) or “stand” (you do not want to get any more cards) \n \n \n If the value of your cards are over 21, then you are bust and the dealer wins the round regardless of the dealer’s hand \n \n \n The dealer needs to draw until the value is 17 or higher \n \n \n Doubling means you double the bet and can only get one more card for this round \n \n \n Split is only possible if you have two of the same card. The pair is split into two hands and it also doubles the bet, both hands get the original bet \n \n \n If both the player (you) and the dealer gets the same value, then it’s a draw and you will get your bet back \n \n \n');
    } else if (chosenRules == 'Card values') {
      return _valueCards();
    } else {
      return const Text('');
    }
  }

//TODO:FIXA TILL KORT LISTAN
// Widget valueCards() {
//   return ListView(
//     children: [
//       SizedBox(
//         height: 140,
//         width: 100,
//         child: Column(
//           children: [
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.ace)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.king)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.queen)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.jack)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.ten)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.nine)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.eight)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.seven)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.six)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.five)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.four)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.three)),
//             PlayingCardView(card: PlayingCard(Suit.hearts, CardValue.two)),
//           ],
//         ),
//       ),
//     ],
//   );
// }

//widget för att visa alla kort och dess värden
  Widget _valueCards() {
    List<Widget> cardsAndText = <Widget>[];
    for (int i = 0; i <= 12; i++) {
      PlayingCard card = PlayingCard(Suit.diamonds, CardValue.values[i]);
      bool aceTest = false;
      if (card.value == CardValue.ace) {
        aceTest = true;
      } else {
        aceTest = false;
      }
      cardsAndText.add(
        Row(
          children: [
            SizedBox(
              width: 80,
              height: 100,
              child: PlayingCardView(card: card),
            ),
            aceTest
                ? const Text('=1 or 11')
                : Text('=${DeckOfCards().valueOfCard(card)}'),
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: cardsAndText.sublist(0, 7),
        ),
        Column(
          children: cardsAndText.sublist(7, 13),
        ),
      ],
    );
  }
}
