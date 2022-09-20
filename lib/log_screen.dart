import 'package:emotion_log/widgets/emojis.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatefulWidget {
  @override
  State<LogScreen> createState() => _LogScreenState();
}

class NewItem {
  bool isExpanded=false;
  final String header;
  final Widget body;

  NewItem(this.isExpanded, this.header, this.body);
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emotion Log',
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: buildPanels(getCategoryList()),
    );
  }

  Widget buildPanels(List<String> categoryList) {
    List<NewItem> finalPanels = [];
    for (var category in categoryList) {
      finalPanels.add(
        NewItem(
            false, // isExpanded ?
            '$category'.toUpperCase(), // header
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: buildEmojiList(category))) // iconPic
            ),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                print('Set State Hit');
                bool clicked = finalPanels[index].isExpanded;
                print(clicked);
                clicked = !clicked;
                print('This is $clicked');
                finalPanels[index].isExpanded = clicked;
                print('Final panels is ${finalPanels[index].isExpanded}');
                //finalPanels[index].isExpanded = !finalPanels[index].isExpanded;
              });
            },
            children: finalPanels.map((NewItem item) {
              return ExpansionPanel(
                isExpanded: item.isExpanded,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      title: Text(
                    item.header,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ));
                },
                body: item.body,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<Widget> buildEmojiList(catOfPanel) {
    List<Widget> emojiList = [];
    for (var face in emojis) {
      if (face.category == catOfPanel) {
        emojiList.add(SizedBox(
          height: 90,
          width: 85,
          child: ElevatedButton(
            onPressed: () {},
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/images/${face.path}',
                      fit: BoxFit.scaleDown,
                    )),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  child: Text(
                    face.name,
                    style: TextStyle(color: Colors.black, fontSize: 9),
                  ),
                ),
              ],
            ),
          ),
        ));
      } else {}
    }
    return emojiList;
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
}
