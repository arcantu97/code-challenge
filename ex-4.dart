import 'dart:io';

void main() {
  try {
    final attackerType = getPokemonType('Tipo del Pokémon atacante');
    final defenderType = getPokemonType('Tipo del Pokémon defensor');
    final attack = getStatValue('Valor de ataque');
    final defense = getStatValue('Valor de defensa');
    
    final damage = calculateDamage(attackerType, defenderType, attack, defense);
    
    printBattleResult(attackerType, defenderType, attack, defense, damage);
  } catch (e) {
    print('Error: $e');
  }
}

String getPokemonType(String prompt) {
  print('$prompt (agua/fuego/planta/electrico):');
  final type = stdin.readLineSync()?.toLowerCase() ?? '';
  if (!['agua', 'fuego', 'planta', 'electrico'].contains(type)) {
    throw ArgumentError('Tipo de Pokémon no válido.');
  }
  return type;
}

int getStatValue(String prompt) {
  print('$prompt (1-100):');
  final value = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  if (value < 1 || value > 100) {
    throw ArgumentError('El valor debe estar entre 1 y 100.');
  }
  return value;
}


double calculateDamage(String attackerType, String defenderType, int attack, int defense) {
  final effectiveness = getTypeEffectiveness();
  return 50 * (attack / defense) * effectiveness[attackerType]![defenderType]!;
}

Map<String, Map<String, double>> getTypeEffectiveness() {
  return {
    'agua': {'agua': 0.5, 'fuego': 2.0, 'planta': 0.5, 'electrico': 1.0},
    'fuego': {'agua': 0.5, 'fuego': 0.5, 'planta': 2.0, 'electrico': 1.0},
    'planta': {'agua': 2.0, 'fuego': 0.5, 'planta': 0.5, 'electrico': 1.0},
    'electrico': {'agua': 2.0, 'fuego': 1.0, 'planta': 0.5, 'electrico': 0.5}
  };
}

void printBattleResult(String attackerType, String defenderType, int attack, int defense, double damage) {
  print('\nResultado de la batalla:');
  print('Pokémon atacante: $attackerType');
  print('Pokémon defensor: $defenderType');
  print('Ataque: $attack');
  print('Defensa: $defense');
  print('Daño causado: ${damage.toStringAsFixed(2)}');
}
