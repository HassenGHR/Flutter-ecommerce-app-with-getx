import 'package:day59/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionLossDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const ConnectionLossDialog({Key? key, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5D4DFF),
              Color(0xFF7B68EE),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated No Connection Illustration
              Lottie.asset(
                'assets/animations/no_connection.json', // You'll need to add this Lottie animation
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),

              // Title with Gradient Text
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.7),
                  ],
                ).createShader(bounds),
                child: Text(
                  'Connection Lost',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 15),

              // Descriptive Text
              Text(
                'Oops! It seems like you\'ve lost your internet connection. Please check your network settings and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 25),

              // Retry Button with Animated Gradient
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF6B6B),
                      Color(0xFFFF8E53),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: onRetry,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Retry Connection',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated Connection Check Function
class ConnectionManager {
  static Future<void> checkInternetConnection(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      // Show Creative Connection Dialog
      Get.dialog(
        ConnectionLossDialog(
          onRetry: () {
            Get.back(); // Close the dialog
            checkInternetConnection(context); // Recheck connection
          },
        ),
        barrierDismissible: false,
      );
    } else {
      // Internet is available, navigate to the home page
      Future.delayed(Duration(seconds: 3), () {
        Get.toNamed(Routes.initial); // Replace with your actual home route
      });
    }
  }
}
