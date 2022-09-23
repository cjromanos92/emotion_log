import 'package:emotion_log/journal_screen.dart';
import 'package:emotion_log/widgets/journal.dart';
import 'package:flutter/material.dart';
import 'package:emotion_log/widgets/emojis.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Emotions Log';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  final List<String> catList = [];
  final List<Panel> _panels = getPanels();
  List<Emoji> entryEmojis = [];
  List<JournalEntry> journal = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MyApp._title), actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowJournal(journal: journal)));
          },
          child: Row(
            children: const [
              ImageIcon(
                AssetImage('assets/images/journal.png'),
                color: Colors.white,
              ),
              SizedBox(
                width: 6,
              ),
              Text('JOURNAL', style: TextStyle(color: Colors.white)),
              SizedBox(
                width: 6,
              )
            ],
          ),
        )
      ]),
      body: Panels(
        panels: _panels,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Submit'),
        onPressed: () {
          List<Emoji> tempEmoji = [];
          for (var pan in _panels) {
            for (var face in pan.body) {
              if (face.isSelected == true) {
                tempEmoji.add(face);
                face.isSelected=false;
              }
            }
          }
          if (tempEmoji.isNotEmpty) {
            journal.add(JournalEntry(
                selectedEmojis: tempEmoji, entryDate: DateTime.now()));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green.shade300,
                content: Text(
                  'Journal entry submitted!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red.shade300,
                content: Text(
                  'No emotions selected! Please try again.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )));
          }
        },
      ),
    );
  }
}

class Panel {
  Panel(this.title, this.body, [this.isExpanded = false]);

  String title;
  List<Emoji> body;
  bool isExpanded;
}

List<Panel> getPanels() {
  List<String> catList = getCategoryList();
  List<Panel> panelList = [];

  for (var cat in catList) {
    List<Emoji> emojiTemp = getEmojiByCategory(cat);
    panelList.add(Panel(cat, emojiTemp));
  }
  return panelList;
}

List<String> getCategoryList() {
  List<String> categoryList = [];
  for (var face in emojis) {
    if (categoryList.contains(face.category)) {
    } else {
      categoryList.add(face.category);
    }
  }
  return categoryList;
}

List<Emoji> getEmojiByCategory(category) {
  List<Emoji> emojiByCat = [];
  for (var emoji in emojis) {
    if (emoji.category == category) {
      emojiByCat.add(
          Emoji(name: emoji.name, path: emoji.path, category: emoji.category));
    }
  }
  return emojiByCat;
}

class Panels extends StatefulWidget {
  final List<Panel> panels;

  const Panels({Key? key, required this.panels}) : super(key: key);

  @override
  State<Panels> createState() => _PanelsState();
}

class _PanelsState extends State<Panels> {
  //final List<Panel> _panels = getPanels();
  List<Emoji> journalEntry = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        _renderPanels(),
        const SizedBox(
          height: 100,
        )
      ]),
    );
  }

  List<Widget> _renderEmojis(emojiList) {
    List<Widget> emojiWidgets = [];
    for (var emoji in emojiList) {
      emojiWidgets.add(SizedBox(
        height: 105,
        width: 115,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              emoji.isSelected = !emoji.isSelected;
            });
          },
          style: (emoji.isSelected)
              ? ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                )
              : ElevatedButton.styleFrom(backgroundColor: Colors.white60),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                  height: 75,
                  width: 90,
                  child: ImageIcon(
                    AssetImage(
                      'assets/images/${emoji.path}',
                    ),
                    color: (emoji.isSelected) ? Colors.white : Colors.black87,
                  )),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                child: Text(
                  emoji.name,
                  style: TextStyle(
                      color: (emoji.isSelected) ? Colors.white : Colors.black87,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return emojiWidgets;
  }

  Widget _renderPanels() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.panels[index].isExpanded = !isExpanded;
        });
      },
      children: widget.panels.map<ExpansionPanel>((Panel panel) {
        return ExpansionPanel(
          backgroundColor: Colors.white,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                panel.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12.0,
            runSpacing: 8,
            children: _renderEmojis(panel.body),
          ),
          isExpanded: panel.isExpanded,
        );
      }).toList(),
    );
  }
}
