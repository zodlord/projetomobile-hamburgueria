import 'package:flutter/material.dart';
import 'package:jacksonsburger/components/bottom_navigation_bar.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculadoraPage extends StatefulWidget {
  static const String id = 'calculadora_page';
  static const String routeName = 'calculadora_page';

  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50, left: 10, right: 10),
                  alignment: Alignment.topRight,
                  child: Text(
                    userInput,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.topRight,
                  child: Text(
                    result,
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),

          Expanded(
              child: Container(
                padding: EdgeInsets.only(top:30, left: 30, right: 30),
                child: GridView.builder(
                  itemCount: buttonList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CustomButton(buttonList[index]);
                    }
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarClass(),
    );
  }
  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.red[700],
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, -3),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return Colors.red[700];
    }
    return Colors.black;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return Colors.red[700];
    }
    if (text == "=") {
      return Colors.red;
    }
    return Colors.white;
  }

  handleButtons(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }

    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length -1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      result = calculate();
      userInput = result;

      if(userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
        return;
      }

      if(result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Erro";
    }
  }
}