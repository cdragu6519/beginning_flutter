import 'package:flutter/material.dart';

void main() {
  final TextEditingController fahrenheitController = TextEditingController();
  final TextEditingController celsiusController = TextEditingController();

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),

            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: fahrenheitController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Enter Fahrenheit",
                        ),
                        onSubmitted: (value) {
                          setState(
                            () {
                              String input = fahrenheitController
                                  .text; //gets text typed into fahrenheit box
                              double fahrenheit = double.parse(
                                input,
                              ); // converts string into number
                              double celsius =
                                  (fahrenheit - 32) *
                                  5 /
                                  9; //calculates celsius conversion
                              celsiusController.text = celsius.toStringAsFixed(
                                1,
                              );
                            },
                          ); //rounds by 1 decmial place and puts celsius conversion in celsius text box
                        },
                      ),
                    ),
                    SizedBox(height: 120),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: celsiusController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Enter Celsius'),
                        onSubmitted: (value) {
                          setState(
                            () {
                              String input = celsiusController
                                  .text; //gets text typed into fahrenheit box
                              double celsius = double.parse(
                                input,
                              ); // converts string into number
                              double fahrenheit =
                                  (celsius * 9 / 5) +
                                  32; //calculates  conversion
                              fahrenheitController.text = fahrenheit
                                  .toStringAsFixed(1);
                            },
                          ); //rounds by 1 decmial place and puts celsius conversion in celsius text box
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
