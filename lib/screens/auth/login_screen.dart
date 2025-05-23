import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/auth/auth_bloc.dart';
import 'package:hair_salon/screens/auth/forgot_password_screen.dart';
import 'package:hair_salon/screens/auth/signup_screen.dart';
import 'package:hair_salon/screens/home_screen.dart';
import 'package:hair_salon/widgets/auth_button.dart';
import 'package:hair_salon/widgets/auth_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailError = false;
  bool _passwordError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndLogin() {
    setState(() {
      _emailError = !_emailController.text.contains('@');
      _passwordError = _passwordController.text.length < 6;
    });

    if (!_emailError && !_passwordError) {
      context.read<AuthBloc>().add(
            LoginEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A2A40), // Deep Navy Blue
                  Color(0xFF2D3142), // Dark Charcoal
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.h),
                        
                        // Logo or Image
                        Center(
                          child: Container(
                            width: 200.w,
                            height: 200.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.network(
                                'https://img.freepik.com/free-vector/vintage-barber-shop-logo-template_23-2149420343.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFC19A6B),
                                    child: Center(
                                      child: Text(
                                        'BARBER',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 600.ms),
                        
                        SizedBox(height: 40.h),
                        
                        // Welcome Text
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.montserrat(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                        
                        SizedBox(height: 8.h),
                        
                        Text(
                          'Sign in to continue',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: Colors.white70,
                          ),
                        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                        
                        SizedBox(height: 40.h),
                        
                        // Email Field
                        AuthInputField(
                          label: 'Email / Phone',
                          hintText: 'Enter your email or phone',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          isError: _emailError,
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 800.ms),
                        
                        SizedBox(height: 20.h),
                        
                        // Password Field
                        AuthInputField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          controller: _passwordController,
                          isPassword: true,
                          isError: _passwordError,
                        )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 800.ms),
                        
                        SizedBox(height: 16.h),
                        
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50.w, 30.h),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFE0B0B4),
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 800.ms),
                        
                        SizedBox(height: 40.h),
                        
                        // Login Button
                        AuthButton(
                          text: 'Login',
                          onPressed: _validateAndLogin,
                          isLoading: state is AuthLoading,
                        )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 800.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          delay: 800.ms,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Social Login
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withOpacity(0.5),
                                thickness: 1.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                'Or continue with',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withOpacity(0.5),
                                thickness: 1.h,
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(delay: 900.ms, duration: 800.ms),
                        
                        SizedBox(height: 20.h),
                        
                        // Google Login Button
                        AuthButton(
                          text: 'Login with Google',
                          onPressed: () {
                            // Implement Google login
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Google login will be implemented'),
                              ),
                            );
                          },
                          isPrimary: false,
                          icon: Icons.g_mobiledata_rounded,
                        )
                        .animate()
                        .fadeIn(delay: 1000.ms, duration: 800.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          delay: 1000.ms,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
                        SizedBox(height: 40.h),
                        
                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: const Color(0xFFF5F5F5),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFE0B0B4),
                                ),
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(delay: 1100.ms, duration: 800.ms),
                        
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}