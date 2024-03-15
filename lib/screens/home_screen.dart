import 'package:flutter/material.dart';
import 'package:nekoflixx/pages/discover_page.dart';
import 'package:nekoflixx/pages/home_page.dart';
import 'package:nekoflixx/pages/profile_page.dart';
import 'package:nekoflixx/pages/search_page.dart';
import 'package:nekoflixx/widgets/exit_confirmation.dart';
import 'package:nekoflixx/widgets/nekoflixx_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const DiscoverPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    const pages = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          // If on HomePage, exit the app
          return await showDialog(
            context: context,
            builder: (context) => const ExitConfirmation(),
          );
        } else {
          // If on SearchPage or ProfilePage or DiscoverPage, navigate back to HomePage
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        // Close the app when the back button is pressed
      },
      child: Scaffold(
        appBar: const NekoflixxAppBar(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue, // Set selected item color to blue
          unselectedItemColor: Colors.white,
          onTap: _navigateBottomBar,
          items: pages,
        ),
      ),
    );
  }
}
