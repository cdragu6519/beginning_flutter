import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return TimerWidget();
            },
          ),
        ),
      ),
    ),
  );
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

// const -> states that code is immutable and value must be set before app runs
// purpose is so that flutter reuses widget every time you run vs recreating from scratch every time
class _TimerWidgetState extends State<TimerWidget> {
  double _currentSliderValue = 0.0;
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel(); //so if you click run more than once, first timer cancels
    // counts down from the current slider value set
    double counter = _currentSliderValue;

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (counter > 0.0) {
          counter -= 0.1;
          _currentSliderValue = counter.toDouble();
          //updates slider so slider moves down as timer goes down
        } else {
          timer.cancel(); // cancels timer when it reaches 0
        }
      });
    });
  }

  // function for resetting timer. when called, timer cancels and sets slider val to 0
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _currentSliderValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Timer',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 40),
          Text(
            _currentSliderValue.toStringAsFixed(1),
            style: const TextStyle(fontSize: 24),
          ),
          Slider(
            value: _currentSliderValue,
            min: 0,
            max: 100,
            label: _currentSliderValue.toStringAsFixed(0),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
          SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _resetTimer,
                child: const Text('Reset'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(onPressed: _startTimer, child: const Text('Run')),
            ],
          ),
        ],
      ),
    );
  }
}
