import 'package:day59/shared/widgets/CommonWidgets.dart';
import 'package:day59/views/authentication/RegisterPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../controllers/auth/AuthController.dart';
import '../../controllers/theme/ThemesController.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesController>(
      builder: (themeController) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    // Header Section
                    Column(
                      children: [
                        Text(
                          context.tr('auth.welcome'),
                          style: AppTextStyles.displayLarge.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.tr('auth.welcome_message'),
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      controller: _emailController,
                      label: context.tr('auth.email'),
                      icon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.tr('auth.valid_email');
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return context.tr('auth.valid_email_entered');
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password Input
                    Obx(() => CustomTextField(
                          controller: _passwordController,
                          label: context.tr('auth.password'),
                          icon: Icons.lock_outline,
                          obscureText: !_authController.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _authController.isPasswordVisible.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey[600],
                            ),
                            onPressed: () =>
                                _authController.togglePasswordVisibility(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.tr('auth.valid_password');
                            }
                            return null;
                          },
                        )),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Implement forgot password
                        },
                        child: Text(
                          context.tr('auth.forgot_password'),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Error Message
                    Obx(() {
                      return _authController.errorMessage.value.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 16),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .error
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _authController.errorMessage.value,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink();
                    }),

                    const SizedBox(height: 24),

                    // Login Button
                    Obx(() => ElevatedButton(
                          onPressed: _authController.isLoading.value
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    _authController.login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    if (_authController.isLoggedIn.value) {
                                      Get.toNamed('/home');
                                    }
                                  }
                                },
                          child: _authController.isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  context.tr('auth.login'),
                                  style: AppTextStyles.buttonText,
                                ),
                        )),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.2),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            context.tr('auth.or'),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.2),
                        )),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Google Sign-In Button
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.2),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.string(
                            googleIcon,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            context.tr('auth.sign_in_with_google'),
                            style: AppTextStyles.buttonText.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Registration Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.tr('auth.no_account'),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed('/register'),
                          child: Text(context.tr('auth.register'),
                              style: AppTextStyles.bodyMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
