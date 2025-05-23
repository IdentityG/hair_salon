import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionCard extends StatelessWidget {
  final String title;
  final String description;
  final String code;
  final String imageUrl;
  final DateTime expiryDate;
  final VoidCallback onTap;

  const PromotionCard({
    super.key,
    required this.title,
    required this.description,
    required this.code,
    required this.imageUrl,
    required this.expiryDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        // Remove fixed height to prevent bottom overflow
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF1A2A40),
                    width: double.infinity,
                    height: 180.h,
                  );
                },
              ),
            ),
            
            // Gradient overlay
            Container(
              height: 180.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF1A2A40).withOpacity(0.9),
                    const Color(0xFF1A2A40).withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  // Limit width to prevent right overflow
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min size to prevent vertical overflow
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC19A6B),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'SPECIAL OFFER',
                            style: GoogleFonts.montserrat(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          title,
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          description,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.h),
                        // Wrap with Flexible to handle overflow in the row
                        Flexible(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFC19A6B),
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  code,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFC19A6B),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                child: Text(
                                  'Expires: ${expiryDate.day}/${expiryDate.month}/${expiryDate.year}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.sp,
                                    color: Colors.white54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Reduce the size of the empty space on the right
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
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