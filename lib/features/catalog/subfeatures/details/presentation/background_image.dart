import 'package:flutter/material.dart';

class DetailsBackgroundImage extends StatelessWidget {
  const DetailsBackgroundImage(this.image, this.height, {super.key});

  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: Image(
              image: NetworkImage(image), 
              fit: BoxFit.cover
            )
          ),
          Expanded(child: Container())
        ],
      )
    );
  }
}