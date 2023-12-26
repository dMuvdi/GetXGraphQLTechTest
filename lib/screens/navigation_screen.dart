import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/characters_screen.dart';
import '../screens/episodes_screen.dart';
import '../screens/locations_screen.dart';
import '../controllers/navigation_controller.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(NavigationController());

    return GetBuilder<NavigationController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, color: Color(0xFFB4B4B4), size: 30,),
                Image.asset('assets/images/rick_and_morty_logo.png', width: 100),
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFFB4B4B4),
                  child: Icon(Icons.person, color: Color(0xFF3F3F3F))
                )
              ],
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF3F3F3F),
            elevation: 0,
          ),
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [
              CharactersScreen(),
              EpisodesScreen(),
              LocationsScreen()
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              backgroundColor: const Color(0xFF2A2A2A),
              selectedItemColor: const Color(0xFFB4B4B4),
              unselectedItemColor: const Color(0xFF4F4F4F),
              currentIndex: controller.tabIndex,
              onTap: controller.changeTabIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.black,
                  icon: Icon(Icons.group),
                  label: 'Characters',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tv),
                  label: 'Episodes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Locations',
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}