class Emoji{
  String name;
  String path;
  String category;

  Emoji({required this.name, required this.path, required this.category});
}
List<Emoji> emojis = [
  Emoji(name: 'Amusement', path: 'Amusement.png', category: 'positive'),
  Emoji(name: 'Delight', path: 'Delight.png', category: 'positive'),
  Emoji(name: 'Elation', path: 'Elation.png', category: 'positive'),
  Emoji(name: 'Excitement', path: 'Excitement.png', category: 'positive'),
  Emoji(name: 'Happiness', path: 'Happiness.png', category: 'positive'),
  Emoji(name: 'Joy', path: 'Joy.png', category: 'positive'),
  Emoji(name: 'Pleasure', path: 'Pleasure.png', category: 'positive'),
];