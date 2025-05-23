import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the onboarding screen after 2 seconds
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A2A40), // Deep Navy Blue
              Color(0xFF2D3142), // Dark Charcoal
              Color(0xFF1A2A40), // Deep Navy Blue
              Color(0xFF2D3142), // Dark Charcoal
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://via.placeholder.com/150?text=Barber',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFC19A6B), // Warm Brown
                        child: Center(
                          child: Text(
                            'BARBER',
                            style: GoogleFonts.montserrat(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 800.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 1000.ms,
                curve: Curves.easeOutBack,
              ),
              
              SizedBox(height: 30.h),
              
              // Tagline
              Text(
                'Premium Grooming For Men',
                style: GoogleFonts.montserrat(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms, duration: 800.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                delay: 300.ms,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),
              
              SizedBox(height: 10.h),
              
              // Accent line
              Container(
                width: 100.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFC19A6B), // Warm Brown
                  borderRadius: BorderRadius.circular(2.r),
                ),
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 800.ms)
              .slideX(
                begin: 0.3,
                end: 0,
                delay: 500.ms,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),
              
              SizedBox(height: 20.h),
              
              // Subtitle
              Text(
                'ESTABLISHED 2023',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFC19A6B), // Warm Brown
                  letterSpacing: 3.0,
                ),
              )
              .animate()
              .fadeIn(delay: 700.ms, duration: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}