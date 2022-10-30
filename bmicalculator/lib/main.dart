import 'package:flutter/material.dart';

const botttomContainerHeight = 80.0;
const activeCardColor = Color(0xFF1D1F33);
const bottomContainerColor = Color(0xFFEB1555);
void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0D22),
          scaffoldBackgroundColor: Color(0xFF0A0D22),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: reusedCard(activeCardColor),
                ),
                Expanded(child: reusedCard(activeCardColor))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: reusedCard(activeCardColor)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: reusedCard(activeCardColor)),
                Expanded(child: reusedCard(activeCardColor))
              ],
            ),
          ),
          Container(
            color: bottomContainerColor,
            width: double.infinity,
            height: botttomContainerHeight,
          )
        ],
      ),
    );
  }
}

class reusedCard extends StatelessWidget {
  reusedCard(this.colour);
  Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
