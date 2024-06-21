
import 'package:flutter/material.dart';

class Calculator_screen extends StatefulWidget {
  const Calculator_screen({super.key});
  @override
  State<Calculator_screen> createState() => _Calculator_screenState();
}

class _Calculator_screenState extends State<Calculator_screen> {
  Widget box(String text, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          OnTap(text);
        });
      },
      child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * .235,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                ),
              ))),
    );
  }

  Widget boxForZero(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          OnTap(text);
        });
      },
      child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * .235 * 2,
          decoration: BoxDecoration(
            color: Color(0xff787678),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                ),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff14283D),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff0A121D),
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('$finalValue'.isEmpty ? '0' : '$finalValue',
                              style:
                              TextStyle(color: Colors.white, fontSize: 55)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    children: [
                      box('C', Color(0xff53575f)),
                      const SizedBox(width: 3),
                      box('+/-', Color(0xff53575f)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('%', Color(0xff53575f)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('÷', Color(0xff1E587A)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    children: [
                      box('7', Color(0xff787678)),
                      const SizedBox(width: 3),
                      box('8', Color(0xff787678)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('9', Color(0xff787678)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('x', Color(0xff1E587A)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    children: [
                      box('4', Color(0xff787678)),
                      const SizedBox(width: 3),
                      box('5', Color(0xff787678)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('6', Color(0xff787678)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('-', Color(0xff1E587A)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    children: [
                      box('1', Color(0xff787678)),
                      const SizedBox(width: 3),
                      box('2', Color(0xff787678)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('3', Color(0xff787678)),
                      const SizedBox(
                        width: 3,
                      ),
                      box('+', Color(0xff1E587A)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Row(
                    children: [
                      boxForZero('0'),
                      const SizedBox(
                        width: 3,
                      ),
                      InkWell(
                          onTap: () {
                            OnTap('.');
                          },
                          child: box('.', Color(0xff53575f))),
                      const SizedBox(
                        width: 3,
                      ),
                      box('=', Color(0xff1E587A)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String finalValue = '';
  String operator = '';
  double sum = 0;
  String currentNumber = '';
  double negative = -1;

  void OnTap(String value) {
    setState(() {
      if (value == 'C') {
        finalValue = '';
        sum = 0;
        currentNumber = '';
        operator = '';
        return;
      }
      if (value == '+/-') {
        sum = double.parse(currentNumber)* negative;
        currentNumber ='$sum';
        finalValue = '$sum';
        finalValue = finalValue.replaceFirst(RegExp(r'\.0$'), '');
        return;
      }
      if (value == '%') {
        sum += int.parse(currentNumber) / 100;
        finalValue = '$sum';
        return;
      }

      if (value == '=') {
        operation();
        operator = '';
        return;
      }
      if ('+-x÷%'.contains(value)) {
        if (operator.isNotEmpty) {
          operation();
        } else {
          sum = double.parse(currentNumber);
        }
        operator = value;
        currentNumber = '';
      } else {
        currentNumber += value;
      }

      finalValue += value;
    });
  }

  void operation() {
    double num = double.parse(currentNumber);
    switch (operator) {
      case '+':
        sum += num;
        break;
      case '-':
        sum -= num;
        break;
      case 'x':
        sum *= num;
        break;
      case '÷':
        sum /= num;
        break;
    }
    finalValue = sum.toString();
    finalValue = finalValue.replaceFirst(RegExp(r'\.0$'), '');

    currentNumber = sum.toString();
  }
}
