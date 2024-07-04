import 'package:flutter/material.dart';
import '../models/image_model.dart';
import '../widgets/image_item.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList({required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ImageItem(image: images[index]);
      },
    );
  }
}