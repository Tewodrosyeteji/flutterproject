import 'package:flutter/material.dart';

class reusedCard extends StatelessWidget {
  reusedCard(this.colour, this.childCard, this.onPress);
  Color colour;
  Widget childCard;
  Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: childCard,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
