import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined, size: 26),
          label: "Gallery",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.gavel_rounded, size: 26),
          label: "Bidding",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 30),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline, size: 26),
          label: "Add Post",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined, size: 26),
          label: "Profile",
        ),
      ],
    );
  }
}
