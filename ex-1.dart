import 'dart:io';

void main() {
  try {
    print('Ingrese el año de inicio:');
    final startYear = int.parse(stdin.readLineSync() ?? '');
    if (startYear < 0) {
      throw ArgumentError('El año de inicio debe ser un número positivo.');
    }
    print('Los próximos 30 años bisiestos a partir de $startYear son:');
    int year = startYear;
    int count = 0;
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
      year++;
    }
    while (count < 30) {
      while ((year % 4 != 0) || (year % 100 == 0 && year % 400 != 0)) {
        year++;
      }
      print(year);
      year++;
      count++;
    }
  } catch (e) {
    print('Error: $e');
  }
}