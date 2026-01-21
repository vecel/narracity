import 'package:flutter/material.dart';
import 'package:narracity/shared_widgets/cached_image.dart';

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
            child: CachedImage(
              url: image,
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer
                ),
              ),
            )
          ),
          Expanded(child: Container())
        ],
      )
    );
  }
}