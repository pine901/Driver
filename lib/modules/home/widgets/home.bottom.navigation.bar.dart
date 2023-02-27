import 'package:flutter/material.dart';

import '../../../localization.dart';
import '../../../theme/theme.colors.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemTap;

  const HomeBottomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onItemTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: Localization.of(context)?.tr('stores') ?? "",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  selectedIndex == 1
                      ? const Icon(Icons.notifications)
                      : const Icon(Icons.notifications_outlined),
                  const Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Icon(Icons.brightness_1,
                        size: 8.0, color: Colors.redAccent),
                  )
                ],
              ),
              label: Localization.of(context)?.tr('notifications') ?? "",
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? const Icon(Icons.history)
                  : const Icon(Icons.history_outlined),
              label: Localization.of(context)?.tr('orders') ?? "",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_rounded),
              label: Localization.of(context)?.tr('profile') ?? "",
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: ThemeColors.primaryColor,
          onTap: onItemTap,
        ),
      ),
    );
  }
}
