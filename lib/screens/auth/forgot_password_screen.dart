import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/auth/auth_bloc.dart';
import 'package:hair_salon/screens/auth/otp_verification_screen.dart';
import 'package:hair_salon/widgets/auth_button.dart';
import 'package:hair_salon/widgets/auth_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailError = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateAndSendCode() {
    setState(() {
      // Simple validation - check if it's an email or phone number
      _emailError = !(_emailController.text.contains('@') || 
                     _emailController.text.length >= 10);
    });

    if (!_emailError) {
      context.read<AuthBloc>().add(
            ForgotPasswordEvent(
              email: _emailController.text,
            ),
          );
      // Remove the immediate navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is OtpSent) {
          // Navigate to OTP screen only after OTP is sent successfully
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => OtpVerificationScreen(
                emailOrPhone: state.email,
              ),
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
                  Color(0xFFFFF8F0), // Cream
                  Color(0xFFF8D0D3), // Blush pink
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
                        SizedBox(height: 20.h),
                        
                        // Back Button
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: const Color(0xFF2D2D2D),
                            size: 20.sp,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms),
                        
                        SizedBox(height: 30.h),
                        
                        // Illustration
                        Center(
                          child: Container(
                            width: 180.w,
                            height: 180.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.network(
                                'https://img.freepik.com/free-vector/forgot-password-concept-illustration_114360-1123.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFE0B0B4),
                                    child: Center(
                                      child: Icon(
                                        Icons.lock_reset,
                                        size: 80.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
                        SizedBox(height: 40.h),
                        
                        // Title
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.montserrat(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2D2D2D),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 800.ms)
                        .slideX(
                          begin: -0.2,
                          end: 0,
                          delay: 300.ms,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
                        SizedBox(height: 8.h),
                        
                        Text(
                          'We\'ll send a code to reset your password',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: const Color(0xFF2D2D2D).withOpacity(0.7),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 800.ms)
                        .slideX(
                          begin: -0.2,
                          end: 0,
                          delay: 400.ms,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
                        SizedBox(height: 40.h),
                        
                        // Email/Phone Field
                        AuthInputField(
                          label: 'Email / Phone',
                          hintText: 'Enter your email or phone number',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          isError: _emailError,
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 800.ms),
                        
                        SizedBox(height: 40.h),
                        
                        // Send Reset Code Button
                        AuthButton(
                          text: 'Send Reset Code',
                          onPressed: _validateAndSendCode,
                          isLoading: state is AuthLoading,
                        )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 800.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          delay: 600.ms,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // Back to Login
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Back to Login',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFE0B0B4),
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 800.ms),
                        
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