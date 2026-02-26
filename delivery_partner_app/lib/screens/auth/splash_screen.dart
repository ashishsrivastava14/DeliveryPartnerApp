import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background matching delivery_bg.png
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.primary,
              ),
            ),
          ),
          // Background image with low opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.65,
              child: Image.asset(
                'assets/images/delivery_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(30),
                          //   child: Image.asset(
                          //     'assets/images/logo_final.png',
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                        // const SizedBox(height: 24),
                        // Text(
                        //   'DeliveryPartner',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 28,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // const SizedBox(height: 8),
                        // Text(
                        //   'Deliver with confidence',
                        //   style: GoogleFonts.dmSans(
                        //     fontSize: 16,
                        //     color: Colors.white70,
                        //   ),
                        // ),
                        // const SizedBox(height: 48),
                        // const SizedBox(
                        //   width: 32,
                        //   height: 32,
                        //   child: CircularProgressIndicator(
                        //     color: Colors.white,
                        //     strokeWidth: 3,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
