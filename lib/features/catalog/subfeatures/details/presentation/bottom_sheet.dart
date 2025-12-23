import 'package:flutter/material.dart';

class DetailsBottomSheet extends StatelessWidget {
  const DetailsBottomSheet(this.child, this.height, {super.key});

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: SafeArea(
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, -4)
              )
            ]
          ),
          child: child
        )
      ),
    );
  }
}