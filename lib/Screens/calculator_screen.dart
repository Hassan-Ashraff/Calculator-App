
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget box(String text, Color color) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    double heightScreen = MediaQuery.sizeOf(context).height;

    return InkWell(
      onTap: () {
        setState(() {
          OnTap(text);
        });
      },
      child: Container(
          height: heightScreen*0.11,
          width: widthScreen* .235,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: widthScreen*0.1,
              fontWeight: FontWeight.w700,
            ),
          ))),
    );
  }

  Widget boxForZero(String text) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    double heightScreen = MediaQuery.sizeOf(context).height;
    return InkWell(
      onTap: () {
        setState(() {
          OnTap(text);
        });
      },
      child: Container(
          height: heightScreen*0.11,
          width: widthScreen * .239 * 2,
          decoration: const BoxDecoration(
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
              fontSize: widthScreen*0.1,
              fontWeight: FontWeight.w700,
            ),
          ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    double heightScreen = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xff14283D),
      body: SafeArea(
        child: SizedBox(
          width:widthScreen,
          height: heightScreen,
          child: Column(
            children: [
               SizedBox(
                height: heightScreen*0.035,
              ),
              Container(
                width: widthScreen,
                color: const Color(0xff0A121D),
                height: heightScreen*0.3,
                child: Padding(
                  padding:  EdgeInsets.all(widthScreen*0.03),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(finalValue.isEmpty ? '0' : finalValue,
                            style:
                            const TextStyle(color: Colors.white, fontSize: 55)),
                      ],
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: heightScreen*0.03,
              ),
              Padding(
                padding:
                     EdgeInsets.symmetric(horizontal: widthScreen*0.015, vertical: heightScreen*0.003),
                child: Row(
                  children: [
                    box('C', const Color(0xff53575f)),
                     SizedBox(width: widthScreen*0.01),
                    box('+/-', const Color(0xff53575f)),
                    SizedBox(width: widthScreen*0.01),
                    box('%', const Color(0xff53575f)),
                    SizedBox(width: widthScreen*0.01),
                    box('÷', const Color(0xff1E587A)),
                  ],
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: widthScreen*0.015, vertical: heightScreen*0.003),
                child: Row(
                  children: [
                    box('7', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('8', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('9', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('x', const Color(0xff1E587A)),
                  ],
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: widthScreen*0.015, vertical: heightScreen*0.003),
                child: Row(
                  children: [
                    box('4', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('5', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('6', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('-', const Color(0xff1E587A)),
                  ],
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: widthScreen*0.015, vertical: heightScreen*0.003),
                child: Row(
                  children: [
                    box('1', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('2', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('3', const Color(0xff787678)),
                    SizedBox(width: widthScreen*0.01),
                    box('+', const Color(0xff1E587A)),
                  ],
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: widthScreen*0.015, vertical: heightScreen*0.003),
                child: Row(
                  children: [
                    boxForZero('0'),
                    SizedBox(width: widthScreen*0.01),
                    InkWell(
                        onTap: () {
                          OnTap('.');
                        },
                        child: box('.', const Color(0xff53575f))),
                    SizedBox(width: widthScreen*0.01),
                    box('=', const Color(0xff1E587A)),
                  ],
                ),
              ),
            ],
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
