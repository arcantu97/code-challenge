import 'dart:io';

void main() {
  final zeldaGames = getZeldaGames();
  
  printGameList(zeldaGames);
  
  try {
    final game1Index = selectGameIndex('Selecciona el primer juego:', zeldaGames);
    final game2Index = selectGameIndex('Selecciona el segundo juego:', zeldaGames);
    
    final game1 = getGameByIndex(game1Index, zeldaGames);
    final game2 = getGameByIndex(game2Index, zeldaGames);
    
    calculateAndPrintTimeDifference(game1, game2, zeldaGames);
  } catch (e) {
    print('Error: $e');
  }
}

Map<String, DateTime> getZeldaGames() {
  return {
    'The Legend of Zelda': DateTime(1986, 2, 21),
    'Zelda II: The Adventure of Link': DateTime(1987, 1, 14),
    'A Link to the Past': DateTime(1991, 11, 21),
    'Link\'s Awakening': DateTime(1993, 6, 6),
    'Ocarina of Time': DateTime(1998, 11, 21),
    'Majora\'s Mask': DateTime(2000, 4, 27),
    'Wind Waker': DateTime(2002, 12, 13),
    'Twilight Princess': DateTime(2006, 11, 19),
    'Skyward Sword': DateTime(2011, 11, 18),
    'Breath of the Wild': DateTime(2017, 3, 3),
    'Tears of the Kingdom': DateTime(2023, 5, 12),
  };
}

void printGameList(Map<String, DateTime> games) {
  print('Juegos disponibles:');
  final gameTitles = games.keys.toList();
  
  for (int i = 0; i < gameTitles.length; i++) {
    final title = gameTitles[i];
    final date = games[title]!;
    print('${i + 1}. $title (${date.day}/${date.month}/${date.year})');
  }
}

int selectGameIndex(String prompt, Map<String, DateTime> games) {
  print('\n$prompt');
  final input = stdin.readLineSync();
  
  if (input == null) {
    throw ArgumentError('Entrada no válida.');
  }
  
  final index = int.tryParse(input) ?? 0;
  
  if (index < 1 || index > games.length) {
    throw ArgumentError('Índice de juego no válido.');
  }
  
  return index - 1;
}

String getGameByIndex(int index, Map<String, DateTime> games) {
  final gameTitles = games.keys.toList();
  return gameTitles[index];
}

void calculateAndPrintTimeDifference(
  String game1, 
  String game2, 
  Map<String, DateTime> games
) {
  final date1 = games[game1]!;
  final date2 = games[game2]!;
  
  final difference = date2.difference(date1);
  final years = difference.inDays ~/ 365;
  final days = difference.inDays % 365;
  
  print('\nEntre "$game1" y "$game2":');
  print('Han pasado $years años y $days días');
  print('Total de días: ${difference.inDays}');
}
