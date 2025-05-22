import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/auth/auth_bloc.dart';
import 'package:hair_salon/screens/home_screen.dart';
import 'package:hair_salon/widgets/auth_button.dart';
import 'package:hair_salon/widgets/auth_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _nameError = false;
  bool _emailError = false;
  bool _phoneError = false;
  bool _passwordError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSignup() {
    setState(() {
      _nameError = _nameController.text.length < 3;
      _emailError = !_emailController.text.contains('@');
      _phoneError = _phoneController.text.length < 10;
      _passwordError = _passwordController.text.length < 6;
    });

    if (!_nameError && !_emailError && !_phoneError && !_passwordError) {
      context.read<AuthBloc>().add(
            SignupEvent(
              name: _nameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
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
                        
                        SizedBox(height: 20.h),
                        
                        // Header Image
                        Center(
                          child: Container(
                            width: 150.w,
                            height: 150.h,
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
                                'https://img.freepik.com/free-vector/hair-salon-logo-template_23-2149373267.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFE0B0B4),
                                    child: Center(
                                      child: Text(
                                        'SALON',
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
                        )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // Welcome Text
                        Text(
                          'Create Account',
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
                          'Join our beauty community',
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
                        
                        SizedBox(height: 30.h),
                        
                        // Full Name Field
                        AuthInputField(
                          label: 'Full Name',
                          hintText: 'Enter your full name',
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          isError: _nameError,
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 800.ms),
                        
                        SizedBox(height: 16.h),
                        
                        // Email Field
                        AuthInputField(
                          label: 'Email',
                          hintText: 'Enter your email address',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          isError: _emailError,
                        )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 800.ms),
                        
                        SizedBox(height: 16.h),
                        
                        // Phone Field
                        AuthInputField(
                          label: 'Phone Number',
                          hintText: 'Enter your phone number',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          isError: _phoneError,
                        )
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 800.ms),
                        
                        SizedBox(height: 16.h),
                        
                        // Password Field
                        AuthInputField(
                          label: 'Password',
                          hintText: 'Create a strong password',
                          controller: _passwordController,
                          isPassword: true,
                          isError: _passwordError,
                        )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 800.ms),
                        
                        SizedBox(height: 16.h),
                        
                        // Password strength indicator
                        _passwordController.text.isNotEmpty
                            ? _buildPasswordStrengthIndicator()
                            : const SizedBox.shrink(),
                        
                        SizedBox(height: 30.h),
                        
                        // Terms and Conditions
                        Row(
                          children: [
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Checkbox(
                                value: true,
                                onChanged: (value) {},
                                activeColor: const Color(0xFFE0B0B4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'I agree to the Terms of Service and Privacy Policy',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF2D2D2D),
                                ),
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(delay: 900.ms, duration: 800.ms),
                        
                        SizedBox(height: 30.h),
                        
                        // Signup Button
                        AuthButton(
                          text: 'Create Account',
                          onPressed: _validateAndSignup,
                          isLoading: state is AuthLoading,
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
                        
                        SizedBox(height: 30.h),
                        
                        // Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: const Color(0xFF2D2D2D),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                'Login',
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
  
  Widget _buildPasswordStrengthIndicator() {
    final String password = _passwordController.text;
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasDigit = password.contains(RegExp(r'[0-9]'));
    final bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    int strength = 0;
    if (password.length >= 8) strength++;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasDigit) strength++;
    if (hasSpecialChar) strength++;
    
    Color strengthColor;
    String strengthText;
    
    if (strength <= 2) {
      strengthColor = Colors.red;
      strengthText = 'Weak';
    } else if (strength <= 4) {
      strengthColor = Colors.orange;
      strengthText = 'Medium';
    } else {
      strengthColor = Colors.green;
      strengthText = 'Strong';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: strength / 5,
                backgroundColor: Colors.grey.withOpacity(0.3),
                color: strengthColor,
                minHeight: 5.h,
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              strengthText,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: strengthColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Password should contain uppercase, lowercase, number and special character',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Colors.grey,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }
}