import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/image_model.dart';

class ImageProviderIp with ChangeNotifier {
  List<ImageModel> _images = [];
  List<ImageModel> _favorites = [];

  List<ImageModel> get images => _images;
  List<ImageModel> get favorites => _favorites;

  Future<void> searchImages(String query) async {
    final url = 'https://dapi.kakao.com/v2/search/image?query=$query';
    final headers = {'Authorization': dotenv.env['rest_key'].toString()};
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _images = (data['documents'] as List)
          .map((item) => ImageModel.fromJson(item))
          .toList();
      notifyListeners();
    }
  }

  void toggleFavorite(ImageModel image) {
    if (_favorites.contains(image)) {
      _favorites.remove(image);
    } else {
      _favorites.add(image);
    }
    saveFavorites();
    notifyListeners();
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteList = prefs.getStringList('favorites');

    if (favoriteList != null) {
      _favorites = favoriteList.map((item) => ImageModel.fromJson(json.decode(item))).toList();
    }
    notifyListeners();
  }

  void saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = _favorites.map((item) => json.encode({
      'image_url': item.imageUrl,
      'display_sitename': item.displaySiteName,
    })).toList();

    prefs.setStringList('favorites', favoriteList);
  }
}