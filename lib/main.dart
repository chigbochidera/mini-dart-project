import 'package:flutter/material.dart';

void main() {
  runApp(PhysicsCalculatorApp());
}

class PhysicsCalculatorApp extends StatelessWidget {
  const PhysicsCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
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
    'Distance/Speed': ['Average Speed', 'Distance Travelled', 'Time of Travel'],
  };

  // Number of input fields for each calculation
  final Map<String, int> inputCount = {
    'Kinetic Energy': 2,
    'Potential Energy': 3, // Updated to 3 inputs
    'Work Done': 2,
    'Power': 2,
    'Average Speed': 2,
    'Distance Travelled': 2,
    'Time of Travel': 2,
  };

  // Labels for input fields based on the calculation
  final Map<String, List<String>> inputLabels = {
    'Kinetic Energy': ['Mass (kg)', 'Velocity (m/s)'],
    'Potential Energy': ['Mass (kg)', 'Height (m)', 'Gravity (m/s²)'],
    'Work Done': ['Force (N)', 'Distance (m)'],
    'Power': ['Work Done (J)', 'Time (s)'],
    'Average Speed': ['Distance (m)', 'Time (s)'],
    'Distance Travelled': ['Speed (m/s)', 'Time (s)'],
    'Time of Travel': ['Distance (m)', 'Speed (m/s)'],
  };

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController()
  ];

  String result = '';

  void calculate() {
    double value1 = double.tryParse(controllers[0].text) ?? 0;
    double value2 = double.tryParse(controllers[1].text) ?? 0;
    double value3 =
        controllers.length > 2 ? double.tryParse(controllers[2].text) ?? 0 : 0;

    setState(() {
      if (selectedCalculation == 'Kinetic Energy') {
        result =
            'Kinetic Energy: ${(0.5 * value1 * value2 * value2).toStringAsFixed(2)} J';
      } else if (selectedCalculation == 'Potential Energy') {
        result =
            'Potential Energy: ${(value1 * value2 * value3).toStringAsFixed(2)} J';
      } else if (selectedCalculation == 'Work Done') {
        result = 'Work Done: ${(value1 * value2).toStringAsFixed(2)} J';
      } else if (selectedCalculation == 'Power') {
        result = 'Power: ${(value1 / value2).toStringAsFixed(2)} W';
      } else if (selectedCalculation == 'Average Speed') {
        result = 'Average Speed: ${(value1 / value2).toStringAsFixed(2)} m/s';
      } else if (selectedCalculation == 'Distance Travelled') {
        result =
            'Distance Travelled: ${(value1 * value2).toStringAsFixed(2)} m';
      } else if (selectedCalculation == 'Time of Travel') {
        result = 'Time of Travel: ${(value1 / value2).toStringAsFixed(2)} s';
      } else {
        result = 'Invalid Calculation';
      }
    });
  }

  void updateInputFields() {
    int count = inputCount[selectedCalculation] ?? 2;
    controllers = List.generate(count, (index) => TextEditingController());
  }

  @override
  void initState() {
    super.initState();
    updateInputFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.webp',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Physics Calculator',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 'Energy/Power',
                        groupValue: calculationType,
                        onChanged: (value) {
                          setState(() {
                            calculationType = value!;
                            selectedCalculation = options[calculationType]![0];
                            updateInputFields();
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
                            updateInputFields();
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
                        updateInputFields();
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
                  SizedBox(height: 20),
                  ...List.generate(controllers.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: controllers[index],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: inputLabels[selectedCalculation]?[index] ??
                              'Value ${index + 1}',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: calculate,
                    child: Text('Calculate'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    result,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
