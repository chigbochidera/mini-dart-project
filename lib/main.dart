import 'package:flutter/material.dart';

void main() {
  runApp(PhysicsCalculatorApp());
}

class PhysicsCalculatorApp extends StatelessWidget {
  const PhysicsCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhysicsCalculatorHome(),
    );
  }
}

class PhysicsCalculatorHome extends StatefulWidget {
  @override
  _PhysicsCalculatorHomeState createState() => _PhysicsCalculatorHomeState();
}

class _PhysicsCalculatorHomeState extends State<PhysicsCalculatorHome> {
  String calculationType = 'Energy/Power';
  String selectedCalculation = 'Kinetic Energy';
  final Map<String, List<String>> options = {
    'Energy/Power': [
      'Kinetic Energy',
      'Potential Energy',
      'Work Done',
      'Power'
    ],
    'Distance/Speed': [
      'Average Speed',
      'Distance Travelled',
      'Time of Travel'
    ],
  };

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  String result = '';

  void calculate() {
    double value1 = double.tryParse(controller1.text) ?? 0;
    double value2 = double.tryParse(controller2.text) ?? 0;

    setState(() {
      switch (selectedCalculation) {
        case 'Kinetic Energy':
          result = 'Kinetic Energy: ${(0.5 * value1 * value2 * value2).toStringAsFixed(2)} J';
          break;
        case 'Potential Energy':
          result = 'Potential Energy: ${(value1 * value2 * 9.8).toStringAsFixed(2)} J';
          break;
        case 'Work Done':
          result = 'Work Done: ${(value1 * value2).toStringAsFixed(2)} J';
          break;
        case 'Power':
          result = 'Power: ${(value1 / value2).toStringAsFixed(2)} W';
          break;
        case 'Average Speed':
          result = 'Average Speed: ${(value1 / value2).toStringAsFixed(2)} m/s';
          break;
        case 'Distance Travelled':
          result = 'Distance Travelled: ${(value1 * value2).toStringAsFixed(2)} m';
          break;
        case 'Time of Travel':
          result = 'Time of Travel: ${(value1 / value2).toStringAsFixed(2)} s';
          break;
        default:
          result = 'Invalid Calculation';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Physics Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                  value: 'Energy/Power',
                  groupValue: calculationType,
                  onChanged: (value) {
                    setState(() {
                      calculationType = value!;
                      selectedCalculation = options[calculationType]![0];
                    });
                  },
                ),
                Text('Energy/Power'),
                Radio(
                  value: 'Distance/Speed',
                  groupValue: calculationType,
                  onChanged: (value) {
                    setState(() {
                      calculationType = value!;
                      selectedCalculation = options[calculationType]![0];
                    });
                  },
                ),
                Text('Distance/Speed'),
              ],
            ),
            DropdownButton<String>(
              value: selectedCalculation,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCalculation = newValue!;
                });
              },
              items: options[calculationType]!
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value 1',
              ),
            ),
            TextField(
              controller: controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value 2',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
