import 'dart:ui';

import 'package:flutter/material.dart';

class DetailsBottomBlur extends StatelessWidget {
  const DetailsBottomBlur({super.key});

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.6),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    surface.withAlpha(0),
                    surface.withAlpha(60),
                    surface.withAlpha(250)
                  ],
                  stops: [0.0, 0.5, 1.0]
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}