import 'dart:io';

import 'package:day59/controllers/profile/ProfileController.dart';
import 'package:day59/controllers/theme/ThemesController.dart';
import 'package:day59/shared/widgets/CommonWidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesController>(
      builder: (themeController) => Scaffold(
        backgroundColor: themeController.theme == 'light'
            ? AppColors.lightScheme.background
            : AppColors.darkScheme.background,
        appBar: AppBar(
          title: Text(
            context.tr('profile.profile'),
            style: TextStyle(
              color: themeController.theme == 'light'
                  ? AppColors.lightScheme.onBackground
                  : AppColors.darkScheme.onBackground,
            ),
          ),
          backgroundColor: themeController.theme == 'light'
              ? AppColors.lightScheme.surface
              : AppColors.darkScheme.surface,
          iconTheme: IconThemeData(
            color: themeController.theme == 'light'
                ? AppColors.lightScheme.onSurface
                : AppColors.darkScheme.onSurface,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                GetBuilder<ProfileController>(
                  builder: (_) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: themeController.theme == 'light'
                              ? AppColors.lightScheme.primary
                              : AppColors.darkScheme.primary,
                          backgroundImage: controller.imageFile == null
                              ? NetworkImage(controller.profileImageUrl.value)
                                  as ImageProvider<Object>
                              : FileImage(File(controller.imageFile!.path)),
                        ),
                        Positioned(
                          bottom: 20.0,
                          right: 20.0,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => bottomSheet(context),
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: themeController.theme == 'light'
                                  ? AppColors.lightScheme.secondary
                                  : AppColors.darkScheme.secondary,
                              size: 28.0,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: controller.nameController,
                  label: context.tr("profile.full_name"),
                  icon: CupertinoIcons.person,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: controller.phoneController,
                  label: context.tr("profile.phone"),
                  icon: CupertinoIcons.phone,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: controller.addressController,
                  label: context.tr("profile.address"),
                  icon: CupertinoIcons.location,
                ),
                const SizedBox(height: 20),
                Obx(() => controller.isSaving.value
                    ? Column(
                        children: [
                          CupertinoActivityIndicator(
                            color: themeController.theme == 'light'
                                ? AppColors.lightScheme.primary
                                : AppColors.darkScheme.primary,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            context.tr('profile.saving'),
                            style: TextStyle(
                              color: themeController.theme == 'light'
                                  ? AppColors.lightScheme.onSurface
                                  : AppColors.darkScheme.onSurface,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            backgroundColor: themeController.theme == 'light'
                                ? AppColors.lightScheme.primary
                                : AppColors.darkScheme.primary,
                          ),
                          child: Text(
                            context.tr("profile.save"),
                            style: TextStyle(
                              color: themeController.theme == 'light'
                                  ? AppColors.lightScheme.onPrimary
                                  : AppColors.darkScheme.onPrimary,
                            ),
                          ),
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    final themeController = Get.find<ThemesController>();
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: themeController.theme == 'light'
            ? AppColors.lightScheme.surface
            : AppColors.darkScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            context.tr("profile.choose_profile_picture"),
            style: TextStyle(
              fontSize: 20.0,
              color: themeController.theme == 'light'
                  ? AppColors.lightScheme.onSurface
                  : AppColors.darkScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => {},
                icon: Icon(
                  Icons.camera,
                  color: themeController.theme == 'light'
                      ? AppColors.lightScheme.onPrimary
                      : AppColors.darkScheme.onPrimary,
                ),
                label: Text(
                  context.tr("profile.camera"),
                  style: TextStyle(
                    color: themeController.theme == 'light'
                        ? AppColors.lightScheme.onPrimary
                        : AppColors.darkScheme.onPrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeController.theme == 'light'
                      ? AppColors.lightScheme.primary
                      : AppColors.darkScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => {},
                icon: Icon(
                  Icons.image,
                  color: themeController.theme == 'light'
                      ? AppColors.lightScheme.onPrimary
                      : AppColors.darkScheme.onPrimary,
                ),
                label: Text(
                  context.tr("profile.gallery"),
                  style: TextStyle(
                    color: themeController.theme == 'light'
                        ? AppColors.lightScheme.onPrimary
                        : AppColors.darkScheme.onPrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeController.theme == 'light'
                      ? AppColors.lightScheme.primary
                      : AppColors.darkScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
