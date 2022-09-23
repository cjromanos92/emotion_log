import 'package:emotion_log/widgets/journal.dart';
import 'package:flutter/material.dart';

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
      body: Column(
          children: getEntryDate(),
        ),
    );
  }


  List<Widget> getEntryDate(){
    List<Widget> dated = [];
    for(var entry in journal){
      dated.add(TextButton(onPressed: (){},child: Text(entry.entryDate.toString())));
      for(var face in entry.selectedEmojis){
        dated.add(ImageIcon(AssetImage('assets/images/${face.path}')));
      }
    }
    return dated;
}
}
