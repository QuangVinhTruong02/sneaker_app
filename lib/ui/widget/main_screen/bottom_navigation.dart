import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/controller/main_screen_notifier.dart';

import 'item_of_bottom.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return SafeArea(
          child: Container(
            //padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ItemOfBottom(
                  onTap: () {
                    mainScreenNotifier.position = 0;
                  },
                  icon: Icons.home,
                  color: mainScreenNotifier.position == 0
                      ? Colors.white
                      : Colors.grey,
                ),
                ItemOfBottom(
                  onTap: () {
                    mainScreenNotifier.position = 1;
                  },
                  icon: Icons.search,
                  color: mainScreenNotifier.position == 1
                      ? Colors.white
                      : Colors.grey,
                ),
                ItemOfBottom(
                  onTap: () {
                    mainScreenNotifier.position = 2;
                  },
                  icon: Ionicons.cart,
                  color: mainScreenNotifier.position == 2
                      ? Colors.white
                      : Colors.grey,
                ),
                ItemOfBottom(
                  onTap: () {
                    mainScreenNotifier.position = 3;
                  },
                  icon: Icons.person,
                  color: mainScreenNotifier.position == 3
                      ? Colors.white
                      : Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
