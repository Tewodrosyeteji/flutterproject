import 'package:bmicalculator1/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Reusable_card.dart';
import 'icon_content.dart';
import 'constants.dart';
import 'result_page.dart';

enum Gender { male, female }

const activeColorCard = Color(0xFF1D1F33);
const inactiveColorCard = Color(0xFF111328);

class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectGender;
  int height = 180;
  int weight = 45;
  int age = 12;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0XFFFFFFFF),
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Reusablecard(
                    onPress: () {
                      setState(() {
                        selectGender = Gender.male;
                      });
                    },
                    colour: selectGender == Gender.male
                        ? activeColorCard
                        : inactiveColorCard,
                    childCard:
                        IconContent(icon: FontAwesomeIcons.mars, lable: 'MALE'),
                  ),
                ),
                Expanded(
                  child: Reusablecard(
                    onPress: () {
                      setState(() {
                        selectGender = Gender.female;
                      });
                    },
                    colour: selectGender == Gender.female
                        ? activeColorCard
                        : inactiveColorCard,
                    childCard: IconContent(
                        icon: FontAwesomeIcons.venus, lable: 'FEMALE'),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Reusablecard(
                    colour: activeColorCard,
                    childCard: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('HEIGHT', style: KLableTextStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(height.toString(), style: KNumberTextStyle),
                            Text('cm')
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              overlayColor: Color(0x29EB1555),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 13.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 26.0)),
                          child: Slider(
                            value: height.toDouble(),
                            activeColor: Color(0xFFFFFFFF),
                            inactiveColor: Color(0xFF8D8E98),
                            thumbColor: Color(0xFFEB1555),
                            min: 140.0,
                            max: 260.0,
                            onChanged: ((double newValue) {
                              setState(() {
                                height = newValue.round();
                              });
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Reusablecard(
                    colour: Color(0xFF1D1F33),
                    childCard: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: KLableTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: KNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButtonIcon(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                }),
                            SizedBox(width: 10.0),
                            RoundButtonIcon(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Reusablecard(
                    colour: Color(0xFF1D1F33),
                    childCard: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: KLableTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: KNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButtonIcon(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                }),
                            SizedBox(width: 10.0),
                            RoundButtonIcon(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResultPage()));
            },
            child: Container(
              child: Text('CALCULATER'),
              margin: EdgeInsets.all(10.0),
              color: Color(0xFFEB1555),
              height: 70.0,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}

class RoundButtonIcon extends StatelessWidget {
  final IconData? icon;
  final onPressed;
  RoundButtonIcon({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon),
      fillColor: Color(0xFF4C4F5E),
      elevation: 1.0,
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
    );
  }
}
