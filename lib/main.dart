import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 36, 47, 199)),
        useMaterial3: true,
      ),
      home: MyApps(),
    );
  }
}

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String screenText = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  screenText,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: 'C',
                onTap: () {
                  setState(() {
                    screenText = '0';
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '+/-',
                onTap: () {
                  // TODO
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '%',
                onTap: () {
                  // TODO
                },
              ),
              CalculatorButton.Icon(
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Theme.of(context).primaryColorLight,
                text: 'Backspace',
                icon: Icons.backspace,
                onTap: () {
                  setState(() {
                    if (screenText == '0' ||
                        screenText == '' ||
                        screenText.length == 1) {
                      screenText = '0';
                    } else {
                      screenText =
                          screenText.substring(0, screenText.length - 1);
                    }
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '7',
                onTap: () {
                  pressNumber(7);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '8',
                onTap: () {
                  pressNumber(8);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '9',
                onTap: () {
                  pressNumber(9);
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Theme.of(context).primaryColorLight,
                text: '/',
                onTap: () {
                  if (screenText.contains('/') ||
                      screenText.contains('*') ||
                      screenText.substring(1, screenText.length).contains('-') ||
                      screenText.contains('+')) {
                    List<double> values = [];
                    String operator = '';
                    int now = 0;
                    for (int i = 0; i < screenText.length; i++) {
                      if (screenText[i] == '/' ||
                          screenText[i] == '*' ||
                          screenText[i] == '-' ||
                          screenText[i] == '+') {
                        values.add(double.parse(screenText.substring(now, i)));
                        now = i;
                        operator += screenText[i];
                      }
                    }
                    if (screenText
                        .substring(now, screenText.length)
                        .contains('*')) {
                      values.add(double.parse(
                          screenText.substring(now + 1, screenText.length)));
                    } else {
                      values.add(double.parse(
                          screenText.substring(now + 1, screenText.length)));
                    }

                    double hasil = values[0];
                    for (int i = 0; i < operator.length; i++) {
                      if (operator[i] == '+' || operator[i] == '-') {
                        hasil += values[i + 1];
                      } else if (operator[i] == '/') {
                        hasil /= values[i + 1];
                      } else if (operator[i] == '*') {
                        hasil *= values[i + 1];
                      }
                    }
                    print(hasil);
                    setState(() {
                      if (hasil.toString().contains(".0")) {
                        screenText = hasil.toStringAsFixed(0);
                      } else {
                        screenText = hasil.toString();
                      }
                    });
                  }
                  setState(() {
                    if (screenText.endsWith('/') ||
                        screenText.endsWith('*') ||
                        screenText.endsWith('-') ||
                        screenText.endsWith('+')) {
                    } else {
                      screenText = '$screenText/';
                    }
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '4',
                onTap: () {
                  pressNumber(4);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '5',
                onTap: () {
                  pressNumber(5);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '6',
                onTap: () {
                  pressNumber(6);
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Theme.of(context).primaryColorLight,
                text: 'x',
                onTap: () {
                  setState(() {
                    if (screenText.contains('/') ||
                        screenText.contains('*') ||
                        screenText.substring(1, screenText.length).contains('-') ||
                        screenText.contains('+')) {
                      List<double> values = [];
                      String operator = '';
                      int now = 0;
                      for (int i = 0; i < screenText.length; i++) {
                        if (screenText[i] == '/' ||
                            screenText[i] == '*' ||
                            screenText[i] == '-' ||
                            screenText[i] == '+') {
                          values
                              .add(double.parse(screenText.substring(now, i)));
                          now = i;
                          operator += screenText[i];
                        }
                      }
                      if (screenText
                          .substring(now, screenText.length)
                          .contains('*')) {
                        values.add(double.parse(
                            screenText.substring(now + 1, screenText.length)));
                      } else {
                        values.add(double.parse(
                            screenText.substring(now + 1, screenText.length)));
                      }

                      double hasil = values[0];
                      for (int i = 0; i < operator.length; i++) {
                        if (operator[i] == '+' || operator[i] == '-') {
                          hasil += values[i + 1];
                        } else if (operator[i] == '/') {
                          hasil /= values[i + 1];
                        } else if (operator[i] == '*') {
                          hasil *= values[i + 1];
                        }
                      }
                      print(hasil);
                      setState(() {
                        if (hasil.toString().contains(".0")) {
                          screenText = hasil.toStringAsFixed(0);
                        } else {
                          screenText = hasil.toString();
                        }
                      });
                    }
                    if (screenText.endsWith('/') ||
                        screenText.endsWith('*') ||
                        screenText.endsWith('-') ||
                        screenText.endsWith('+')) {
                    } else {
                      screenText = '$screenText*';
                    }
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '1',
                onTap: () {
                  pressNumber(1);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '2',
                onTap: () {
                  pressNumber(2);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '3',
                onTap: () {
                  pressNumber(3);
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Theme.of(context).primaryColorLight,
                text: '-',
                onTap: () {
                  if (screenText.contains('/') ||
                      screenText.contains('*') ||
                      screenText.substring(1, screenText.length).contains('-') ||
                      screenText.contains('+')) {
                    List<double> values = [];
                    String operator = '';
                    int now = 0;
                    for (int i = 0; i < screenText.length; i++) {
                      if (screenText[i] == '/' ||
                          screenText[i] == '*' ||
                          screenText[i] == '-' ||
                          screenText[i] == '+') {
                        print(screenText.substring(now, i));
                        values.add(double.parse(screenText.substring(now, i)));
                        now = i;
                        operator += screenText[i];
                      }
                    }
                    if (screenText
                        .substring(now, screenText.length)
                        .contains('*')) {
                      values.add(double.parse(
                          screenText.substring(now + 1, screenText.length)));
                    } else {
                      values.add(double.parse(
                          screenText.substring(now, screenText.length)));
                    }

                    double hasil = values[0];
                    for (int i = 0; i < operator.length; i++) {
                      if (operator[i] == '+' || operator[i] == '-') {
                        hasil += values[i + 1];
                      } else if (operator[i] == '/') {
                        hasil /= values[i + 1];
                      } else if (operator[i] == '*') {
                        hasil *= values[i + 1];
                      }
                    }
                    print(hasil);
                    setState(() {
                      if (hasil.toString().contains(".0")) {
                        screenText = hasil.toStringAsFixed(0);
                      } else {
                        screenText = hasil.toString();
                      }
                    });
                    values.clear();
                    operator = "";
                    now = 0;
                  }
                  setState(() {
                    if (screenText.endsWith('/') ||
                        screenText.endsWith('*') ||
                        screenText.endsWith('-') ||
                        screenText.endsWith('+')) {
                    } else {
                      screenText = '$screenText-';
                    }
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '0',
                onTap: () {
                  pressNumber(0);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColorDark,
                text: '.',
                onTap: () {
                  setState(() {
                    if (!screenText.endsWith('.')) {
                      screenText = '$screenText.';
                    }
                  });
                },
              ),
              CalculatorButton(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foregroundColor: Theme.of(context).primaryColorDark,
                  text: '=',
                  onTap: () {
                    if (screenText.endsWith('/') ||
                        screenText.endsWith('*') ||
                        screenText.endsWith('-') ||
                        screenText.endsWith('+')) {
                      setState(() {
                        screenText =
                            screenText.substring(0, screenText.length - 1);
                      });
                    }
                    if (screenText.contains('/') ||
                        screenText.contains('*') ||
                        screenText.substring(1, screenText.length).contains('-') ||
                        screenText.contains('+')) {
                      List<double> values = [];
                      String operator = '';
                      int now = 0;
                      for (int i = 0; i < screenText.length; i++) {
                        if (screenText[i] == '/' ||
                            screenText[i] == '*' ||
                            screenText[i] == '-' ||
                            screenText[i] == '+') {
                          print(screenText.substring(now, i));
                          values
                              .add(double.parse(screenText.substring(now, i)));
                          now = i;
                          operator += screenText[i];
                        }
                      }
                      if (screenText
                          .substring(now, screenText.length)
                          .contains('*')) {
                        values.add(double.parse(
                            screenText.substring(now + 1, screenText.length)));
                      } else if (screenText
                          .substring(now, screenText.length)
                          .contains('/')) {
                        values.add(double.parse(
                            screenText.substring(now + 1, screenText.length)));
                      } else {
                        values.add(double.parse(
                            screenText.substring(now, screenText.length)));
                      }

                      double hasil = values[0];
                      for (int i = 0; i < operator.length; i++) {
                        if (operator[i] == '+' || operator[i] == '-') {
                          hasil += values[i + 1];
                        } else if (operator[i] == '/') {
                          hasil /= values[i + 1];
                        } else if (operator[i] == '*') {
                          hasil *= values[i + 1];
                        }
                      }
                      print(hasil);
                      setState(() {
                        if (hasil.toString().contains(".0")) {
                          screenText = hasil.toStringAsFixed(0);
                        } else {
                          screenText = hasil.toString();
                        }
                      });
                      values.clear();
                      operator = "";
                      now = 0;
                    }
                  }),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Theme.of(context).primaryColorLight,
                text: '+',
                onTap: () {
                  if (screenText.contains('/') ||
                      screenText.contains('*') ||
                      screenText.substring(1, screenText.length).contains('-') ||
                      screenText.contains('+')) {
                    List<double> values = [];
                    String operator = '';
                    int now = 0;
                    for (int i = 0; i < screenText.length; i++) {
                      if (screenText[i] == '/' ||
                          screenText[i] == '*' ||
                          i != 0 ? screenText[i] == '-' : false ||
                          screenText[i] == '+') {
                        values.add(double.parse(screenText.substring(now, i)));
                        now = i;
                        operator += screenText[i];
                      }
                    }
                    if (screenText
                        .substring(now, screenText.length)
                        .contains('*')) {
                      values.add(double.parse(
                          screenText.substring(now + 1, screenText.length)));
                    } else {
                      values.add(double.parse(
                          screenText.substring(now, screenText.length)));
                    }

                    double hasil = values[0];
                    for (int i = 0; i < operator.length; i++) {
                      if (operator[i] == '+' || operator[i] == '-') {
                        hasil += values[i + 1];
                      } else if (operator[i] == '/') {
                        hasil /= values[i + 1];
                      } else if (operator[i] == '*') {
                        hasil *= values[i + 1];
                      }
                    }
                    print(hasil);
                    setState(() {
                      if (hasil.toString().contains(".0")) {
                        screenText = hasil.toStringAsFixed(0);
                      } else {
                        screenText = hasil.toString();
                      }
                    });
                    values.clear();
                      operator = "";
                      now = 0;
                  }
                  setState(() {
                    if (screenText.endsWith('/') ||
                        screenText.endsWith('*') ||
                        screenText.endsWith('-') ||
                        screenText.endsWith('+')) {
                    } else {
                      screenText = '$screenText+';
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void pressNumber(int number) {
    setState(() {
      if (screenText == '0') {
        screenText = '$number';
      } else {
        screenText = '$screenText$number';
      }
    });
  }
}

class CalculatorButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  IconData? icon;
  final Function() onTap;

  CalculatorButton({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.onTap,
  });

  CalculatorButton.Icon({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        child: Center(
          child: icon == null
              ? Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: foregroundColor),
                )
              : Icon(
                  icon,
                  color: foregroundColor,
                ),
        ),
      ),
    );
  }
}
