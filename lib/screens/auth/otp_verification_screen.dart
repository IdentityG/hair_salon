import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/auth/auth_bloc.dart';
import 'package:hair_salon/screens/auth/reset_password_screen.dart';
import 'package:hair_salon/widgets/auth_button.dart';

// At the top of the file, change the class name to be consistent
class OtpVerificationScreen extends StatefulWidget {
  final String emailOrPhone;
  
  const OtpVerificationScreen({
    super.key,
    required this.emailOrPhone,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (_) => FocusNode(),
  );
  
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;
  
  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  
  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }
  
  void _onOtpDigitChanged(int index, String value) {
    if (value.length == 1) {
      // Move to next field
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last digit entered, hide keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }
  
  String _getOtpCode() {
    return _controllers.map((controller) => controller.text).join();
  }
  
  void _verifyOtp() {
    final otp = _getOtpCode();
    if (otp.length == 4) {
      context.read<AuthBloc>().add(
        VerifyOtpEvent(
          emailOrPhone: widget.emailOrPhone,
          otp: otp,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 4 digits'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  void _resendOtp() {
    if (_canResend) {
      context.read<AuthBloc>().add(
        ResendOtpEvent(
          emailOrPhone: widget.emailOrPhone,
        ),
      );
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          // Navigate to reset password screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const ResetPasswordScreen(),
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is OtpSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP resent successfully'),
              backgroundColor: Colors.green,
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
                        'Verification Code',
                        style: GoogleFonts.montserrat(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                      
                      SizedBox(height: 8.h),
                      
                      Text(
                        'Enter the code sent to ${widget.emailOrPhone}',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.white70,
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                            
                      SizedBox(height: 40.h),
                      
                      // Title
                      Text(
                        'Verification Code',
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
                        'Enter the 4-digit code sent to ${widget.emailOrPhone}',
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
                      
                      // OTP Input Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          4,
                          (index) => SizedBox(
                            width: 60.w,
                            height: 60.h,
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onChanged: (value) => _onOtpDigitChanged(index, value),
                              style: GoogleFonts.poppins(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2D2D2D),
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: const Color(0xFFE0B0B4).withOpacity(0.3),
                                    width: 1.5.w,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: const Color(0xFFE0B0B4),
                                    width: 1.5.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 800.ms),
                      
                      SizedBox(height: 30.h),
                      
                      // Timer and Resend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive code? ',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: const Color(0xFF2D2D2D),
                            ),
                          ),
                          _canResend
                              ? GestureDetector(
                                  onTap: _resendOtp,
                                  child: Text(
                                    'Resend',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFE0B0B4),
                                    ),
                                  ),
                                )
                              : Text(
                                  'Resend in ${_secondsRemaining}s',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 800.ms),
                      
                      SizedBox(height: 40.h),
                      
                      // Verify Button
                      AuthButton(
                        text: 'Verify',
                        onPressed: _verifyOtp,
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
        );
      },
    );
  }
}