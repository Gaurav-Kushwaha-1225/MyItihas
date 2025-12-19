import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  // Mock Data
  final List<Map<String, dynamic>> _frequentlyContacted = [
    {"name": "Aditya Gupta"},
    {"name": "Ram Kumar"},
    {"name": "User1"},
  ];

  final List<Map<String, dynamic>> _allContacts = [
    {"name": "Akash"},
    {"name": "Ram Sharma"},
    {"name": "Manish Kumar"},
    {"name": "dev Patel"},
    {"name": "User2"},
  ];

  // Track selected contacts
  final Set<String> _selectedContacts = {};

  void _toggleSelection(String name) {
    setState(() {
      if (_selectedContacts.contains(name)) {
        _selectedContacts.remove(name);
      } else {
        _selectedContacts.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final subTextColor =
        isDark ? DarkColors.textSecondary : LightColors.textSecondary;
    final glassBg = isDark ? DarkColors.glassBg : LightColors.cardBg;
    final glassBorder =
        isDark ? DarkColors.glassBorder : LightColors.glassBorder;
    final accentColor =
        isDark ? DarkColors.accentPrimary : LightColors.accentPrimary;
    final secondaryTextColor =
        isDark ? DarkColors.textSecondary : LightColors.textSecondary;

    return Scaffold(
      // 1. App Bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Container(
          decoration: BoxDecoration(
            gradient:
                isDark
                    ? DarkColors.featureCardGradient
                    : LightColors.featureCardGradient,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).secondaryHeaderColor.withAlpha(50),
                blurRadius: 10,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: textColor),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New Group",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            foreground:
                                Paint()
                                  ..shader = (isDark
                                          ? DarkColors.messageUserGradient
                                          : LightColors.messageUserGradient)
                                      .createShader(
                                        Rect.fromLTWH(0, 0, 200, 70),
                                      ),
                          ),
                        ),
                        Text(
                          "Add participants",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: accentColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // 2. Body
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).primaryColor.withAlpha(5),
              isDark ? Color(0xFF1E293B) : Color(0xFFF1F5F9),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          children: [
            // Frequently Contacted Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Text(
                "Frequently contacted",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: secondaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Frequent Contacts List
            ..._frequentlyContacted.map(
              (contact) => _buildContactItem(
                contact,
                isDark,
                textColor,
                subTextColor,
                glassBg,
                glassBorder,
                accentColor,
              ),
            ),

            SizedBox(height: 16.h),

            // All Contacts Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Text(
                "Contacts on MyItihas",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: secondaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // All Contacts List
            ..._allContacts.map(
              (contact) => _buildContactItem(
                contact,
                isDark,
                textColor,
                subTextColor,
                glassBg,
                glassBorder,
                accentColor,
              ),
            ),

            // Padding for FAB
            SizedBox(height: 80.h),
          ],
        ),
      ),

      // 3. Floating Action Button (Forward Arrow)
      floatingActionButton:
          _selectedContacts.isNotEmpty
              ? Container(
                margin: EdgeInsets.only(bottom: 16.h, right: 16.w),
                child: FloatingActionButton(
                  onPressed: () {
                    // Navigate to next step (Group Name, etc.)
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              )
              : null,
    );
  }

  Widget _buildContactItem(
    Map<String, dynamic> contact,
    bool isDark,
    Color textColor,
    Color subTextColor,
    Color glassBg,
    Color glassBorder,
    Color accentColor,
  ) {
    bool isSelected = _selectedContacts.contains(contact['name']);

    return InkWell(
      onTap: () => _toggleSelection(contact['name']),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Avatar Stack
            Stack(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Placeholder color or image
                    color: accentColor.withOpacity(0.2),
                    image:
                        contact['img'] != null
                            ? DecorationImage(image: AssetImage(contact['img']))
                            : null,
                  ),
                  child:
                      contact['img'] == null
                          ? Icon(Icons.person, color: accentColor, size: 24.sp)
                          : null,
                ),
                // Selection Checkmark (if selected)
                if (isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: DarkColors.profileGreen,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? DarkColors.bgColor : Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Icon(Icons.check, size: 12.sp, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16.w),

            // Name and Status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'],
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
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
