import 'package:expense_splitter/main_screen.dart';
import 'package:expense_splitter/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Expense\nSplitter",
                      style: TextStyle(
                        fontSize: 50,
                        color: gray,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.mogra().fontFamily,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Split expenses fast, fair, and easy!",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.4,
                width: width,
                child: Image.asset(
                  "assets/splash.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                },
                child: Container(
                  width: width * 0.7,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 5),
                          color: const Color.fromARGB(255, 97, 163, 143),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          offset: Offset(-5, -5),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          blurRadius: 10,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: gray,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
