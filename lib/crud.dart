import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/crud_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: Layout())));
}

class Layout extends StatelessWidget {
  Layout({super.key});

  final TextEditingController _filterController = TextEditingController();
  final TextEditingController _createFirstController = TextEditingController();
  final TextEditingController _createLastController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 300,
          child: SignalBuilder(
            builder: (BuildContext context) {
              return (TextField(
                controller: _filterController,
                decoration: InputDecoration(hintText: 'Filter prefix: '),
                onChanged: (value) {
                  prefix.value = value;
                },
              ));
            },
          ),
        ),
        SizedBox(height: 70),
        Row(
          spacing: 48,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignalBuilder(
              builder: (BuildContext context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listOfNames.value.map((e) {
                    return TextButton(
                      onPressed: () {
                        _createFirstController.text = e.$1;
                        _createLastController.text = e.$2;

                        firstName.value = e.$1;
                        lastName.value = e.$2;

                        var aux = [...allNames.value];
                        indexOfNameClicked = aux.indexWhere(
                          (e) =>
                              e.$1 == _createFirstController.text &&
                              e.$2 == _createLastController.text,
                        );

                        allNames.value = aux;
                      },
                      child: Text('${e.$2}, ${e.$1}'),
                    );
                  }).toList(),
                );
              },
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 70, child: Text('First name:')),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _createFirstController,
                        onChanged: (value) => firstName.value = value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 70, child: Text('Last name:')),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _createLastController,
                        onChanged: (value) => lastName.value = value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 24),
        SignalBuilder(
          builder: (BuildContext context) {
            return Row(
              spacing: 12,
              children: [
                ///
                /// Add button
                ///
                ElevatedButton(
                  onPressed: () {
                    if (firstName.value.isNotEmpty &&
                        lastName.value.isNotEmpty) {
                      var aux = [
                        ...allNames.value,
                        (firstName.value, lastName.value),
                      ];
                      aux.sort((a, b) => a.$2.compareTo(b.$2));
                      allNames.value = aux;

                      _createFirstController.clear();
                      _createLastController.clear();

                      firstName.value = '';
                      lastName.value = '';
                      indexOfNameClicked = null;
                    }
                  },
                  child: const Text('Create'),
                ),

                ///
                /// Update button
                ///
                ElevatedButton(
                  onPressed: () {
                    if (firstName.value.isNotEmpty &&
                        lastName.value.isNotEmpty) {
                      var aux = [...allNames.value];

                      aux[indexOfNameClicked!] = (
                        firstName.value,
                        lastName.value,
                      );

                      allNames.value = aux;

                      _createFirstController.clear();
                      _createLastController.clear();

                      firstName.value = '';
                      lastName.value = '';
                      indexOfNameClicked = null;
                    }
                  },
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (firstName.value.isNotEmpty &&
                        lastName.value.isNotEmpty) {
                      var aux = [...allNames.value];
                      var index = aux.indexWhere(
                        (e) =>
                            e.$1 == _createFirstController.text &&
                            e.$2 == _createLastController.text,
                      );
                      aux.removeAt(index);
                      allNames.value = aux;

                      _createFirstController.clear();
                      _createLastController.clear();

                      firstName.value = '';
                      lastName.value = '';
                      indexOfNameClicked = null;
                    }
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
