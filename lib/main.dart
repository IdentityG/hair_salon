import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hair_salon/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hair_salon/auth/auth_bloc.dart';

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
        return BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
          child: MaterialApp(
            title: 'Barber Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // Masculine barbershop color scheme
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF1A2A40), // Deep Navy Blue as seed color
                primary: const Color(0xFF1A2A40), // Deep Navy Blue
                secondary: const Color(0xFFC19A6B), // Warm Brown/Amber
                tertiary: const Color(0xFFA63D40), // Muted Red (barber pole)
                background: const Color(0xFFF5F5F5), // Light Gray
                onBackground: const Color(0xFF2D3142), // Dark Charcoal
                surface: const Color(0xFFFFFFFF), // White
                onSurface: const Color(0xFF2D3142), // Dark Charcoal
                error: const Color(0xFFA63D40), // Muted Red
              ),
              // Button themes
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC19A6B), // Warm Brown
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  elevation: 2,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFC19A6B), // Warm Brown
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              // App bar theme
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1A2A40), // Deep Navy Blue
                foregroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
              ),
              // Card theme
              cardTheme: CardTheme(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              // Input decoration theme
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFC19A6B), width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFA63D40)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              // Text theme
              textTheme: TextTheme(
                displayLarge: TextStyle(
                  color: const Color(0xFF2D3142),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
                displayMedium: TextStyle(
                  color: const Color(0xFF2D3142),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
                displaySmall: TextStyle(
                  color: const Color(0xFF2D3142),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                bodyLarge: TextStyle(
                  color: const Color(0xFF2D3142),
                  fontSize: 16.sp,
                ),
                bodyMedium: TextStyle(
                  color: const Color(0xFF2D3142),
                  fontSize: 14.sp,
                ),
              ),
              useMaterial3: true,
            ),
            home: child,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}