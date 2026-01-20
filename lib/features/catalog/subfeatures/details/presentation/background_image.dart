import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer
                ),
                child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            )
            // Image(
            //   image: NetworkImage(image), 
            //   fit: BoxFit.cover
            // )
          ),
          Expanded(child: Container())
        ],
      )
    );
  }
}