import 'package:flutter/material.dart';
import 'reusablecard.dart';
import 'icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const botttomContainerHeight = 80.0;
const activeCardColor = Color(0xFF1D1F33);
const inactiveCardColor = Color(0xFF111328);
const bottomContainerColor = Color(0xFFEB1555);

enum GenderTye { male, female }

class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  GenderTye? selectGender;

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
                  child: reusedCard(
                    selectGender == GenderTye.male
                        ? activeCardColor
                        : inactiveCardColor,
                    IconContent(FontAwesomeIcons.mars, 'MALE'),
                    () {
                      setState(() {
                        selectGender = GenderTye.male;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: reusedCard(
                    selectGender == GenderTye.female
                        ? activeCardColor
                        : inactiveCardColor,
                    IconContent(FontAwesomeIcons.venus, 'FEMALE'),
                    () {
                      setState(() {
                        selectGender = GenderTye.male;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          // Expanded(
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child: reusedCard(activeCardColor,
          //               IconContent(FontAwesomeIcons.mars, 'MALE'))),
          //     ],
          //   ),
          // ),
          // Expanded(
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child: reusedCard(activeCardColor,
          //               IconContent(FontAwesomeIcons.mars, 'MALE'))),
          //       Expanded(
          //           child: reusedCard(activeCardColor,
          //               IconContent(FontAwesomeIcons.mars, 'MALE')))
          //     ],
          //   ),
          // ),
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
