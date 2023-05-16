import 'package:flutter/material.dart';
import 'package:wallapop/src/ui/modules/home/tabs/favourites_tab/favourites_tab_controller.dart';

import '../../../../../../utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../global_widgets/rounded_button.dart';

class FavouritesTabHeader extends StatefulWidget {
  const FavouritesTabHeader({super.key});

  @override
  State<FavouritesTabHeader> createState() => _FavouritesTabHeaderState();
}

class _FavouritesTabHeaderState extends State<FavouritesTabHeader> {
  @override
  Widget build(BuildContext context) {
    final FavouritesTabController controller =
        context.watch<FavouritesTabController>();

    return Row(
      children: [
        RoundedButton(
          onPressed: () => controller.onIsFavouritesProductsClicked(),
          textColor: controller.isFavouritesProductsClicked
              ? textColorWhite
              : Colors.black,
          backgroundColor: controller.isFavouritesProductsClicked
              ? primaryColor.withOpacity(0.4)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          label: "Productos",
          fullWidth: false,
          fontSize: 14,
          borderRadius: 20,
        ),
        RoundedButton(
          onPressed: () => controller.onIsFavouritesSearchesClicked(),
          textColor: controller.isFavouritesSearchesClicked
              ? textColorWhite
              : Colors.black,
          backgroundColor: controller.isFavouritesSearchesClicked
              ? primaryColor.withOpacity(0.4)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          label: "Búsquedas",
          fullWidth: false,
          fontSize: 14,
          borderRadius: 20,
        ),
        RoundedButton(
          onPressed: () => controller.onIsFavouritesProfilesClicked(),
          textColor: controller.isFavouritesProfilesClicked
              ? textColorWhite
              : Colors.black,
          backgroundColor: controller.isFavouritesProfilesClicked
              ? primaryColor.withOpacity(0.4)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          label: "Perfiles",
          fullWidth: false,
          fontSize: 14,
          borderRadius: 20,
        ),
      ],
    );
  }
}
