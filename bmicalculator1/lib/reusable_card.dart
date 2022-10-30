import 'package:flutter/material.dart';

class Reusablecard extends StatelessWidget {
  final Color? colour;
  final Widget? childCard;
  final onPress;
  Reusablecard({@required this.colour, this.childCard, this.onPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: childCard,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: colour, borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
