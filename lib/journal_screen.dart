import 'package:emotion_log/widgets/journal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowJournal extends StatelessWidget {
  // In the constructor, require a Todo.
  const ShowJournal({super.key, required this.journal});

  // Declare a field that holds the Todo.
  final List<JournalEntry> journal;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Column(children:getRows()),
        );
  }


  List<Widget> getRows(){
    List<Widget> entries = [];
    for(var entry in journal){
      List<Widget> faceRow = [];
      Widget tempEntry;
      for(var face in entry.selectedEmojis){

        faceRow.add(ImageIcon(AssetImage('assets/images/${face.path}')));
      }
      String formattedDate = DateFormat.MMMMEEEEd().format(entry.entryDate);
      tempEntry = Card(
        child: Row(children: [Text('$formattedDate'),Row(children: faceRow,)]),);
      entries.add(tempEntry);
    }
    return entries;
}
}
