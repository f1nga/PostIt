import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallapop/src/data/models/utils/product_category_type.dart';
import 'package:wallapop/src/data/models/utils/product_state_type.dart';
import 'package:wallapop/src/ui/modules/home/tabs/postit_tab/postit_controller.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';

///This widget is the filter button in the users tab, it opens a modal bottom sheet with the filter options
class StateSelection extends StatefulWidget {
  const StateSelection({super.key});

  @override
  State<StateSelection> createState() => _StateSelectionState();
}

class _StateSelectionState extends State<StateSelection> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PostitController>(
      context,
      listen: true,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        const Icon(Icons.production_quantity_limits, color: tertiaryColor),
        const SizedBox(
          width: 15,
        ),
        Text(
          controller.state == ""
              ? "Estado del producto"
              : controller.state,
          style: const TextStyle(
              color: Color.fromARGB(255, 128, 125, 125), fontSize: 16),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              color: tertiaryColor,
              onPressed: () => {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          height: 350,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 15),
                                    child: Text(
                                      "Estado del producto",
                                      style: FontStyles.bold
                                          .copyWith(fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                RadioListTile<int>(
                                  title: const Text(ProductStateType.perfect),
                                  value: 1,
                                  groupValue: controller.isClickedState,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.onIsPerfectStateClicked(value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<int>(
                                  title: const Text(ProductStateType.like_new),
                                  value: 2,
                                  groupValue: controller.isClickedState,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller
                                          .onIsLikeNewStateClicked(value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<int>(
                                  title: const Text(ProductStateType.good),
                                  value: 3,
                                  groupValue: controller.isClickedState,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller
                                          .onIsGoodStateClicked(value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<int>(
                                  title:
                                      const Text(ProductStateType.acceptable),
                                  value: 4,
                                  groupValue: controller.isClickedState,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller
                                          .onIsAcceptableStateClicked(value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<int>(
                                  title:
                                      const Text(ProductStateType.busted),
                                  value: 5,
                                  groupValue: controller.isClickedState,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      controller
                                          .onIsBustedStateClicked(value!);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              },
            ),
          ),
        ),
      ],
    );
  }
}
