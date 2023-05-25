import 'package:flutter/material.dart';

class MyProfileAction extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onPressed;

  const MyProfileAction({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(
          15,
        ),
        height: 60,
        color: Colors.white,
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
