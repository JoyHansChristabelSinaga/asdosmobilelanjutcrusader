import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/get_recipe.dart';
import 'explore_screen.dart';
import 'grocery_screen.dart';
import 'recipes_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.currentTab,
  });

  final int currentTab;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const String prefSelectedIndexKey = 'selectedTab';
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    //RecipesScreen(),
    const GroceryScreen(),
  ];
  @override
  void initState() {
    super.initState();
    getCurrentIndex();
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        final index = prefs.getInt(prefSelectedIndexKey);
        if (index != null) {
          _selectedIndex = index;
        }
      });
    }
  }
  // @override
  // void initstate() {
  //   super.initState();
  //   getCurrentIndex();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mahasiswa Space',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          profileButton(widget.currentTab),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        // currentIndex: widget.currentTab,
        currentIndex: _selectedIndex,
        onTap: (index) {
          // GetRecipe.getRecipes();
          setState(() {
            _selectedIndex = index;
          });
          saveCurrentIndex();
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Forum',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.book),
          //   label: 'Matkul',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'setting',
          ),
        ],
      ),
    );
  }

  Widget profileButton(int currentTab) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/blah.jpg',
          ),
        ),
        onTap: () {
          context.goNamed('profile', params: {
            'tab': '$currentTab',
          });
        },
      ),
    );
  }

  void saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefSelectedIndexKey, _selectedIndex);
  }
}
