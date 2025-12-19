import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupProfilePage extends StatelessWidget {
  final String name;
  final String avatarColor;

  const GroupProfilePage({
    super.key,
    required this.name,
    this.avatarColor = "0xFF8B5CF6", // Default purple for groups
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color bgColor = isDark ? DarkColors.bgColor : LightColors.bgColor;
    Color textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    Color subTextColor =
        isDark ? DarkColors.textSecondary : LightColors.textSecondary;
    Color accentColor = Color(0xFF3B82F6); // Fixed blue for action buttons
    Color groupColor = Color(int.parse(avatarColor));
    Color dangerColor =
        isDark ? DarkColors.dangerColor : LightColors.dangerColor;

    // Mock Participants Data
    final List<Map<String, String>> participants = [
      {"name": "You", "status": "Admin", "color": "0xFF3B82F6"},
      {"name": "Aditya Gupta", "status": "Available", "color": "0xFFEAB308"},
      {"name": "Piyush Sharma", "status": "At the gym", "color": "0xFFEC4899"},
      {"name": "Ram Kumar", "status": "Busy", "color": "0xFF10B981"},
      {"name": "Amit Singh", "status": "Sleeping", "color": "0xFF6366F1"},
      {"name": "Sneha", "status": "Available", "color": "0xFFF97316"},
    ];

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
            icon: Icon(
              Icons.person_add_alt_1,
              color: subTextColor,
              size: 20.sp,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_horiz, color: subTextColor, size: 20.sp),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            // Large Group Avatar
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
                        color: groupColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                  Container(
                    width: 152.w,
                    height: 152.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: groupColor.withOpacity(0.2),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Text(
                        name[0],
                        style: GoogleFonts.inter(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                          color: groupColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Group Name
            Text(
              name,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Group · ${participants.length} members",
              style: GoogleFonts.inter(color: subTextColor, fontSize: 14.sp),
            ),

            SizedBox(height: 32.h),

            // --- ACTION BUTTONS (Updated Layout) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Chat Button
                _buildActionButton(
                  Icons.chat_bubble,
                  accentColor,
                  56.w,
                  18.sp,
                  () => context.pop(),
                ),

                SizedBox(width: 24.w),

                // Large Call Button (Center)
                _buildActionButton(Icons.call, accentColor, 72.w, 24.sp, () {}),

                SizedBox(width: 24.w),

                // Video Button
                _buildActionButton(
                  Icons.videocam_rounded,
                  accentColor,
                  56.w,
                  18.sp,
                  () {},
                ),
              ],
            ),

            SizedBox(height: 32.h),
            Divider(color: subTextColor.withOpacity(0.1), thickness: 1),

            // Description Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.inter(
                      color: accentColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Official group for daily updates and discussions. Please maintain decorum.",
                    style: GoogleFonts.inter(color: textColor, fontSize: 14.sp),
                  ),
                ],
              ),
            ),

            Divider(color: subTextColor.withOpacity(0.1), thickness: 8),

            // Participants List Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${participants.length} members",
                    style: GoogleFonts.inter(
                      color: subTextColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.search, color: subTextColor, size: 18.sp),
                ],
              ),
            ),

            // Participants List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: participants.length,
              itemBuilder: (context, index) {
                final user = participants[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 4.h,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Color(
                      int.parse(user['color']!),
                    ).withOpacity(0.2),
                    child: Text(
                      user['name']![0],
                      style: GoogleFonts.inter(
                        color: Color(int.parse(user['color']!)),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    user['name']!,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  subtitle: Text(
                    user['status']!,
                    style: GoogleFonts.inter(
                      color: subTextColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing:
                      user['status'] == "Admin"
                          ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: accentColor.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              "Group Admin",
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          : null,
                );
              },
            ),

            Divider(color: subTextColor.withOpacity(0.1), thickness: 1),

            // Exit Group
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              leading: Icon(Icons.exit_to_app, color: dangerColor),
              title: Text(
                "Exit Group",
                style: TextStyle(
                  color: dangerColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {},
            ),

            // Report Group
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              leading: Icon(Icons.thumb_down_alt_outlined, color: dangerColor),
              title: Text(
                "Report Group",
                style: TextStyle(
                  color: dangerColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {},
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  // Unified Builder for all action buttons
  Widget _buildActionButton(
    IconData icon,
    Color color,
    double size,
    double iconSize,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 20, // Increased blur for glow effect
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }
}
