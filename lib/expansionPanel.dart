import 'package:flutter/material.dart';
import 'package:emotion_log/widgets/emojis.dart';
import 'package:emotion_log/main.dart';

class Expansionpanel extends StatefulWidget {
  Expansionpaneltate createState() =>  Expansionpaneltate();
}
class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;

  NewItem(this.isExpanded, this.header, this.body);
}
class Expansionpaneltate extends State<Expansionpanel> {

  List<NewItem> items = <NewItem>[
    NewItem(
        false, // isExpanded ?
        'Positive', // header
        Padding(
            padding: EdgeInsets.all(1.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 10,
              children: <Widget>[
                for(var face in emojis) SizedBox(
                  height: 90,
                  width: 85,
                  child: ElevatedButton(
                    child: Column(
                    children: [
                      SizedBox(height: 4,),
                      SizedBox(height: 60, width: 60,child: Image.asset('assets/images/${face.path}',fit: BoxFit.scaleDown,)),
                      SizedBox(height: 4,),
                      SizedBox(child: Text(face.name, style: TextStyle(color: Colors.black, fontSize: 9),),),
                    ],
                  ),
                    onPressed: () {
                    },
                  ),
                )
              ],
            )) // iconPic
    ),

    NewItem(
        false, // isExpanded ?
        'Positive', // header
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                children: <Widget>[
                  Text('data'),
                  Text('data'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                  Radio(value: null, groupValue: null, onChanged: null)
                ]
            )
        ), // body
        //Icon(Icons.image) // iconPic
    ),
  ];
  late ListView List_Criteria;
  bool isPressed = false;
  Widget build(BuildContext context) {
    List_Criteria = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return  ListTile(
                      title:  Text(
                        item.header,
                        textAlign: TextAlign.left,
                        style:  TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                  );
                },
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        ),
      ],
    );
    Scaffold scaffold =  Scaffold(
      appBar:  AppBar(
        title:  Text("ExpansionPanelList"),
      ),
      body: List_Criteria,
    );
    return scaffold;
  }
}

