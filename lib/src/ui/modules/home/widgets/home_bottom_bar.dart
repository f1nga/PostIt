// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';
import '../home_controller.dart';

const String homeIcon = "assets/home/home.svg";
const String favouritesIcon = "assets/home/favourites.svg";
const String postitIcon = "assets/home/postit.svg";
const String profileIcon = "assets/home/profile.svg";

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Provider.of<HomeController>(context, listen: false);
    final int currentPage =
        context.select<HomeController, int>((_) => _.currentPage);

    final List<_BottomBarItem> items = [
      _BottomBarItem(
        icon: homeIcon,
        label: "Inicio",
      ),
      _BottomBarItem(
        icon: favouritesIcon,
        label: "Favoritos",
      ),
      _BottomBarItem(
        icon: postitIcon,
        label: "Súbelo",
      ),
      _BottomBarItem(
        icon: profileIcon,
        label: "Yo",
      ),
    ];

    return SafeArea(
      top: false,
      child: TabBar(
        padding: const EdgeInsets.only(
          top: 12,
        ),
        controller: controller.tabController,
        indicatorColor: transparentColor,
        tabs: List.generate(
          items.length,
          (index) {
            final _BottomBarItem item = items[index];
            return BottomBarTab(
              item: item,
              isActive: currentPage == index,
            );
          },
        ),
      ),
    );
  }
}

class BottomBarTab extends StatelessWidget {
  const BottomBarTab({
    Key? key,
    required this.item,
    required this.isActive,
  }) : super(key: key);

  final _BottomBarItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? primaryColor : secondaryColor;

    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            item.icon,
            color: color,
          ),
          Expanded(
            child: Text(
              item.label,
              style: FontStyles.regular.copyWith(
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBarItem {
  final String icon, label;

  _BottomBarItem({
    required this.icon,
    required this.label,
  });
}
