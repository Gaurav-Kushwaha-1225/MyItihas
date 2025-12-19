import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const ProfileDetailPage({
    super.key,
    required this.name,
    this.email = "devotee@example.com",
    this.phone = "+91 98765 43210",
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color bgColor = isDark ? DarkColors.bgColor : LightColors.bgColor;
    Color textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    Color subTextColor =
        isDark ? DarkColors.textSecondary : LightColors.textSecondary;
    Color accentColor = Color(0xFF3B82F6);

    // Danger Colors from your constants
    Color dangerColor =
        isDark ? DarkColors.dangerColor : LightColors.dangerColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: subTextColor, size: 20.sp),
            onPressed: () {
              // Optional: Show bottom sheet or popup here too
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            // Large Avatar
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 168.w,
                    height: 168.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: accentColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                  Container(
                    width: 152.w,
                    height: 152.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withOpacity(0.2),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Text(
                        name[0],
                        style: GoogleFonts.inter(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: DarkColors.profileGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "Active now",
                  style: GoogleFonts.inter(
                    color: subTextColor,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.edit, color: subTextColor, size: 15.sp),
              ],
            ),

            SizedBox(height: 32.h),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(Icons.chat_bubble, accentColor, () {
                  context.pop();
                }),
                SizedBox(width: 32.w),
                _buildLargeCallButton(accentColor),
                SizedBox(width: 32.w),
                _buildActionButton(Icons.videocam_rounded, accentColor, () {}),
              ],
            ),

            SizedBox(height: 40.h),

            // Details List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  _buildDetailRow(
                    Icons.location_on,
                    "Mandi, India",
                    textColor,
                    subTextColor,
                  ),
                  SizedBox(height: 20.h),
                  _buildDetailRow(Icons.email, email, textColor, subTextColor),
                  SizedBox(height: 20.h),
                  _buildDetailRow(Icons.phone, phone, textColor, subTextColor),
                  SizedBox(height: 20.h),
                  _buildDetailRow(
                    Icons.calendar_today,
                    "Joined March 2024",
                    textColor,
                    subTextColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
            Divider(color: subTextColor.withOpacity(0.1)),
            SizedBox(height: 16.h),

            // --- BLOCK & REPORT SECTION ---
            _buildDangerOption(Icons.block, "Block $name", dangerColor),
            _buildDangerOption(
              Icons.thumb_down_alt_outlined,
              "Report $name",
              dangerColor,
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerOption(IconData icon, String text, Color color) {
    return InkWell(
      onTap: () {
        // Handle Block/Report Logic
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 16.w),
            Text(
              text,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... (Keep existing _buildActionButton, _buildLargeCallButton, _buildDetailRow helpers same as before)
  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 18.sp),
      ),
    );
  }

  Widget _buildLargeCallButton(Color color) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Icon(Icons.call, color: Colors.white, size: 24.sp),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String text,
    Color textColor,
    Color subTextColor,
  ) {
    return Row(
      children: [
        Icon(icon, color: subTextColor, size: 16.sp),
        SizedBox(width: 16.w),
        Text(
          text,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 13.sp, // Slightly tweaked size
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
