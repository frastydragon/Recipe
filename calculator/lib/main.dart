import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<HomePage> {
  String display = '0';
  double firstNumber = 0;
  double secondNumber = 0;
  String operator = '';
  bool isOperatorPressed = false;

  // Method to handle number input
  void onNumberPressed(String number) {
    setState(() {
      if (display == '0' || isOperatorPressed) {
        display = number;
        isOperatorPressed = false;
      } else {
        display += number;
      }
    });
  }

  // Method to handle operator input
  void onOperatorPressed(String op) {
    setState(() {
      firstNumber = double.parse(display);
      operator = op;
      isOperatorPressed = true;
    });
  }

  // Method to handle the equals button
  void onEqualsPressed() {
    setState(() {
      secondNumber = double.parse(display);

      switch (operator) {
        case '+':
          display = (firstNumber + secondNumber).toString();
          break;
        case '-':
          display = (firstNumber - secondNumber).toString();
          break;
        case '*':
          display = (firstNumber * secondNumber).toString();
          break;
        case '/':
          display = secondNumber == 0 ? 'Error' : (firstNumber / secondNumber).toString();
          break;
      }
    });
  }

  // Method to clear the calculator
  void onClearPressed() {
    setState(() {
      display = '0';
      firstNumber = 0;
      secondNumber = 0;
      operator = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display area
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          // Buttons (numbers and operators)
          Column(
            children: [
              buildButtonRow(['7', '8', '9', '/']),
              buildButtonRow(['4', '5', '6', '*']),
              buildButtonRow(['1', '2', '3', '-']),
              buildButtonRow(['0', 'C', '=', '+']),
            ],
          )
        ],
      ),
    );
  }

  // Helper method to build a row of buttons
  Widget buildButtonRow(List<String> buttonLabels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonLabels.map((label) {
        return buildButton(label);
      }).toList(),
    );
  }

  // Helper method to build individual buttons
  Widget buildButton(String label) {
    return InkWell(
      onTap: () {
        if (label == 'C') {
          onClearPressed();
        } else if (label == '=') {
          onEqualsPressed();
        } else if (['+', '-', '*', '/'].contains(label)) {
          onOperatorPressed(label);
        } else {
          onNumberPressed(label);
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
