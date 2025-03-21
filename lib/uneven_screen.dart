import 'package:expense_splitter/main_screen.dart';
import 'package:expense_splitter/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UnevenScreen extends StatefulWidget {
  final double amount;
  final int people;
  final String currency;
  const UnevenScreen({
    super.key,
    required this.amount,
    required this.people,
    required this.currency,
  });

  @override
  State<UnevenScreen> createState() => _UnevenScreenState();
}

class _UnevenScreenState extends State<UnevenScreen> {
  double totalAmount = 0.0;
  int numberOfPeople = 0;
  String currency = "";
  late List<TextEditingController> controllers;
  double remainingAmount = 0.0;

  @override
  void initState() {
    super.initState();
    totalAmount = widget.amount;
    numberOfPeople = widget.people;
    currency = widget.currency;
    controllers = List.generate(
      numberOfPeople,
      (index) => TextEditingController(),
    );
    remainingAmount = totalAmount;
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double calculateTotalEntered() {
    double total = 0.0;
    for (var controller in controllers) {
      total += double.tryParse(controller.text) ?? 0.0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: primaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  "Custom Split",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gray,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Enter total amount",
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "$currency ${totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: gray,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Remaining: $currency ${remainingAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: remainingAmount < 0 ? Colors.red : gray,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "Number of People: $numberOfPeople",
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: numberOfPeople,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final person = index + 1;
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: shadowContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Person $person: ",
                                style: TextStyle(
                                  color: gray,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  controller: controllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0.00",
                                    hintStyle: TextStyle(
                                      color: gray,
                                      fontSize: 25,
                                    ),
                                    prefixText: "$currency ",
                                    prefixStyle: TextStyle(
                                      color: gray,
                                      fontSize: 25,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: gray,
                                    fontSize: 25,
                                  ),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        remainingAmount = totalAmount -
                                            calculateTotalEntered();
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
