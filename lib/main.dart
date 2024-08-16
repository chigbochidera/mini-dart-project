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
    'Newtons Second Law': [
      'Force',
      'Momentum',
      'Impulse',
      'Centripetal Force',
      'Gravitational Force'
    ],
  };

  // Number of input fields for each calculation
  final Map<String, int> inputCount = {
    'Kinetic Energy': 2,
    'Potential Energy': 2,
    'Work Done': 2,
    'Power': 2,
    'Average Speed': 2,
    'Distance Travelled': 2,
    'Time of Travel': 2,
    'Force': 2,
    'Momentum': 2,
    'Impulse': 2,
    'Centripetal Force': 3,
    'Gravitational Force': 3
  };

  // Labels for input fields based on the calculation
  final Map<String, List<String>> inputLabels = {
    'Kinetic Energy': ['Mass (kg)', 'Velocity (m/s)'],
    'Potential Energy': ['Mass (kg)', 'Height (m)'],
    'Work Done': ['Force (N)', 'Distance (m)'],
    'Power': ['Work Done (J)', 'Time (s)'],
    'Average Speed': ['Distance (m)', 'Time (s)'],
    'Distance Travelled': ['Speed (m/s)', 'Time (s)'],
    'Time of Travel': ['Distance (m)', 'Speed (m/s)'],
    'Force': ['Mass(kg)', 'Acceleration(m/s²)'],
    'Momentum': ['Mass(kg)', 'Velocity(m/s)'],
    'Impulse': ['Force(N)', 'Time(s)'],
    'Centripetal Force': ['Mass(kg)', 'Velocity(m/s)', 'Radius(m)'],
    'Gravitational Force': [
      'Mass1(m1)',
      'Mass2(m2)',
      'Distance Between Centre of masses(r)'
    ]
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
            'Potential Energy: ${(value1 * value2 * 9.8).toStringAsFixed(2)} J';
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
      } else if (selectedCalculation == 'Force') {
        result = 'Force: ${(value1 * value2).toStringAsFixed(2)} N';
      } else if (selectedCalculation == 'Momentum') {
        result = 'Momentum: ${(value1 * value2).toStringAsFixed(2)} kgm/s';
      } else if (selectedCalculation == 'Impulse') {
        result = 'Impulse: ${(value1 * value2).toStringAsFixed(2)} Ns';
      } else if (selectedCalculation == 'Centripetal Force') {
        result =
            'Centripetal Force: ${((value1 * (value2 * value2)) / (value3)).toStringAsFixed(2)} N';
      } else if (selectedCalculation == 'Gravitational Force') {
        result =
            'Gravitational Force: ${(9.8 * ((value1 * value2) / (value3 * value3))).toStringAsFixed(2)} (kgm/s²';
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
                      Radio(
                        value: 'Newtons Second Law',
                        groupValue: calculationType,
                        onChanged: (value) {
                          setState(() {
                            calculationType = value!;
                            selectedCalculation = options[calculationType]![0];
                            updateInputFields();
                          });
                        },
                      ),
                      Text("Newton's Law"),
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
