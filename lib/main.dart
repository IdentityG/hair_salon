import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hair_salon/screens/splash_screen.dart';

void main() {
  runApp(const HairSalonApp());
}

class HairSalonApp extends StatelessWidget {
  const HairSalonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Standard design size for iPhone X
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Hair Salon',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFE0B0B4), // Rose gold as seed color
              primary: const Color(0xFFE0B0B4), // Rose gold
              secondary: const Color(0xFFF8D0D3), // Blush pink
              tertiary: const Color(0xFFD4AF37), // Gold
              background: const Color(0xFFFFF8F0), // Cream
              onBackground: const Color(0xFF2D2D2D), // Soft black
            ),
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}