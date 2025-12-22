import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SvgAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final String? fallbackText;

  const SvgAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 20,
    this.fallbackText,
  });

  @override
  Widget build(BuildContext context) {
    // If no URL, show fallback avatar
    if (imageUrl.isEmpty) {
      return _buildFallbackAvatar(context);
    }

    // Show image from URL with caching
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: radius * 2,
          height: radius * 2,
          color: Colors.grey[300],
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => _buildFallbackAvatar(context),
      ),
    );
  }

  Widget _buildFallbackAvatar(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: fallbackText != null && fallbackText!.isNotEmpty
          ? Text(
              fallbackText![0].toUpperCase(),
              style: TextStyle(
                fontSize: radius * 0.8,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            )
          : Icon(Icons.person, size: radius),
    );
  }
}
