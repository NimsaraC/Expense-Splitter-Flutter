import 'package:expense_splitter/main_screen.dart';
import 'package:expense_splitter/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class EvenResultScreen extends StatefulWidget {
  final double amount;
  final int people;
  final String currency;
  const EvenResultScreen(
      {super.key,
      required this.amount,
      required this.people,
      required this.currency});

  @override
  State<EvenResultScreen> createState() => _EvenResultScreenState();
}

class _EvenResultScreenState extends State<EvenResultScreen> {
  double amount = 0.0;
  int people = 0;
  String currency = "";
  double perPerson = 0.0;

  void calculate() {
    setState(() {
      amount = widget.amount;
      people = widget.people;
      currency = widget.currency;
      perPerson = amount / people;
      perPerson = double.parse(perPerson.toStringAsFixed(2));
    });
  }

  @override
  void initState() {
    super.initState();
    calculate();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Here’s the Split",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: gray,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Enter total amount",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "$currency $amount",
                    style: TextStyle(
                      color: gray,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Enter total amount",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "$people people",
                    style: TextStyle(
                      color: gray,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Result",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: width * 0.8,
                    child: shadowContainer(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "$currency $perPerson each ",
                            style: TextStyle(
                              color: gray,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
