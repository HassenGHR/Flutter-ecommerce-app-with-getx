import 'package:day59/controllers/auth/AuthController.dart';
import 'package:day59/controllers/theme/ThemesController.dart';
import 'package:day59/shared/widgets/CommonWidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesController>(
        builder: (themeController) => Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 60),

                          // Header Section
                          Column(
                            children: [
                              Text(context.tr("auth.create_account"),
                                  style: AppTextStyles.displayLarge),
                              SizedBox(height: 8),
                              Text(context.tr("auth.create_account_message"),
                                  style: AppTextStyles.bodyLarge),
                            ],
                          ),

                          SizedBox(height: 40),

                          // Name Input
                          CustomTextField(
                              controller: _nameController,
                              label: context.tr("auth.full_name"),
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr("auth.valid_name");
                                }
                                return null;
                              }),

                          SizedBox(height: 20),

                          CustomTextField(
                            controller: _emailController,
                            label: context.tr('auth.email'),
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
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

                          // Email Input

                          SizedBox(height: 20),

                          // Password Input
                          Obx(
                            () => CustomTextField(
                              controller: _passwordController,
                              label: context.tr('auth.password'),
                              icon: Icons.lock_outline,
                              obscureText:
                                  !_authController.isPasswordVisible.value,
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
                                if (value.length < 6) {
                                  return context
                                      .tr('auth.valid_password_entered');
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 20),

                          // Confirm Password Input
                          Obx(
                            () => CustomTextField(
                              controller: _confirmPasswordController,
                              label: context.tr('auth.confirm_password'),
                              icon: Icons.lock_outline,
                              obscureText:
                                  !_authController.isPasswordVisible.value,
                              keyboardType: TextInputType.emailAddress,
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
                                if (value != _passwordController.text) {
                                  return context
                                      .tr('auth.valid_confirm_password');
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 20),

                          // Error Message
                          Obx(() {
                            return _authController.errorMessage.value.isNotEmpty
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.error_outline,
                                            color: Colors.red),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            _authController.errorMessage.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox.shrink();
                          }),

                          SizedBox(height: 24),

                          // Register Button
                          Obx(() => ElevatedButton(
                                onPressed: _authController.isLoading.value
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          _authController.register(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            name: _nameController.text,
                                          );
                                        }
                                      },
                                child: _authController.isLoading.value
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        context.tr('auth.create_account'),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              )),

                          SizedBox(height: 24),

                          // Divider
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  context.tr('auth.or_sign_up_with'),
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),

                          SizedBox(height: 24),

                          // Google Sign-Up Button
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Colors.grey[300]!),
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
                                SizedBox(width: 12),
                                Text(
                                  context.tr('auth.sign_up_with_google'),
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24),

                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.tr('auth.already_account'),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              TextButton(
                                onPressed: () => Get.toNamed('/login'),
                                child: Text(context.tr('auth.login'),
                                    style: AppTextStyles.bodyMedium),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFF4A80F0), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}

const googleIcon =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M21.8055 10.0415H21V10H12V14H17.6515C16.827 16.3285 14.6115 18 12 18C8.6865 18 6 15.3135 6 12C6 8.6865 8.6865 6 12 6C13.5295 6 14.921 6.577 15.9805 7.5195L18.809 4.691C17.023 3.0265 14.634 2 12 2C6.4775 2 2 6.4775 2 12C2 17.5225 6.4775 22 12 22C17.5225 22 22 17.5225 22 12C22 11.3295 21.931 10.675 21.8055 10.0415Z" fill="#FFC107"/>
    <path d="M3.15303 7.3455L6.43853 9.755C7.32753 7.554 9.48052 6 12 6C13.5295 6 14.921 6.577 15.9805 7.5195L18.809 4.691C17.023 3.0265 14.634 2 12 2C8.15903 2 4.82803 4.1685 3.15303 7.3455Z" fill="#FF3D00"/>
    <path d="M12 22C14.583 22 16.93 21.0115 18.7045 19.404L15.6095 16.785C14.5717 17.5742 13.3037 18.0011 12 18C9.39897 18 7.19047 16.3415 6.35847 14.027L3.09747 16.5395C4.75247 19.778 8.11347 22 12 22Z" fill="#4CAF50"/>
    <path d="M21.8055 10.0415H21V10H12V14H17.6515C17.2571 15.1082 16.5467 16.0766 15.608 16.7855L15.6095 16.785L18.7045 19.404C18.4855 19.6025 22 17 22 12C22 11.3295 21.931 10.675 21.8055 10.0415Z" fill="#1976D2"/>
</svg>''';
