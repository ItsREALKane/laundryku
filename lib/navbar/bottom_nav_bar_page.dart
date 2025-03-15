import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/favorite/pages/Favorite_page.dart';
import 'package:laundryku/navbar/bottom_nav_controller.dart';
import 'package:laundryku/profile/pages/profile_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  _NavbarPageState createState() => _NavbarPageState();
}

class _NavbarPageState extends State<BottomNavBarPage> {
  final BottomNavController navbarController = Get.find<BottomNavController>();

  final List<Widget> _menus = [
    FavoritePage(),
    ProfilePage(),
  ];

  final List<IconData> _pageIcons = [
    Icons.home,
    Icons.bookmark,
    Icons.message,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, //background navbar transparannnn
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: _menus[
              navbarController.selectedIndex.value.clamp(0, _menus.length - 1)],
        ),
      ),
      bottomNavigationBar: _AnimatedBottomNavBar(
        pageIcons: _pageIcons,
        onTap: (index) {
          navbarController.selectedIndex.value = index;
        },
        selectedIndex: navbarController.selectedIndex,
      ),
    );
  }
}

class _AnimatedBottomNavBar extends StatelessWidget {
  final List<IconData> pageIcons;
  final Function(int) onTap;
  final RxInt selectedIndex;

  const _AnimatedBottomNavBar({
    Key? key,
    required this.pageIcons,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / pageIcons.length;

    double navPadding = 30.0;
    double fabOffset = 30.0;

    return Obx(
      () => Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFE3FDFD),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(pageIcons.length, (index) {
                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(index),
                    child: Container(
                      height: double.infinity,
                      color: Colors.transparent,
                      child: Icon(
                        pageIcons[index],
                        size: 28,
                        color: selectedIndex.value == index
                            ? const Color(0xFF71C9CE)
                            : const Color(0xFF71C9CE),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: navPadding +
                ((screenWidth - (navPadding * 2)) /
                    pageIcons.length *
                    selectedIndex.value) +
                ((screenWidth - (navPadding * 2)) / pageIcons.length / 2) -
                fabOffset,
            bottom: 40,
            child: Material(
              elevation: 8,
              shape: const CircleBorder(),
              shadowColor: Colors.black.withOpacity(0.2),
              child: FloatingActionButton(
                onPressed: () => onTap(selectedIndex.value),
                backgroundColor: const Color(0xFF71C9CE),
                elevation: 6,
                shape: const CircleBorder(),
                child: Icon(
                  pageIcons[selectedIndex.value],
                  color: const Color(0xFFE3FDFD),
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
