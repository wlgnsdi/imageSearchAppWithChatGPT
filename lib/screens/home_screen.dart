import 'package:flutter/material.dart';
import 'package:image_search_help/providers/image_provider.dart';
import 'package:provider/provider.dart';
import 'favorites_screen.dart';
import '../widgets/image_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ImageProviderIp>(context, listen: false).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderIp>(context);

    List<Widget> pages = <Widget>[
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    imageProvider.searchImages(_controller.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(child: ImageList(images: imageProvider.images)),
        ],
      ),
      const FavoritesScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Search App'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}