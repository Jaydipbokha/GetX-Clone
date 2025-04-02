import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../presentation/dashboard/view/dashboard_screen.dart';


class CustomBottomBar extends StatefulWidget {

  const CustomBottomBar({super.key,});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: "Search",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  List<Widget> _screens() {
    return [DashboardScreen(), DashboardScreen(), DashboardScreen()];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens(),
        items: _navBarItems(),
        backgroundColor: Colors.white,
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }

}
