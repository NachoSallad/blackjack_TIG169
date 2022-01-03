//fil där vi skall göra en sida för kort redigering
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:playing_cards/playing_cards.dart';
import 'card_themes.dart';
import 'blackjack.dart';

//TODO: finjustera balances storlek i theme
//TODO: Lagt till Context i 2 paranteser för att få bort errors

List<Widget> cardList = <Widget>[_card1(), _card2(), _card3()];

class CustomizationPage extends StatelessWidget {
  CustomizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: [
          _balance(context),
        ],
      ),
      body: Stack(
        children: [
          _card(),
          _changeDeckButton(context),
        ],
      ),
    );
  }

//widget för titlen
  Widget _title() {
    return Row(
      children: const [
        Text(
          'Card Customization',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

//widget för den aktuella balansen/saldot du har i appen
  Widget _balance(context) {
    //Lagt till Context i parantesen för att få bort error
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
                '${Provider.of<BlackJack>(context, listen: true).getBalance}'))
      ],
    );
  }

//pagecontroller för att kunna behålla koll på de olika sidorna
  PageController pageController = PageController(viewportFraction: 0.7);
  var value = 0;

//widget för kortet
  Widget _card() {
    return Align(
        alignment: const Alignment(0, -0.4),
        child: SizedBox(
            height: 350,
            width: 350,
            child: PageView(
              onPageChanged: (index) => {value = index},
              controller: pageController,
              children: cardList,
            )));
  }

// widget som returnerar en knapp som du trycker på
//för att ändra din valda kortlek till en ny kortlek
  Widget _changeDeckButton(context) {
    //Lagt till Context i parantesen för att få bort error
    return Align(
      alignment: const Alignment(0, 0.85),
      child: FractionallySizedBox(
        widthFactor: 0.6,
        heightFactor: 0.1,
        child: ElevatedButton(
          child: const Text('Choose this deck'),
          onPressed: () {
            if (value == 0) {
              Provider.of<PlayingCardsProvider>(context, listen: false)
                  .changePlayingCardsThemes('Standard');
            } else if (value == 1) {
              Provider.of<PlayingCardsProvider>(context, listen: false)
                  .changePlayingCardsThemes('StarWars');
            } else if (value == 2) {
              Provider.of<PlayingCardsProvider>(context, listen: false)
                  .changePlayingCardsThemes('Golden');
            }
          },
        ),
      ),
    );
  }
}

Widget _card1() {
  return Column(
    children: [
      FlatCardFan(
        children: [
          SizedBox(
            width: 200,
            height: 278,
            child: PlayingCardView(
              card: PlayingCard(Suit.hearts, CardValue.king),
              elevation: 10,
              showBack: true,
            ),
          ),
          SizedBox(
            width: 200,
            height: 278,
            child: PlayingCardView(
              card: PlayingCard(Suit.hearts, CardValue.king),
              elevation: 10,
            ),
          ),
        ],
      ),
      // const Divider(
      //   height: 50,
      // ),
      const Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(
          'Standard Deck',
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
      const Text(
        'Upplåst',
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      )
    ],
  );
}

Widget _card2() {
  return Column(
    children: [
      FlatCardFan(
        children: [
          SizedBox(
            width: 200,
            height: 278,
            child: PlayingCardView(
              card: PlayingCard(Suit.clubs, CardValue.king),
              showBack: true,
              elevation: 10,
            ),
          ),
          SizedBox(
            width: 200,
            height: 278,
            child: PlayingCardView(
              card: PlayingCard(Suit.clubs, CardValue.king),
              elevation: 10,
              style: PlayingCardsThemes.starWarsStyle,
            ),
          ),
        ],
      ),
      const Text(
        'Star Wars Edition',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      const Text(
        '10kr',
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      )
    ],
  );
}

Widget _card3() {
  return Column(
    children: [
      FlatCardFan(
        children: [
          SizedBox(
            width: 200,
            height: 278,
            child: PlayingCardView(
              card: PlayingCard(Suit.spades, CardValue.king),
              showBack: true,
              elevation: 10,
              style: PlayingCardsThemes.goldenStyle,
            ),
          ),
          SizedBox(
            width: 200,
            height: 278,
            child: PlayingCardView(
              card: PlayingCard(Suit.spades, CardValue.king),
              elevation: 10,
              style: PlayingCardsThemes.goldenStyle,
            ),
          ),
        ],
      ),
      const Text(
        'Golden Deck',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      const Text(
        '1 000 000kr',
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      )
    ],
  );
}
