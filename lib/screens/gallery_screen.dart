import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // Sample gallery images
  final List<Map<String, dynamic>> galleryImages = [
    {
      'title': 'Classic Fade',
      'imageUrl': 'https://img.freepik.com/free-photo/male-hairdresser-serving-client-barbershop_1303-20861.jpg',
      'likes': 124,
    },
    {
      'title': 'Beard Styling',
      'imageUrl': 'https://img.freepik.com/free-photo/barber-styling-beard-client_23-2147773210.jpg',
      'likes': 98,
    },
    {
      'title': 'Premium Shave',
      'imageUrl': 'https://img.freepik.com/free-photo/barber-using-towel-client-s-face_23-2147773209.jpg',
      'likes': 87,
    },
    {
      'title': 'Hair Coloring',
      'imageUrl': 'https://img.freepik.com/free-photo/hairdresser-cutting-client-s-hair-barbershop_1303-20448.jpg',
      'likes': 156,
    },
    {
      'title': 'Modern Fade',
      'imageUrl': 'https://img.freepik.com/free-photo/young-man-barbershop-trimming-hair_1303-26254.jpg',
      'likes': 142,
    },
    {
      'title': 'Beard Trim',
      'imageUrl': 'https://img.freepik.com/free-photo/man-barbershop-salon-doing-haircut-beard-trim_1303-20932.jpg',
      'likes': 113,
    },
    {
      'title': 'Vintage Cut',
      'imageUrl': 'https://img.freepik.com/free-photo/handsome-man-barber-shop-styling-hair_1303-20978.jpg',
      'likes': 92,
    },
    {
      'title': 'Hot Towel Treatment',
      'imageUrl': 'https://img.freepik.com/free-photo/barber-washing-client-s-hair_23-2147773206.jpg',
      'likes': 78,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gallery Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Our Gallery',
                  style: GoogleFonts.montserrat(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: const Color(0xFFC19A6B),
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
          
          // Gallery Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Explore our finest work and latest styles',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Gallery Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.75,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: galleryImages.length,
              itemBuilder: (context, index) {
                final image = galleryImages[index];
                return _buildGalleryItem(
                  title: image['title'],
                  imageUrl: image['imageUrl'],
                  likes: image['likes'],
                );
              },
            ),
          ),
          
          // Add some padding at the bottom
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildGalleryItem({required String title, required String imageUrl, required int likes}) {
    return Container(
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
              imageUrl,
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
            
            // Title and Likes
            Positioned(
              bottom: 12.h,
              left: 12.w,
              right: 12.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: const Color(0xFFC19A6B),
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        likes.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}