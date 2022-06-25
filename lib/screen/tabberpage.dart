import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/screen/homepage.dart';
import 'package:flutter_app2/screen/profilepage.dart';

class TabberPage extends StatefulWidget {
  @override
  State<TabberPage> createState() => _TabberPageState();
}

class _TabberPageState extends State<TabberPage> {
  int _index = 0;
  late PageController _pageController;

  // List
  List _title = [
    'Home',
    'Profile',
  ];
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: _index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text(
          _title[_index],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          children: [
            HomePage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget bottomBar() {
    return BottomNavyBar(
      selectedIndex: _index,
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.amber),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Person'),
            activeColor: Colors.amber),
      ],
      onItemSelected: (_index) {
        setState(() {
          _index = _index;
        });
      },
    );
  }
}
