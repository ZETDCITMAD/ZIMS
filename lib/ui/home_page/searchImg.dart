import 'package:flutter/material.dart';

class SearchImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'android/assets/search.png',
        width: 400.0,
        height: 400.0,
      ),
    );
  }
}