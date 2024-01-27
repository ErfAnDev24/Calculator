import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calaculator());
}

class Calaculator extends StatefulWidget {
  const Calaculator({super.key});

  @override
  State<Calaculator> createState() => _CalaculatorState();
}

class _CalaculatorState extends State<Calaculator> {
  var inputText = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 36, 78, 151),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: double.infinity),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '$inputText',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 102, 238, 107),
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '${result}',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 7, 45, 110),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getRows('AC', 'CL', '%', '/'),
                    getRows('7', '8', '9', '*'),
                    getRows('4', '5', '6', '-'),
                    getRows('1', '2', '3', '+'),
                    getRows('00', '0', '.', '='),
                  ],
                ),
              ),
              flex: 7,
            ),
          ]),
        ),
      ),
    );
  }

  Widget getRows(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        createTextButton(text1),
        createTextButton(text2),
        createTextButton(text3),
        createTextButton(text4),
      ],
    );
  }

  bool isOperator(String text) {
    var operatorList = ['AC', 'CL', '%', '/', '*', '-', '+', '='];
    if (operatorList.contains(text)) {
      return true;
    }
    return false;
  }

  Color getColor(String text) {
    if (isOperator(text)) {
      return Color.fromARGB(255, 36, 78, 151);
    }
    return Color.fromARGB(255, 7, 45, 110);
  }

  Color getOperatorColor(String text) {
    if (isOperator(text)) {
      return Color.fromARGB(255, 49, 200, 81);
    }
    return Color.fromARGB(237, 132, 189, 255);
  }

  Widget createTextButton(String text) {
    return TextButton(
      onPressed: () {
        setState(() {
          if (text == 'AC') {
            clearAll();
            return;
          }
          if (text == 'CL' && inputText != '') {
            inputText = inputText.substring(0, inputText.length - 1);
            return;
          }

          if (text == '=') {
            Parser parser = Parser();
            Expression expression = parser.parse(inputText);
            ContextModel context = ContextModel();
            double numbericResult =
                expression.evaluate(EvaluationType.REAL, context);
            result = numbericResult.toString();

            return;
          }

          if (text != 'CL' || text != 'AC') {
            inputText = inputText + text;
          }
        });
      },
      style: TextButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: Colors.transparent),
        ),
        backgroundColor: getColor(text),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          '$text',
          style: TextStyle(fontSize: 20, color: getOperatorColor(text)),
        ),
      ),
    );
  }

  void clearAll() {
    inputText = '';
    result = '';
  }
}
