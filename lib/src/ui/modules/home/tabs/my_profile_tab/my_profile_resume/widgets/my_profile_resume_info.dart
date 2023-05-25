// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import '../../../../../../../utils/font_styles.dart';
import '../my_profile_resume_controller.dart';
import 'package:provider/provider.dart';

class MyProfileResumeInfo extends StatelessWidget {
  const MyProfileResumeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final MyProfileResumeController controller =
        context.watch<MyProfileResumeController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Información básica",
            style: FontStyles.title,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.person,
                size: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                controller.user.nickname,
                style: FontStyles.regular.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.cake,
                size: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "23/64/2344",
                style: FontStyles.regular.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.description,
                size: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                controller.user.description == ""
                    ? "No hay ninguna descripción"
                    : controller.user.description,
                style: FontStyles.regular.copyWith(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
