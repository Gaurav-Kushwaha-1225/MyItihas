import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';

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
    Color subTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    Color accentColor = Color(0xFF3B82F6); // Fixed blue for action buttons
    Color groupColor = Color(int.parse(avatarColor));
    Color dangerColor = isDark
        ? DarkColors.dangerColor
        : LightColors.dangerColor;

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
            icon: Icon(Icons.person_add_alt_1, color: textColor, size: 20.sp),
            onPressed: () {},
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),

            // Large Group Avatar
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: groupColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                  Container(
                    width: 38.w,
                    height: 38.w,
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

            SizedBox(height: 2.h),

            // Group Name
            Text(
              name,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 1.h),

            // Group member count
            Text(
              "Group · ${participants.length} members",
              style: GoogleFonts.inter(color: subTextColor, fontSize: 14.sp),
            ),

            SizedBox(height: 2.h),

            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "Official group for daily updates and discussions. Please maintain decorum.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),

            SizedBox(height: 3.h),
            Divider(color: subTextColor.withOpacity(0.1), thickness: 1),

            // Participants List Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
                    horizontal: 6.w,
                    vertical: 0.5.h,
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
                  trailing: user['status'] == "Admin"
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
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
              contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
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
              contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
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

            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
