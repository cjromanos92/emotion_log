import 'package:flutter/material.dart';
import 'package:emotion_log/widgets/emojis.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Emotions Log';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> catList = [];
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      home: Scaffold(
        appBar: AppBar(title: const Text(MyApp._title)),
        body: const Panels(),
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
  bool selected = false;
  List<Panel> panelList = [];

  for (var cat in catList) {
    List<Emoji> emojiTemp = getEmojiByCategory(cat);
    List<Widget> emojiWidgets = [];

    // for (var emoji in emojiTemp) {
    //   emojiWidgets.add(SizedBox(
    //     height: 90,
    //     width: 85,
    //     child: ElevatedButton(
    //       onPressed: () {
    //         print('BEFORE $selected');
    //         //set State
    //         print('AFTER $selected');
    //       },
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: 4,
    //           ),
    //           SizedBox(
    //               height: 60,
    //               width: 60,
    //               child: Image.asset(
    //                 'assets/images/${emoji.path}',
    //                 fit: BoxFit.scaleDown,
    //               )),
    //           SizedBox(
    //             height: 4,
    //           ),
    //           SizedBox(
    //             child: Text(
    //               emoji.name,
    //               style: TextStyle(color: Colors.black, fontSize: 9),
    //             ),
    //           ),
    //         ],
    //       ),
    //       style: (selected = false) ? ElevatedButton.styleFrom(backgroundColor: Colors.red) : ElevatedButton.styleFrom(backgroundColor: Colors.green),
    //     ),
    //   ));
    // }
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
  bool selected = false;
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
          height: 90,
          width: 85,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selected = !selected;
              });
            },
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/images/${emoji.path}',
                      fit: BoxFit.scaleDown,
                    )),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  child: Text(
                    emoji.name,
                    style: TextStyle(color: Colors.black, fontSize: 9),
                  ),
                ),
              ],
            ),
            style: (selected) ? ElevatedButton.styleFrom(backgroundColor: Colors.red) : ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(panel.title),
            );
          },
          body: Wrap(
            children: _renderEmojis(panel.body),
          ),
          isExpanded: panel.isExpanded,
        );
      }).toList(),
    );
  }
}