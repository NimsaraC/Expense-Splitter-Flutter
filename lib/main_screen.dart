import 'package:expense_splitter/even_result_screen.dart';
import 'package:expense_splitter/uneven_screen.dart';
import 'package:expense_splitter/utils/constants/colors.dart';
import 'package:expense_splitter/utils/constants/currencies.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isEvenly = true;
  String selectedCurrency = 'LKR';

  List<String> currencies = ['Rs', '\$', '€', '£', '¥'];

  final TextEditingController amountController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currencies = getCurrencies();
    peopleController.text = "1";
    amountController.text = "0.00";
  }

  void validate() {
    if (key.currentState!.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return isEvenly
              ? EvenResultScreen(
                  amount: double.parse(amountController.text),
                  people: int.parse(peopleController.text),
                  currency: selectedCurrency,
                )
              : UnevenScreen(
                  amount: double.parse(amountController.text),
                  people: int.parse(peopleController.text),
                  currency: selectedCurrency,
                );
        },
      ));
    } else {
      print("Not Validated");
    }
  }

  void changePeople(bool isIncrease) {
    setState(() {
      isIncrease
          ? peopleController.text =
              (int.parse(peopleController.text) + 1).toString()
          : int.parse(peopleController.text) > 1
              ? peopleController.text =
                  (int.parse(peopleController.text) - 1).toString()
              : null;
    });
  }

  void changeType() {
    setState(() {
      isEvenly = !isEvenly;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          color: primaryColor,
          child: SingleChildScrollView(
            child: SizedBox(
              width: width,
              child: Form(
                key: key,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Expense Splitter",
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
                    Row(
                      children: [
                        SizedBox(width: 20),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: shadowContainer(
                            color: green,
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedCurrency,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCurrency = newValue!;
                                    });
                                  },
                                  items:
                                      currencies.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            value,
                                            style: TextStyle(
                                              color: gray,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  dropdownColor: green,
                                  icon: SizedBox.shrink(),
                                  style: TextStyle(
                                    color: gray,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        SizedBox(
                          height: 70,
                          width: width - 140,
                          child: shadowContainer(
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter a valid amount";
                                    } else if (double.parse(value) <= 0) {
                                      return "Please enter a valid amount";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0.00",
                                    hintStyle: TextStyle(
                                      color: gray,
                                      fontSize: 25,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: gray,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    // Rest of your existing code remains the same...
                    SizedBox(height: 20),
                    Text(
                      "Number of People",
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => changePeople(false),
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: shadowContainer(
                              color: green,
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    color: gray,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          height: 70,
                          width: width - 220,
                          child: shadowContainer(
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: peopleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter a valid number";
                                    } else if (int.parse(value) <= 0) {
                                      return "Please enter a valid number";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "1",
                                    hintStyle: TextStyle(
                                      color: secondaryColor.withOpacity(0.5),
                                      fontSize: 25,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: gray,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => changePeople(true),
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: shadowContainer(
                              color: green,
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: gray,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Split evenly? : ${isEvenly ? "Yes" : "No"}",
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: shadowContainer(
                        color: green,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => changeType(),
                              child: Container(
                                width: width / 2 - 20,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: isEvenly ? green : primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: gray,
                                      fontSize: 25,
                                      fontWeight: isEvenly
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => changeType(),
                              child: Container(
                                width: width / 2 - 20,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: isEvenly ? primaryColor : green,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      color: gray,
                                      fontSize: 25,
                                      fontWeight: isEvenly
                                          ? FontWeight.normal
                                          : FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () => validate(),
                        child: shadowContainer(
                          color: secondaryColor,
                          child: Container(
                            height: 70,
                            child: Center(
                              child: Text(
                                "Calculate",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
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
      ),
    );
  }
}

Widget shadowContainer({
  required Widget child,
  Color? color,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color ?? primaryColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: Offset(3, 3),
          color: color == null
              ? Colors.greenAccent
              : const Color.fromARGB(255, 147, 182, 231),
          blurRadius: 15,
        ),
        BoxShadow(
          offset: Offset(-10, -10),
          color: Colors.white,
          blurRadius: 10,
        ),
      ],
    ),
    child: child,
  );
}
