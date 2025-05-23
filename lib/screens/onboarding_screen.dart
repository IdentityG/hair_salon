import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLastPage = false;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Expert Grooming",
      description: "Premium haircuts and beard styling by professionals.",
      imageUrl: "https://img.freepik.com/free-photo/male-hairdresser-serving-client-barbershop_1303-20861.jpg",
    ),
    OnboardingPage(
      title: "Easy Booking",
      description: "Schedule your appointment with just a few taps.",
      imageUrl: "https://img.freepik.com/free-photo/hairdresser-cutting-client-s-hair-barbershop_1303-20448.jpg",
    ),
    OnboardingPage(
      title: "Loyalty Rewards",
      description: "Earn points with every visit and unlock exclusive perks.",
      imageUrl: "https://img.freepik.com/free-photo/client-doing-hair-cut-barber-shop-salon_1303-20889.jpg",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      _isLastPage = index == _pages.length - 1;
    });
  }

  void _completeOnboarding() async {
    // Save that onboarding is complete
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    
    if (mounted) {
      // Add a nice fade transition
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              const LoginScreen(),
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
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h, right: 16.w),
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFC19A6B), // Warm Brown
                      ),
                    ),
                  ),
                ),
              ),
              
              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index], index);
                  },
                ),
              ),
              
              // Page indicator
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: const Color(0xFFC19A6B), // Warm Brown
                    dotColor: const Color(0xFFC19A6B).withOpacity(0.3),
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    expansionFactor: 3,
                    spacing: 5.w,
                  ),
                ),
              ),
              
              // Next or Get Started button
              Padding(
                padding: EdgeInsets.only(bottom: 40.h, left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button (visible only if not on first page)
                    _currentPage > 0
                        ? SizedBox(
                            width: 100.w,
                            height: 56.h,
                            child: ElevatedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: const Color(0xFFC19A6B), // Warm Brown
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  side: BorderSide(
                                    color: const Color(0xFFC19A6B), // Warm Brown
                                    width: 1.w,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Back',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(width: 100.w),
                    
                    // Next/Get Started button
                    SizedBox(
                      width: 200.w,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isLastPage) {
                            _completeOnboarding();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC19A6B), // Warm Brown
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          _isLastPage ? 'Get Started' : 'Next',
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, int index) {
    // Calculate delay based on page index and current page
    final bool isCurrentPage = index == _currentPage;
    final delay = isCurrentPage ? 0.ms : 300.ms;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Container(
            height: 250.h,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 40.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                page.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF2D3142).withOpacity(0.5),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 50.sp,
                        color: const Color(0xFFC19A6B),
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xFFC19A6B),
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          )
          .animate(
            target: isCurrentPage ? 1 : 0,
          )
          .fadeIn(delay: delay, duration: 500.ms)
          .slideY(
            begin: 0.2,
            end: 0,
            delay: delay,
            duration: 500.ms,
            curve: Curves.easeOut,
          ),
          
          // Title
          Text(
            page.title,
            style: GoogleFonts.montserrat(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          )
          .animate(
            target: isCurrentPage ? 1 : 0,
          )
          .fadeIn(delay: delay + 200.ms, duration: 500.ms)
          .slideY(
            begin: 0.2,
            end: 0,
            delay: delay + 200.ms,
            duration: 500.ms,
            curve: Curves.easeOut,
          ),
          
          SizedBox(height: 16.h),
          
          // Description
          Text(
            page.description,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          )
          .animate(
            target: isCurrentPage ? 1 : 0,
          )
          .fadeIn(delay: delay + 400.ms, duration: 500.ms)
          .slideY(
            begin: 0.2,
            end: 0,
            delay: delay + 400.ms,
            duration: 500.ms,
            curve: Curves.easeOut,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}