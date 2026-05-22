import 'package:flutter/material.dart';
// imports all predefined widgets

// to read more about properties, hit control key and click on any
    
void main() {
  runApp(
    MaterialApp(
      //home: Text('Hello World') --> by default, prints in upper left corner
      //home: Center(child: Text('Hello World') --> centers hello world
      home: Scaffold(
        // Scaffold gives preset structure of layout so you dont need to write in every single property (ie: color or fontWeight)
        appBar: AppBar(
          title: Text('Cat Owl'),
          backgroundColor: Color.fromARGB(255, 255, 207, 215),
        ),
        //appBar property(light blue): tells app where to put things
        //appBar widget: tells app what to display in appBar
        body: Center(
          child: Center(
            child: Image.asset(
              'assets/catowl.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
  );
}

// MaterialApp is a specialized widget that acts as the foundation of our flutter app
