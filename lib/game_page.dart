import 'package:flutter/material.dart';
import 'package:my_first_app/settings_page.dart';
import 'package:provider/provider.dart';
import 'blackjack.dart';
import 'package:playing_cards/playing_cards.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool showDealerCard = false;
  bool splitTurn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //kolla läget
        appBar: AppBar(
          leading: PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'New Game',
                child: Text('New Game'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                value: 'Forfeit',
                child: Text('Forfeit'),
              ),
              const PopupMenuItem<String>(
                value: 'Quit to main menu',
                child: Text('Quit to main menu'),
              ),
            ],
            onSelected: (String choice) {
              switch (choice) {
                case 'New Game':
                  {
                    //startar ett nytt spel
                    break;
                  }
                case 'Settings':
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Settings(),
                        ));
                    //ska ta dig till inställningssidan
                    break;
                  }
                case 'Forfeit':
                  {
                    //du ger upp, får tillbaka halva insatsen
                    break;
                  }
                case 'Quit to main menu':
                  {
                    //forfeitar och quittar till main
                    Navigator.pop(context);
                    break;
                  }
              }
            },
          ),
          actions: [
            Consumer(
                builder: (context, state, child) => Text(
                    '${Provider.of<BlackJack>(context, listen: true).getBalance}'))
          ],
        ),
        body: Stack(children: [
          startNewGame(),
          Consumer<BlackJack>(
              builder: (context, state, child) => winOrLosePopUp(
                  Provider.of<BlackJack>(context, listen: false).getSplit,
                  Provider.of<BlackJack>(context, listen: false)
                      .getWinCondition,
                  Provider.of<BlackJack>(context, listen: false)
                      .getSplitWinCondition)),
          Consumer<BlackJack>(
              builder: (context, state, child) => splitOrDouble(
                  Provider.of<BlackJack>(context, listen: false)
                      .getCanDoubleOrSplit)),
          Consumer<BlackJack>(
              builder: (context, state, child) => popUpBet(
                  Provider.of<BlackJack>(context, listen: false)
                      .getfirstRound)),
        ]));
  }

  Widget startNewGame() {
    //här skapas ett nytt spel och startkort delas ut, ska kanske ha något med bet att göra

    return Column(
      //när spelaren tryckt på knapp så får dealrn sin tur FIXA
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Provider.of<BlackJack>(context, listen: false).getfirstRound
            ? const SizedBox.shrink()
            : SizedBox(
                width: 200,
                child: Consumer<BlackJack>(
                    builder: (context, state, child) => getHand(
                        Provider.of<BlackJack>(context, listen: false)
                            .getDealerHand,
                        dealer: true))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                try {
                  if (Provider.of<BlackJack>(context, listen: false).getSplit &&
                      splitTurn == false) {
                    Provider.of<BlackJack>(context, listen: false)
                        .getNewCard(playerOrSplit: 'Player');
                    Provider.of<BlackJack>(context, listen: false)
                        .blackJackOrBustCheck(playerOrSplit: 'Player');
                  } else if (Provider.of<BlackJack>(context, listen: false)
                          .getSplit &&
                      splitTurn == true) {
                    Provider.of<BlackJack>(context, listen: false)
                        .getNewCard(playerOrSplit: 'Split');
                    Provider.of<BlackJack>(context, listen: false)
                        .blackJackOrBustCheck(playerOrSplit: 'Split');
                  } else {
                    Provider.of<BlackJack>(context, listen: false)
                        .getNewCard(playerOrSplit: 'Player');
                    Provider.of<BlackJack>(context, listen: false)
                        .blackJackOrBustCheck(playerOrSplit: 'Player');
                  }
                } catch (e) {
                  //gör en popup som säger att du inte kan dra kort FIXA
                }
              },
              icon: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
            Column(
              children: [
                const Icon(Icons.money, size: 50),
                Consumer(
                    builder: (context, state, child) => Text(
                        '${Provider.of<BlackJack>(context, listen: true).getPlayerBet}'))
              ],
            ),
            Consumer<BlackJack>(
                builder: (context, state, child) => IconButton(
                    onPressed: () {
                      if (Provider.of<BlackJack>(context, listen: false)
                              .getSplit &&
                          splitTurn == false) {
                        Provider.of<BlackJack>(context, listen: false)
                            .stop(playerOrDealerOrSplit: 'Player');
                        splitTurn = true;
                      } else if (Provider.of<BlackJack>(context, listen: false)
                              .getSplit &&
                          splitTurn == true) {
                        Provider.of<BlackJack>(context, listen: false)
                            .stop(playerOrDealerOrSplit: 'Split');
                        Provider.of<BlackJack>(context, listen: false)
                            .dealersTurn();
                        Provider.of<BlackJack>(context, listen: false)
                            .winOrLose(playerOrSplit: 'Player');
                        Provider.of<BlackJack>(context, listen: false)
                            .winOrLose(playerOrSplit: 'Split');
                      } else {
                        Provider.of<BlackJack>(context, listen: false)
                            .stop(playerOrDealerOrSplit: 'Player');
                        Provider.of<BlackJack>(context, listen: false)
                            .dealersTurn();
                        Provider.of<BlackJack>(context, listen: false)
                            .winOrLose(playerOrSplit: 'Player');
                      }
                    },
                    icon: const Icon(Icons.stop, size: 40))),
          ],
        ),
        Provider.of<BlackJack>(context, listen: true).getSplit
            ? SizedBox(
                width: 200,
                child: Consumer<BlackJack>(
                    builder: (context, state, child) => getHand(
                        Provider.of<BlackJack>(context, listen: false)
                            .getSplitHand,
                        dealer: false)))
            : const SizedBox.shrink(),
        Provider.of<BlackJack>(context, listen: false).getfirstRound
            ? const SizedBox.shrink()
            : SizedBox(
                width: 200,
                child: Consumer<BlackJack>(
                    builder: (context, state, child) => getHand(
                        Provider.of<BlackJack>(context, listen: false)
                            .getPlayerHand,
                        dealer: false))),
      ],
    );
  }

  Widget getHand(List<PlayingCard> hand, {required bool dealer}) {
    //genererar vyn för spelaren och dealerns kort
    //ska dealern även visa kort om du blir tjock eller får blackjack utan att den tar en tur

    bool showDealerCard =
        Provider.of<BlackJack>(context, listen: false).getDealerCardShown;

    List<Widget> viewHand = <Widget>[];
    for (int i = 0; i < hand.length; i++) {
      viewHand.add(SizedBox(
          height: 153,
          width: 116,
          child: PlayingCardView(
              card: hand[i],
              elevation: 3.0,
              showBack: dealer
                  ? i == 0
                      ? showDealerCard
                          ? false
                          : true
                      : false
                  : false)));
    }
    return FlatCardFan(
        children: viewHand); //flatcardfan låter korten ligga "ovanpå" varandra
  }

  Widget winOrLosePopUp(
      bool split, String winOrLosePlayer, String winOrLoseSplit) {
    //popup om du vinner eller förlorar där du kan starta en ny runda eller gå till startsidan?
    if (split) {
      if (winOrLosePlayer == 'NoWinnerYet' || winOrLoseSplit == 'NoWinnerYet') {
        return const SizedBox.shrink();
      } else if (winOrLosePlayer == 'Win' && winOrLoseSplit == 'Win') {
        return AlertDialog(
          title: const Text('Congratulations'),
          content: const Text('You Won both hands!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Split');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Win' && winOrLoseSplit == 'Lose') {
        return AlertDialog(
          title: const Text('Congratulations'),
          content: const Text('You Won the player hand but lost the split!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Win' && winOrLoseSplit == 'Draw') {
        return AlertDialog(
          title: const Text('Congratulations'),
          content: const Text('You Won the player hand but drew the split!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false)
                      .drawBet(playerOrSplit: 'Split');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Lose' && winOrLoseSplit == 'Lose') {
        return AlertDialog(
          title: const Text('Bad luck!'),
          content: const Text('You Lost both hands!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Lose' && winOrLoseSplit == 'win') {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You Lost on the playerhand but won the split!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Split');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Lose' && winOrLoseSplit == 'Draw') {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You Lost on the playerhand but drew the split!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .drawBet(playerOrSplit: 'Split');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Draw' && winOrLoseSplit == 'Draw') {
        return AlertDialog(
          title: const Text('Draw!'),
          content: const Text('You got the same score as the dealer'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .drawBet(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Draw' && winOrLoseSplit == 'Win') {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You drew the playerhand but won the split!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .drawBet(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Split');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Draw' && winOrLoseSplit == 'Lose') {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You drew the playerhand but lost the split!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .drawBet(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    } else if (!split) {
      if (winOrLosePlayer == 'NoWinnerYet') {
        return const SizedBox.shrink();
      } else if (winOrLosePlayer == 'Win') {
        return AlertDialog(
          title: const Text('Congratulations'),
          content: const Text('You Won the hand!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false)
                      .winnings(playerOrSplit: 'Split');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Lose') {
        return AlertDialog(
          title: const Text('Bad luck!'),
          content: const Text('You Lost the round'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else if (winOrLosePlayer == 'Draw') {
        return AlertDialog(
          title: const Text('Draw!'),
          content: const Text('You got the same score as the dealer'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  splitTurn = false;
                  Provider.of<BlackJack>(context, listen: false)
                      .drawBet(playerOrSplit: 'Player');
                  Provider.of<BlackJack>(context, listen: false).setUpNewGame();
                  //lägg till förändringar till saldo samt bet här
                },
                child: const Text('Ok'))
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget popUpBet(bool firstRound) {
    if (firstRound) {
      return AlertDialog(
        title: const Text('Time to place your bet'),
        content: const Text('Choose your amount'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Provider.of<BlackJack>(context, listen: false).increaseBet(25);
              Provider.of<BlackJack>(context, listen: false).setFirstRound =
                  false;
            },
            child: const Text('25'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<BlackJack>(context, listen: false).increaseBet(50);
              Provider.of<BlackJack>(context, listen: false).setFirstRound =
                  false;
            },
            child: const Text('50'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<BlackJack>(context, listen: false).increaseBet(100);
              Provider.of<BlackJack>(context, listen: false).setFirstRound =
                  false;
            },
            child: const Text('100'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<BlackJack>(context, listen: false).increaseBet(
                  Provider.of<BlackJack>(context, listen: false).getBalance);
              Provider.of<BlackJack>(context, listen: false).setFirstRound =
                  false;
            },
            child: const Text('All in'),
          ),
        ],
      );
    } else if (!firstRound) {
      return const SizedBox.shrink();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget splitOrDouble(bool firstRound) {
    if (firstRound) {
      return AlertDialog(
          title: const Text('Double or Split'),
          content: const Text('Choose what you want to do'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Provider.of<BlackJack>(context, listen: false).doSplit();
                  Provider.of<BlackJack>(context, listen: false)
                      .canDoubleOrSplit = false;
                },
                child: const Text('Split')),
            TextButton(
                onPressed: () {
                  Provider.of<BlackJack>(context, listen: false).doDouble();
                  Provider.of<BlackJack>(context, listen: false)
                      .setCanDoubleOrSplit = false;
                },
                child: const Text('Double')),
            TextButton(
                onPressed: () {
                  Provider.of<BlackJack>(context, listen: false)
                      .setCanDoubleOrSplit = false;
                },
                child: const Text('Cancel'))
          ]);
    } else if (!firstRound) {
      return const SizedBox.shrink();
    } else {
      return const SizedBox.shrink();
    }
  }
}
