import 'package:emotion_log/widgets/emojis.dart';

class JournalEntry{
  DateTime entryDate = DateTime.now();
  List<Emoji> selectedEmojis = [];

  JournalEntry({required this.entryDate, required this.selectedEmojis});
}
List<JournalEntry> journal = [

];