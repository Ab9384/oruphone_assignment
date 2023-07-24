import 'package:flutter/material.dart';

class BrandIcon extends StatelessWidget {
  final String brandName;
  const BrandIcon({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            'images/$brandName.png',
            height: 40,
          ),
        ),
      ),
    );
  }
}
