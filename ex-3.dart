import 'dart:io';

void main() {
  print('Ingrese texto o código morse:');
  final input = stdin.readLineSync() ?? '';
  
  try {
    final result = isMorse(input) ? morseToText(input) : textToMorse(input);
    print('Resultado: $result');
  } catch (e) {
    print('Error: $e');
  }
}

bool isMorse(String text) {
  return RegExp(r'^[.\- ]+$').hasMatch(text);
}

String textToMorse(String text) {
  final map = getMorseMap();
  final words = text.toLowerCase().split(' ');
  
  return words.map((word) => 
    word.split('').map((c) => map[c] ?? (throw ArgumentError('Carácter no soportado: $c')))
      .join(' ')
  ).join('  ');
}

String morseToText(String morse) {
  final map = getMorseMap().map((k, v) => MapEntry(v, k));
  
  String result = '';
  int index = 0;
  
  while (index < morse.length) {
    bool found = false;
    
    // Intentar coincidir desde el código más largo al más corto
    final sortedCodes = map.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
    
    for (final code in sortedCodes) {
      if (index + code.length <= morse.length && morse.substring(index, index + code.length) == code) {
        result += map[code]!;
        index += code.length;
        found = true;
        break;
      }
    }
    
    if (!found) {
      if (morse[index] == ' ') {
        if (index + 1 < morse.length && morse[index + 1] == ' ') {
          if (result.isNotEmpty && result[result.length - 1] != ' ') {
            result += ' ';
          }
          index += 2; // Avanzar dos espacios para separar palabras
        } else {
          index++; // Ignorar espacios simples entre letras
        }
      } else {
        throw ArgumentError('Código morse no válido en posición $index');
      }
    }
  }
  
  return result;
}

Map<String, String> getMorseMap() {
  return {
    'a': '.-', 'b': '-...', 'c': '-.-.', 'd': '-..', 'e': '.', 'f': '..-.',
    'g': '--.', 'h': '....', 'i': '..', 'j': '.---', 'k': '-.-', 'l': '.-..',
    'm': '--', 'n': '-.', 'o': '---', 'p': '.--.', 'q': '--.-', 'r': '.-.',
    's': '...', 't': '-', 'u': '..-', 'v': '...-', 'w': '.--', 'x': '-..-',
    'y': '-.--', 'z': '--..', '1': '.----', '2': '..---', '3': '...--',
    '4': '....-', '5': '.....', '6': '-....', '7': '--...', '8': '---..',
    '9': '----.', '0': '-----', ' ': '  '
  };
}
