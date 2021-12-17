import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'rules.dart';

//fixa så att texten ändras i rutan utan att använda setstate eftersom vi använder provider.

//class med changenotifier
class HowToPlay extends ChangeNotifier {
  String chosenChapter = 'How to play';

  String get getChosenChapter {
    return chosenChapter;
  }

  void chooseChapter(String choice) {
    chosenChapter = choice;
    notifyListeners();
  }
}

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //appbar med en dropdownbutton
          title: DropdownButton(
            iconSize: 40,
            iconEnabledColor: Colors.white,
            style: const TextStyle(fontSize: 20),
            value:
                Provider.of<HowToPlay>(context, listen: false).getChosenChapter,
            onChanged: (String? chosenValue) {
              //kallar på funktionen med hjälp av en provider
              Provider.of<HowToPlay>(context, listen: false)
                  .chooseChapter(chosenValue!);
            },
            //lista med de alternativ användaren får
            items: <String>[
              'How to play',
              'Card values',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
        ),
        body: Consumer<HowToPlay>(
            builder: (context, state, child) => getText(
                Provider.of<HowToPlay>(context, listen: false)
                    .getChosenChapter)));
  }

  Widget getText(String chosenText) {
    return Column(
      children: [
        Center(
          child: Text(
            RuleText.returnRules(chosenText),
          ),
        ),
      ],
    );
  }
}
