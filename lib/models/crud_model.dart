import 'package:signals_flutter/signals_flutter.dart';

final prefix = signal<String>('', options: SignalOptions(name: 'prefix'));
final firstName = signal<String>('', options: SignalOptions(name: 'First name'));
final lastName = signal<String>('', options: SignalOptions(name: 'Last name'));

final listOfNames = Computed<List<(String, String)>>(() {
  if (prefix.value != '') {
    return allNames.value
        .where((e) => e.$2.toLowerCase().startsWith(prefix.value.toLowerCase()))
        .toList();
  }
  return allNames.value;
}, options: ComputedOptions(name: 'listOfNames'));

final allNames = signal<List<(String,String)>>([
  ('Hans', 'Emil'),
  ('Max', 'Mustermann'),
  ('Roman', 'Tisch'),
  ('Grace', 'Brown'),
  ('Robert', 'Jones'),
  ('Marie', 'Garcia'),
  ('James', 'Smith'),
]);


int? indexOfNameClicked;
