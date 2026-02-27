import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/auth_controller.dart';
import '../../core/widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthController authController = Get.find<AuthController>();
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── Deep gradient background ──────────────────────────────────
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0D0B1A),
                  Color(0xFF1A1145),
                  Color(0xFF2D1B69),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // ── Decorative glowing circles ────────────────────────────────
          Positioned(
            top: -60,
            right: -60,
            child: _GlowCircle(
              size: 240,
              color: AppColors.primaryLight.withAlpha(60),
            ),
          ),
          Positioned(
            top: size.height * 0.12,
            left: -80,
            child: _GlowCircle(
              size: 180,
              color: AppColors.accent.withAlpha(25),
            ),
          ),
          Positioned(
            bottom: -80,
            left: size.width * 0.3,
            child: _GlowCircle(
              size: 260,
              color: AppColors.cyan.withAlpha(20),
            ),
          ),

          // ── Scrollable content ────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),

                      // ── Logo with glow ring ─────────────────────────
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.primaryLight.withAlpha(80),
                              Colors.transparent,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryLight.withAlpha(100),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.asset(
                              'assets/images/logo_m.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Headings ────────────────────────────────────
                      Text(
                        'Welcome Back!',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Login to start delivering',
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          color: Colors.white.withAlpha(160),
                          letterSpacing: 0.2,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ── Glass card ──────────────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(13),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withAlpha(35),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(60),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Phone field label ─────────────────
                            Text(
                              'Phone Number',
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withAlpha(200),
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // ── Phone field ───────────────────────
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(20),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withAlpha(50),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.dmSans(
                                  color: const Color.fromARGB(255, 7, 1, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                onChanged: (v) =>
                                    authController.phoneNumber.value = v,
                                decoration: InputDecoration(
                                  hintText: '10-digit mobile number',
                                  hintStyle: GoogleFonts.dmSans(
                                    color: Colors.white.withAlpha(80),
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 4,
                                  ),
                                  prefixIcon: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '🇮🇳',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '+91',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          width: 1,
                                          height: 22,
                                          color: Colors.white.withAlpha(70),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),

                            // ── OTP section ───────────────────────
                            if (!authController.isOtpSent.value) ...[
                              _GradientButton(
                                label: 'Send OTP',
                                isLoading: authController.isLoading.value,
                                onTap: () => authController.sendOtp(),
                              ),
                            ] else ...[
                              Text(
                                'Enter OTP',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withAlpha(200),
                                  letterSpacing: 0.4,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: AppColors.accentLight,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'OTP sent — auto-filling shortly…',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: AppColors.accentLight,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // ── 4 OTP boxes ───────────────────
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(4, (i) {
                                  final filled =
                                      authController.otp.value.length > i;
                                  return AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 220),
                                    width: 62,
                                    height: 62,
                                    decoration: BoxDecoration(
                                      gradient: filled
                                          ? const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFF6B4FA0),
                                                Color(0xFF2D1B69),
                                              ],
                                            )
                                          : null,
                                      color: filled
                                          ? null
                                          : Colors.white.withAlpha(15),
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      border: Border.all(
                                        color: filled
                                            ? AppColors.primaryLight
                                                .withAlpha(200)
                                            : Colors.white.withAlpha(50),
                                        width: filled ? 2 : 1,
                                      ),
                                      boxShadow: filled
                                          ? [
                                              BoxShadow(
                                                color: AppColors.primaryLight
                                                    .withAlpha(80),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      filled
                                          ? authController.otp.value[i]
                                          : '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }),
                              ),

                              const SizedBox(height: 24),

                              _GradientButton(
                                label: 'Verify & Continue',
                                isLoading: false,
                                enabled:
                                    authController.otp.value.length == 4,
                                onTap: () {
                                  authController.verifyOtp();
                                  context.go('/role-selector');
                                },
                              ),

                              const SizedBox(height: 14),

                              Center(
                                child: TextButton(
                                  onPressed: () =>
                                      authController.sendOtp(),
                                  child: Text(
                                    'Resend OTP',
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.accentLight,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        )),
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Powered-by footer ─────────────────────────────────────────
          const Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Center(child: PoweredByQuickPrepAI(light: true)),
          ),
        ],
      ),
    );
  }
}

// ── Helpers ─────────────────────────────────────────────────────────────────

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.isLoading,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: enabled
              ? const LinearGradient(
                  colors: [Color(0xFF6B4FA0), Color(0xFF2D1B69)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withAlpha(25),
                    Colors.white.withAlpha(25),
                  ],
                ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(100),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: (enabled && !isLoading) ? onTap : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: enabled ? Colors.white : Colors.white54,
                    letterSpacing: 0.4,
                  ),
                ),
        ),
      ),
    );
  }
}
