import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loaders/primary_app_loader_widget.dart';

class DoneeLogoWidget extends StatelessWidget {
  const DoneeLogoWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: 40,
      height: 40,
      placeholder: (context, url) => const PrimaryAppLoader(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
