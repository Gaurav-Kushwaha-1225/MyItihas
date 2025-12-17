import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final isSvg =
        imageUrl.toLowerCase().endsWith('.svg') ||
        imageUrl.contains('/svg?') ||
        imageUrl.contains('.svg?');

    if (imageUrl.isEmpty) {
      return CircleAvatar(
        radius: radius,
        child: fallbackText != null && fallbackText!.isNotEmpty
            ? Text(fallbackText![0].toUpperCase())
            : const Icon(Icons.person),
      );
    }

    if (isSvg) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: SvgPicture.network(
            imageUrl,
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            placeholderBuilder: (context) =>
                Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      onBackgroundImageError: (_, _) {},
      child: null,
    );
  }
}
