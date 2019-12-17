import 'package:flutter/material.dart';

class ImageField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.6,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.asset(
        "assets/pet.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
