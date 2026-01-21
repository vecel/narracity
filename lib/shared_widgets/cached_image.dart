import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.url, this.errorWidget});

  final String url;
  final Widget Function(BuildContext context, String url, Object error)? errorWidget;

  @override
  Widget build(BuildContext context) {
    // Cache manager should not be provided in production. It is provided in tests.
    final cacheManager = context.read<BaseCacheManager?>();

    return CachedNetworkImage(
      cacheManager: cacheManager,
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: errorWidget ?? (context, url, error) => Center(
        child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
      ),
    );
  }
}