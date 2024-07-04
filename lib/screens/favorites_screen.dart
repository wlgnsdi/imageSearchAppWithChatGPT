import 'package:flutter/material.dart';
import 'package:image_search_help/providers/image_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/image_list.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderIp>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ImageList(images: imageProvider.favorites),
    );
  }
}
