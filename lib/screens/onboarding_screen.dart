import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/screens/home_screen.dart';
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
      title: "Book with Ease",
      description: "Book your favorite service in seconds.",
      imageUrl: "https://cdn.pixabay.com/photo/2018/01/06/09/25/calendar-3064466_1280.png",
    ),
    OnboardingPage(
      title: "Find Your Stylist",
      description: "Explore expert stylists just for you.",
      imageUrl: "https://cdn.pixabay.com/photo/2016/11/29/06/46/adult-1867889_1280.jpg",
    ),
    OnboardingPage(
      title: "Earn Rewards",
      description: "Enjoy loyalty perks & exclusive offers.",
      imageUrl: "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_1280.png",
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
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
              Color(0xFFFFF8F0), // Cream
              Color(0xFFF8D0D3), // Blush pink
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
                        color: const Color(0xFF2D2D2D),
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
                    activeDotColor: const Color(0xFFE0B0B4), // Rose gold
                    dotColor: const Color(0xFFE0B0B4).withOpacity(0.3),
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
                child: SizedBox(
                  width: double.infinity,
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
                      backgroundColor: const Color(0xFFE0B0B4), // Rose gold
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
            child: Image.network(
              page.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50.sp,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: const Color(0xFFE0B0B4),
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
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
              color: const Color(0xFF2D2D2D), // Soft black
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
              color: const Color(0xFF2D2D2D).withOpacity(0.7),
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