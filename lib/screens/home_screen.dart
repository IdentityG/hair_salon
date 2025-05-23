import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/screens/booking_screen.dart';
import 'package:hair_salon/screens/gallery_screen.dart';
import 'package:hair_salon/screens/profile_screen.dart';
import 'package:hair_salon/widgets/barber_card.dart';
import 'package:hair_salon/widgets/category_button.dart';
import 'package:hair_salon/widgets/promotion_card.dart';
import 'package:hair_salon/widgets/service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;
  final List<Map<String, dynamic>> _categories = [
    {'title': 'All', 'icon': Icons.grid_view_rounded},
    {'title': 'Haircut', 'icon': Icons.content_cut},
    {'title': 'Beard', 'icon': Icons.face},
    {'title': 'Shave', 'icon': Icons.spa},
    {'title': 'Color', 'icon': Icons.color_lens},
  ];

  // Remove these lines
  late final List<Widget> _screens;
  
  @override
  void initState() {
    super.initState();
    _screens = [
      _buildHomeContent(),
      const BookingScreen(),
      const GalleryScreen(),
      const ProfileScreen(),
    ];
  }
  
  // Home content
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'John Doe',
                      style: GoogleFonts.montserrat(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: const NetworkImage(
                        'https://img.freepik.com/free-photo/portrait-handsome-man-with-dark-hairstyle-bristle-toothy-smile-dressed-white-sweatshirt-feels-very-glad-poses-indoor-pleased-european-guy-being-photographed-white-wall-emotions-concept_273609-61405.jpg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white70,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search services, barbers...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.white38,
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.mic,
                    color: Colors.white70,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
          
          // Promotions
          SizedBox(height: 16.h),
          PromotionCard(
            title: 'Father\'s Day Special',
            description: 'Get 20% off on premium haircuts and beard trims',
            code: 'FATHER20',
            imageUrl: 'https://img.freepik.com/free-photo/male-hairdresser-serving-client-barbershop_1303-20861.jpg',
            expiryDate: DateTime(2023, 6, 30),
            onTap: () {
              // Handle promotion tap
            },
          ),
          
          // Featured Barbers
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Barbers',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to all barbers
                  },
                  child: Text(
                    'See All',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFC19A6B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Barbers List
          SizedBox(
            height: 260.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20.w, right: 8.w),
              children: [
                BarberCard(
                  name: 'Mike Johnson',
                  specialty: 'Master Barber',
                  rating: 4.9,
                  imageUrl: 'https://img.freepik.com/free-photo/portrait-handsome-bearded-european-man-with-grey-hair-beard-smiles-pleasantly-looks-directly-front-being-good-mood-after-meeting-with-friend-isolated-white-wall_273609-57668.jpg',
                  isAvailable: true,
                  onTap: () {
                    // Handle barber selection
                  },
                ),
                SizedBox(width: 16.w),
                BarberCard(
                  name: 'David Smith',
                  specialty: 'Color Specialist',
                  rating: 4.7,
                  imageUrl: 'https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg',
                  isAvailable: true,
                  onTap: () {
                    // Handle barber selection
                  },
                ),
                SizedBox(width: 16.w),
                BarberCard(
                  name: 'Robert Wilson',
                  specialty: 'Beard Expert',
                  rating: 4.8,
                  imageUrl: 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
                  isAvailable: false,
                  onTap: () {
                    // Handle barber selection
                  },
                ),
              ],
            ),
          ),
          
          // Services Categories
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 16.h),
            child: Text(
              'Services',
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          // Category Buttons
          SizedBox(
            height: 50.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20.w),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CategoryButton(
                  title: _categories[index]['title'],
                  icon: _categories[index]['icon'],
                  isSelected: _selectedCategoryIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          
          // Services Grid
          Padding(
            padding: EdgeInsets.all(20.w),
            child: _buildFilteredServicesGrid(),
          ),
        ],
      ),
    );
  }
  
  // Add a list of services with their categories
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Classic Haircut',
      'price': 25,
      'duration': 30,
      'category': 'Haircut',
      'imageUrl': 'https://img.freepik.com/free-photo/male-hairdresser-serving-client-barbershop_1303-20861.jpg',
    },
    {
      'name': 'Beard Trim',
      'price': 15,
      'duration': 20,
      'category': 'Beard',
      'imageUrl': 'https://img.freepik.com/free-photo/barber-styling-beard-client_23-2147773210.jpg',
    },
    {
      'name': 'Hot Towel Shave',
      'price': 30,
      'duration': 45,
      'category': 'Shave',
      'imageUrl': 'https://img.freepik.com/free-photo/barber-using-towel-client-s-face_23-2147773209.jpg',
    },
    {
      'name': 'Hair Coloring',
      'price': 45,
      'duration': 60,
      'category': 'Color',
      'imageUrl': 'https://img.freepik.com/free-photo/hairdresser-cutting-client-s-hair-barbershop_1303-20448.jpg',
    },
    {
      'name': 'Fade Haircut',
      'price': 30,
      'duration': 35,
      'category': 'Haircut',
      'imageUrl': 'https://img.freepik.com/free-photo/young-man-barbershop-trimming-hair_1303-26254.jpg',
    },
    {
      'name': 'Beard Styling',
      'price': 20,
      'duration': 25,
      'category': 'Beard',
      'imageUrl': 'https://img.freepik.com/free-photo/man-barbershop-salon-doing-haircut-beard-trim_1303-20932.jpg',
    },
  ];
  
  @override
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
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              _buildHomeContent(),
              const BookingScreen(),
              const GalleryScreen(),
              const ProfileScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1A2A40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: _buildNavItem(Icons.home_filled, 'Home', _selectedIndex == 0),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: _buildNavItem(Icons.calendar_today, 'Bookings', _selectedIndex == 1),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: _buildNavItem(Icons.photo_library, 'Gallery', _selectedIndex == 2),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: _buildNavItem(Icons.person_outline, 'Profile', _selectedIndex == 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xFFC19A6B) : Colors.white54,
          size: 24.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? const Color(0xFFC19A6B) : Colors.white54,
          ),
        ),
      ],
    );
  }

  // Method to filter and build the services grid
  Widget _buildFilteredServicesGrid() {
    // Filter services based on selected category
    List<Map<String, dynamic>> filteredServices = _selectedCategoryIndex == 0
        ? _services // Show all services if "All" is selected
        : _services.where((service) => 
            service['category'] == _categories[_selectedCategoryIndex]['title']).toList();
    
    // If no services match the filter, show a message
    if (filteredServices.isEmpty) {
      return Center(
        child: Text(
          'No services available in this category',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.white70,
          ),
        ),
      );
    }
    
    // Build grid with filtered services
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 0.8,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredServices.length,
      itemBuilder: (context, index) {
        final service = filteredServices[index];
        return ServiceCard(
          name: service['name'],
          price: service['price'],
          duration: service['duration'],
          imageUrl: service['imageUrl'],
          onTap: () {
            // Handle service selection
          },
        );
      },
    );
  }
}