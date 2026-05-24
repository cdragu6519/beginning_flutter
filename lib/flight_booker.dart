import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return Content();
            },
          ),
        ),
      ),
    ),
  );
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  DateTime? departureDate;
  DateTime? returnDate;
  int legs = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownMenu<int>(
          hintText: 'Book Flight',
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 1, label: 'One way flight'),
            DropdownMenuEntry(value: 2, label: 'Round trip flight'),
          ],
          onSelected: (value) {
            setState(() {
              legs = value!;
            });
          },
        ),

        //Text('legs: ${legs.toString()}'),
        ElevatedButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2026, 5, 24),
              lastDate: DateTime(2027),
            );
            setState(() {
              departureDate = pickedDate;
            });
          },
          child: const Text('Select Depart Date'),
        ),
        Text(departureDate?.toIso8601String() ?? 'No date selected'),

        if (legs > 1)
          ElevatedButton(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2026, 5, 24),
                lastDate: DateTime(2027),
              );
              setState(() {
                returnDate = pickedDate;
              });
            },
            child: const Text('Select Return Date'),
          ),
        Text(returnDate?.toIso8601String() ?? 'No date selected'),
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              const Color.fromARGB(62, 120, 225, 251),
            ),
          ),
          onPressed: () {},
          child: Text('Book Trip'),
        ),
      ],
    );
  }
}
