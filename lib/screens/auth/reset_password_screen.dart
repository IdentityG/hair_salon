import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/auth/auth_bloc.dart';
import 'package:hair_salon/screens/auth/login_screen.dart';
import 'package:hair_salon/widgets/auth_button.dart';
import 'package:hair_salon/widgets/auth_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordError = false;
  bool _confirmPasswordError = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    setState(() {
      _passwordError = _passwordController.text.length < 6;
      _confirmPasswordError = _passwordController.text != _confirmPasswordController.text;
    });

    if (!_passwordError && !_confirmPasswordError) {
      context.read<AuthBloc>().add(
            ResetPasswordEvent(
              password: _passwordController.text,
            ),
          );
      
      // We should only navigate after successful password reset
      // This should be moved to the BlocConsumer listener
    }
  }

  @override
  // Update the BlocConsumer listener to handle navigation after successful password reset
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
        } else if (state is PasswordReset) {
          // Navigate back to login after successful password reset
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
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
                        SizedBox(height: 20.h),
                        
                        // Back Button
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms),
                        
                        SizedBox(height: 30.h),
                        
                        // Header
                        Text(
                          'Reset Password',
                          style: GoogleFonts.montserrat(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                        
                        SizedBox(height: 8.h),
                        
                        Text(
                          'Create a new password',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: Colors.white70,
                          ),
                        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                        
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
                                'https://img.freepik.com/free-vector/reset-password-concept-illustration_114360-7866.jpg',
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
                          'Reset Password',
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
                          'Create a new strong password',
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
                        
                        // New Password Field
                        AuthInputField(
                          label: 'New Password',
                          hintText: 'Enter new password',
                          controller: _passwordController,
                          isPassword: true,
                          isError: _passwordError,
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 800.ms),
                        
                        SizedBox(height: 20.h),
                        
                        // Confirm Password Field
                        AuthInputField(
                          label: 'Confirm Password',
                          hintText: 'Confirm your password',
                          controller: _confirmPasswordController,
                          isPassword: true,
                          isError: _confirmPasswordError,
                        )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 800.ms),
                        
                        SizedBox(height: 40.h),
                        
                        // Reset Button
                        AuthButton(
                          text: 'Reset Password',
                          onPressed: _resetPassword,
                          isLoading: state is AuthLoading,
                        )
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 800.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          delay: 700.ms,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
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