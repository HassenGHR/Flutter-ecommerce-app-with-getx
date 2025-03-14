import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:day59/controllers/auth/AuthController.dart';
import 'package:day59/controllers/language/LanguageController.dart';
import 'package:day59/controllers/theme/ThemesController.dart';
import 'package:day59/shared/constants/ColorConstants.dart';
import 'package:day59/shared/constants/Languages.dart';

class UserTab extends StatelessWidget {
  UserTab({Key? key}) : super(key: key);

  final ThemesController _themesController = Get.find();
  final AuthController _authController = Get.find<AuthController>();
  final LanguageController languageController = Get.find<LanguageController>();

  String _themTranslate(String theme) {
    switch (theme) {
      case 'light':
        return 'settings.settings.appearance.light';
      case 'dark':
        return 'settings.settings.appearance.dark';
      case 'system':
        return 'settings.settings.appearance.system';
      default:
        return 'settings.settings.appearance.light';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _user = _authController.getUser();
    final ThemesController themesController = Get.find();

    return Obx(() {
      return SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 70.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    context.tr('settings.title'),
                    style: AppTextStyles.displayLarge.copyWith(
                      color: _themesController.theme.value == 'light'
                          ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                          : AppColors.darkScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      context.tr("settings.account.header"),
                      style: AppTextStyles.displayMedium.copyWith(
                        color: _themesController.theme.value == 'light'
                            ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                            : AppColors.darkScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 80,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: themesController.theme.value == "light"
                            ? Colors.grey.shade300
                            : Colors.grey,
                      ),
                      child: _authController.isLoggedIn.value
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('profile');
                                  },
                                  child: Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Get.isDarkMode
                                          ? ColorConstants.gray500
                                          : Colors.grey.shade300,
                                    ),
                                    child: _user?.imageUrl != null
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: _user!.imageUrl,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Get.isDarkMode
                                                      ? Colors.white54
                                                      : Colors.grey.shade600,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error_outline,
                                                color: Colors.red.shade300,
                                                size: 32,
                                              ),
                                            ),
                                          )
                                        : Icon(
                                            Icons.person,
                                            size: 32,
                                            color: Get.isDarkMode
                                                ? Colors.white54
                                                : Colors.grey.shade500,
                                          ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                        _user?.name ??
                                            context
                                                .tr("settings.account.guest"),
                                        style:
                                            AppTextStyles.titleMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: _themesController
                                                      .theme.value ==
                                                  'light'
                                              ? AppColors.lightScheme.onSurface
                                                  .withOpacity(0.8)
                                              : AppColors.darkScheme.onSurface,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                    SizedBox(width: 10),
                                    Row(children: [
                                      Text(
                                        _user?.phone ??
                                            context.tr(
                                                "settings.account.notProvided"),
                                        style:
                                            AppTextStyles.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: _themesController
                                                      .theme.value ==
                                                  'light'
                                              ? AppColors.lightScheme.onSurface
                                                  .withOpacity(0.8)
                                              : AppColors.darkScheme.onSurface,
                                        ),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                  ],
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Get.isDarkMode
                                        ? ColorConstants.gray500
                                        : Colors.grey.shade300,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 32,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  context.tr("settings.account.loginRegister"),
                                  style: AppTextStyles.titleLarge.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        _themesController.theme.value == 'light'
                                            ? AppColors.lightScheme.onSurface
                                                .withOpacity(0.8)
                                            : AppColors.darkScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      context.tr("settings.settings.header"),
                      style: AppTextStyles.displayMedium.copyWith(
                        fontWeight: FontWeight.w400,
                        color: _themesController.theme.value == 'light'
                            ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                            : AppColors.darkScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildListTile(
                      context.tr('settings.settings.appearance.title'),
                      Icons.dark_mode,
                      context
                          .tr(_themTranslate(_themesController.theme.value))
                          .toUpperCase(),
                      Colors.purple,
                      onTab: () => _showAppearanceModal(context),
                    ),
                    SizedBox(height: 8),
                    _buildListTile(
                      context.tr('settings.settings.language.title'),
                      Icons.language,
                      '${languageController.getCurrentLanguageName()}',
                      Colors.orange,
                      onTab: () {
                        showLanguageModal(context);
                      },
                    ),
                    SizedBox(height: 8),
                    _buildListTile(
                      context.tr('settings.settings.notifications'),
                      Icons.notifications_outlined,
                      '',
                      Colors.blue,
                      onTab: () {},
                    ),
                    SizedBox(height: 8),
                    _buildListTile(
                      context.tr('settings.settings.bookmarks'),
                      Icons.bookmark,
                      '',
                      Colors.red,
                      onTab: () {
                        Get.toNamed('/bookmark');
                      },
                    ),
                    SizedBox(height: 8),
                    _buildListTile(
                      context.tr('settings.settings.help'),
                      Icons.help,
                      '',
                      Colors.green,
                      onTab: () {},
                    ),
                    SizedBox(height: 8),
                    _buildListTile(
                      context.tr('settings.settings.logout'),
                      Icons.exit_to_app,
                      '',
                      Colors.grey,
                      onTab: () {
                        _authController.signOut();
                      },
                    ),
                  ],
                ),
                Text(
                  context.tr("settings.version"),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: _themesController.theme.value == 'light'
                        ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                        : AppColors.darkScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildListTile(
      String title, IconData icon, String trailing, Color color,
      {onTab}) {
    return Obx(() {
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Container(
          width: 46,
          height: 46,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: color.withAlpha(30)),
          child: Center(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.titleLarge.copyWith(
            color: _themesController.theme.value == 'light'
                ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                : AppColors.darkScheme.onSurface,
          ),
        ),
        trailing: Container(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trailing,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: _themesController.theme.value == 'light'
                      ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                      : AppColors.darkScheme.onSurface,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
        onTap: onTab,
      );
    });
  }

  void showLanguageModal(BuildContext context) {
    final LanguageController languageController =
        Get.find<LanguageController>();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr("settings.settings.language.modalTitle"),
                  style: AppTextStyles.titleLarge.copyWith(
                    color: _themesController.theme.value == 'light'
                        ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                        : AppColors.darkScheme.onSurface,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildLanguageOption(
              context: context,
              languageController: languageController,
              language: Language.english,
              title: context.tr("settings.settings.language.english"),
              color: Colors.blue,
            ),
            const Divider(),
            _buildLanguageOption(
              context: context,
              languageController: languageController,
              language: Language.french,
              title: context.tr("settings.settings.language.french"),
              color: Colors.green,
            ),
            const Divider(),
            _buildLanguageOption(
              context: context,
              languageController: languageController,
              language: Language.arabic,
              title: context.tr("settings.settings.language.arabic"),
              color: Colors.orange,
              isRTL: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: true,
    );
  }

  Widget _buildLanguageOption({
    required LanguageController languageController,
    required Language language,
    required String title,
    required Color color,
    required BuildContext context,
    bool isRTL = false,
  }) {
    return Obx(() {
      final isSelected =
          languageController.currentLanguage.value == language.code;

      return InkWell(
        onTap: () async {
          languageController.changeLanguage(context, language.code);
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Icon(Icons.language, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: _themesController.theme.value == 'light'
                        ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                        : AppColors.darkScheme.onSurface,
                  ),
                ),
              ),
              if (isSelected) Icon(Icons.check_circle, color: color),
            ],
          ),
        ),
      );
    });
  }

  void _showAppearanceModal(BuildContext context) {
    final ThemesController controller = Get.find();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        height: 240,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr("settings.settings.appearance.modalTitle"),
              style: AppTextStyles.titleLarge.copyWith(
                color: controller.theme.value == 'light'
                    ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                    : AppColors.darkScheme.onSurface,
              ),
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(
                Icons.brightness_5,
                color: Colors.blue,
              ),
              title: Text(
                context.tr("settings.settings.appearance.light"),
                style: AppTextStyles.bodyLarge.copyWith(
                  color: controller.theme.value == 'light'
                      ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                      : AppColors.darkScheme.onSurface,
                ),
              ),
              onTap: () {
                controller.setTheme('light');
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                color: controller.theme.value == 'light'
                    ? Colors.blue
                    : Colors.transparent,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.brightness_2,
                color: Colors.orange,
              ),
              title: Text(
                context.tr("settings.settings.appearance.dark"),
                style: AppTextStyles.bodyLarge.copyWith(
                  color: controller.theme.value == 'light'
                      ? AppColors.lightScheme.onSurface.withOpacity(0.8)
                      : AppColors.darkScheme.onSurface,
                ),
              ),
              onTap: () {
                controller.setTheme('dark');
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                color: controller.theme.value == 'dark'
                    ? Colors.orange
                    : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
