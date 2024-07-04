import 'package:flutter/material.dart';
import 'package:image_search_help/models/image_model.dart';
import 'package:image_search_help/providers/image_provider.dart';
import 'package:image_search_help/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class ImageItem extends StatelessWidget {
  final ImageModel image;

  const ImageItem({required this.image});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderIp>(context);
    final isFavorite = imageProvider.favorites.contains(image);

    return ListTile(
      leading: Image.network(image.imageUrl),
      title: Text(image.displaySiteName),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () {
          imageProvider.toggleFavorite(image);
        },
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(imageUrl: image.imageUrl),
          ),
        );
      },
    );
  }
}
