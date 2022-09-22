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
  final List<String> catList = [];

  @override
  Widget build(BuildContext context) {
    var thesePanels = getPanels();
    List<Emoji> entryEmojis = [];
    List<JournalEntry> journal = [];

    return MaterialApp(
      title: MyApp._title,
      home: Scaffold(
        appBar: AppBar(title: const Text(MyApp._title)),
        body: const Panels(),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Submit'),
          onPressed: (){
            for(var pan in thesePanels){
             for(var face in pan.body){
               print('${face.name} is ${face.isSelected}');
               if(face.isSelected == true){
                 entryEmojis.add(face);
                 print('ENTRY FACES IS $entryEmojis');
               }
             }
            }
            journal.add(JournalEntry( selectedEmojis: entryEmojis, entryDate: DateTime.now()));
            print('JOURNAL IS $journal');

          },
        ),
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
  const Panels({Key? key}) : super(key: key);

  @override
  State<Panels> createState() => _PanelsState();
}

class _PanelsState extends State<Panels> {
  final List<Panel> _panels = getPanels();
  List<Emoji> journalEntry = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _renderPanels(),
      ),
    );
  }

  List<Widget> _renderEmojis(emojiList) {
    List<Widget> emojiWidgets = [];
    for(var emoji in emojiList){
        emojiWidgets.add(SizedBox(
          height: 105,
          width: 110,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                emoji.isSelected = !emoji.isSelected;
              });
            },
            style: (emoji.isSelected) ? ElevatedButton.styleFrom(backgroundColor: Colors.green) : ElevatedButton.styleFrom(backgroundColor: Colors.white60),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    height: 75 ,
                    width: 90,
                    child: Image.asset(
                      'assets/images/${emoji.path}',
                      fit: BoxFit.scaleDown,
                    )),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  child: Text(
                    emoji.name,
                    style: const TextStyle(color: Colors.black, fontSize: 11),
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
          _panels[index].isExpanded = !isExpanded;
        });
      },
      children: _panels.map<ExpansionPanel>((Panel panel) {
        return ExpansionPanel(
          backgroundColor: Colors.white,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(panel.title),
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