import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_salon/widgets/barber_card.dart';
import 'package:hair_salon/widgets/category_button.dart';
import 'package:hair_salon/widgets/service_card.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Selected date, barber, service and time slot
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  int _selectedBarberIndex = 0;
  int _selectedServiceIndex = -1;
  int _selectedTimeSlot = -1;
  
  // List of available barbers
  final List<Map<String, dynamic>> _barbers = [
    {
      'name': 'Mike Johnson',
      'specialty': 'Master Barber',
      'rating': 4.9,
      'imageUrl': 'https://img.freepik.com/free-photo/portrait-handsome-bearded-european-man-with-grey-hair-beard-smiles-pleasantly-looks-directly-front-being-good-mood-after-meeting-with-friend-isolated-white-wall_273609-57668.jpg',
      'isAvailable': true,
    },
    {
      'name': 'David Smith',
      'specialty': 'Color Specialist',
      'rating': 4.7,
      'imageUrl': 'https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg',
      'isAvailable': true,
    },
    {
      'name': 'Robert Wilson',
      'specialty': 'Beard Expert',
      'rating': 4.8,
      'imageUrl': 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      'isAvailable': false,
    },
  ];
  
  // List of services
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
  ];
  
  // Available time slots
  final List<String> _timeSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', 
    '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM', '05:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    // Remove the Scaffold and just return the content
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                Text(
                  'Book Appointment',
                  style: GoogleFonts.montserrat(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
          
          // Calendar Section
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                Text(
                  'Select Date',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.h),
                TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 60)),
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.week,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    defaultTextStyle: GoogleFonts.poppins(
                      color: Colors.white70,
                    ),
                    weekendTextStyle: GoogleFonts.poppins(
                      color: Colors.white70,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFC19A6B),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFFC19A6B).withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    leftChevronIcon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white70,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Barber Selection
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 16.h),
            child: Text(
              'Select Barber',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(
            height: 100.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20.w),
              itemCount: _barbers.length,
              itemBuilder: (context, index) {
                final barber = _barbers[index];
                final isSelected = _selectedBarberIndex == index;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBarberIndex = index;
                    });
                  },
                  child: Container(
                    width: 80.w,
                    margin: EdgeInsets.only(right: 16.w),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? const Color(0xFFC19A6B).withOpacity(0.2)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected 
                            ? const Color(0xFFC19A6B) 
                            : Colors.white.withOpacity(0.1),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage: NetworkImage(barber['imageUrl']),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          barber['name'].split(' ')[0],
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? const Color(0xFFC19A6B) : Colors.white70,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Service Selection
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 16.h),
            child: Text(
              'Select Service',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(
            height: 140.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20.w),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                final isSelected = _selectedServiceIndex == index;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedServiceIndex = index;
                    });
                  },
                  child: Container(
                    width: 140.w,
                    margin: EdgeInsets.only(right: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected 
                            ? const Color(0xFFC19A6B) 
                            : Colors.white.withOpacity(0.1),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                          child: Image.network(
                            service['imageUrl'],
                            width: 140.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '\$${service['price']} • ${service['duration']} min',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  color: isSelected 
                                      ? const Color(0xFFC19A6B) 
                                      : Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Time Slot Selection
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 16.h),
            child: Text(
              'Select Time',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: List.generate(
                _timeSlots.length,
                (index) {
                  final isSelected = _selectedTimeSlot == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTimeSlot = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFC19A6B)
                            : Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFC19A6B)
                              : Colors.white.withOpacity(0.1),
                          width: 1.w,
                        ),
                      ),
                      child: Text(
                        _timeSlots[index],
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Colors.white : Colors.white70,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Booking Summary
          if (_selectedServiceIndex != -1 && _selectedTimeSlot != -1)
            Container(
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFC19A6B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFFC19A6B).withOpacity(0.3),
                  width: 1.w,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking Summary',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildSummaryRow(
                    'Date',
                    '${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}',
                  ),
                  _buildSummaryRow(
                    'Time',
                    _timeSlots[_selectedTimeSlot],
                  ),
                  _buildSummaryRow(
                    'Barber',
                    _barbers[_selectedBarberIndex]['name'],
                  ),
                  _buildSummaryRow(
                    'Service',
                    _services[_selectedServiceIndex]['name'],
                  ),
                  _buildSummaryRow(
                    'Duration',
                    '${_services[_selectedServiceIndex]['duration']} min',
                  ),
                  _buildSummaryRow(
                    'Price',
                    '\$${_services[_selectedServiceIndex]['price']}',
                    isLast: true,
                  ),
                ],
              ),
            ),
          
          // Book Now Button
          Padding(
            padding: EdgeInsets.all(20.w),
            child: ElevatedButton(
              onPressed: _selectedServiceIndex != -1 && _selectedTimeSlot != -1
                  ? () {
                      // Handle booking
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC19A6B),
                disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                minimumSize: Size(double.infinity, 56.h),
                elevation: 0,
              ),
              child: Text(
                'Book Appointment',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
  
  Widget _buildSummaryRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}