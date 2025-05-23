import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data
  final Map<String, dynamic> userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+1 (555) 123-4567',
    'memberSince': 'March 2023',
    'loyaltyPoints': 350,
    'profileImage': 'https://img.freepik.com/free-photo/portrait-handsome-man-with-dark-hairstyle-bristle-toothy-smile-dressed-white-sweatshirt-feels-very-glad-poses-indoor-pleased-european-guy-being-photographed-white-wall-emotions-concept_273609-61405.jpg',
  };

  // Sample appointment history
  final List<Map<String, dynamic>> appointmentHistory = [
    {
      'service': 'Classic Haircut',
      'barber': 'Mike Johnson',
      'date': 'May 15, 2023',
      'time': '10:30 AM',
      'price': 25,
      'status': 'Completed',
    },
    {
      'service': 'Beard Trim',
      'barber': 'David Smith',
      'date': 'April 28, 2023',
      'time': '2:15 PM',
      'price': 15,
      'status': 'Completed',
    },
    {
      'service': 'Hair Coloring',
      'barber': 'Robert Wilson',
      'date': 'June 5, 2023',
      'time': '11:00 AM',
      'price': 45,
      'status': 'Upcoming',
    },
  ];

  // Sample favorite styles
  final List<Map<String, dynamic>> favoriteStyles = [
    {
      'name': 'Modern Fade',
      'imageUrl': 'https://img.freepik.com/free-photo/young-man-barbershop-trimming-hair_1303-26254.jpg',
    },
    {
      'name': 'Beard Styling',
      'imageUrl': 'https://img.freepik.com/free-photo/barber-styling-beard-client_23-2147773210.jpg',
    },
    {
      'name': 'Classic Cut',
      'imageUrl': 'https://img.freepik.com/free-photo/male-hairdresser-serving-client-barbershop_1303-20861.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header with curved bottom
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A2A40), // Deep Navy Blue
                  Color(0xFF2D3142), // Dark Charcoal
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top section with settings and edit buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.montserrat(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                              Icons.edit_outlined,
                              color: const Color(0xFFC19A6B),
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.settings_outlined,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Profile image and info
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    children: [
                      // Profile image with gold border
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFC19A6B),
                            width: 3.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60.r),
                          child: Image.network(
                            userData['profileImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      
                      // User name
                      Text(
                        userData['name'],
                        style: GoogleFonts.montserrat(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      // Member since
                      Text(
                        'Member since ${userData['memberSince']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.white70,
                        ),
                      ),
                      
                      SizedBox(height: 16.h),
                      
                      // Loyalty points badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC19A6B).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: const Color(0xFFC19A6B),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: const Color(0xFFC19A6B),
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '${userData['loyaltyPoints']} Loyalty Points',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFC19A6B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Contact info with stylish divider
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.h,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'CONTACT INFO',
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white38,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.h,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Contact info cards
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildContactInfoCard(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: userData['email'],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildContactInfoCard(
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: userData['phone'],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24.h),
              ],
            ),
          ),
          
          // Appointment History Section
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Appointment History',
                      style: GoogleFonts.montserrat(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to full history
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
                
                SizedBox(height: 12.h),
                
                // Appointment cards
                ...appointmentHistory.map((appointment) => _buildAppointmentCard(appointment)).toList(),
              ],
            ),
          ),
          
          // Favorite Styles Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Favorite Styles',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Horizontal list of favorite styles
                SizedBox(
                  height: 120.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: favoriteStyles.length,
                    itemBuilder: (context, index) {
                      final style = favoriteStyles[index];
                      return Container(
                        width: 120.w,
                        margin: EdgeInsets.only(right: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Stack(
                            children: [
                              // Image
                              Image.network(
                                style['imageUrl'],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              
                              // Gradient Overlay
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                    stops: const [0.6, 1.0],
                                  ),
                                ),
                              ),
                              
                              // Style name
                              Positioned(
                                bottom: 12.h,
                                left: 12.w,
                                right: 12.w,
                                child: Text(
                                  style['name'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Settings Section
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Settings options
                _buildSettingsOption(Icons.notifications_outlined, 'Notifications', true),
                _buildSettingsOption(Icons.payment_outlined, 'Payment Methods', false),
                _buildSettingsOption(Icons.language_outlined, 'Language', false),
                _buildSettingsOption(Icons.help_outline, 'Help & Support', false),
                _buildSettingsOption(Icons.privacy_tip_outlined, 'Privacy Policy', false),
                
                SizedBox(height: 16.h),
                
                // Logout button
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom padding
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // Contact info card widget
  Widget _buildContactInfoCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFC19A6B),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Appointment card widget
  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    final bool isUpcoming = appointment['status'] == 'Upcoming';
    
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isUpcoming ? const Color(0xFFC19A6B).withOpacity(0.1) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUpcoming ? const Color(0xFFC19A6B).withOpacity(0.3) : Colors.white.withOpacity(0.1),
          width: 1.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
        children: [
          // Service icon
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: isUpcoming ? const Color(0xFFC19A6B).withOpacity(0.2) : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(
                appointment['service'].contains('Hair') ? Icons.content_cut : Icons.face,
                color: isUpcoming ? const Color(0xFFC19A6B) : Colors.white70,
                size: 24.sp,
              ),
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Appointment details
          Expanded(
            flex: 3, // Give more space to the details
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment['service'],
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                ),
                SizedBox(height: 4.h),
                Text(
                  'with ${appointment['barber']}',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.white70,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: isUpcoming ? const Color(0xFFC19A6B) : Colors.white54,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      appointment['date'],
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: isUpcoming ? const Color(0xFFC19A6B) : Colors.white54,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.access_time,
                      color: isUpcoming ? const Color(0xFFC19A6B) : Colors.white54,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Flexible( // Make this text flexible
                      child: Text(
                        appointment['time'],
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: isUpcoming ? const Color(0xFFC19A6B) : Colors.white54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Price and status
          SizedBox(width: 8.w), // Add some spacing
          Expanded(
            flex: 1, // Give less space to the price/status column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${appointment['price']}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC19A6B),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isUpcoming ? const Color(0xFFC19A6B).withOpacity(0.2) : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    appointment['status'],
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isUpcoming ? const Color(0xFFC19A6B) : Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Settings option widget
  Widget _buildSettingsOption(IconData icon, String title, bool hasNotification) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(
                icon,
                color: const Color(0xFFC19A6B),
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          if (hasNotification)
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFFC19A6B),
                shape: BoxShape.circle,
              ),
            ),
          SizedBox(width: 8.w),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white54,
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}