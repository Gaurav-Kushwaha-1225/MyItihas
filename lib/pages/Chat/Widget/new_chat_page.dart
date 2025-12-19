import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  // Mock data
  final List<Map<String, String>> _frequentlyContacted = [
    {"name": "Aditya Gupta"},
    {"name": "Ram Kumar"},
    {"name": "User1"},
  ];

  final List<Map<String, String>> _allContacts = [
    {"name": "Akash"},
    {"name": "Ram Sharma"},
    {"name": "Manish Kumar"},
    {"name": "Dev Patel"},
    {"name": "User2"},
  ];

  //
  // BUILD

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: _buildAppBar(context, isDark),
      ),
      body: _buildBody(context, isDark),
    );
  }

  //
  // APP BAR

  Widget _buildAppBar(BuildContext context, bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? DarkColors.featureCardGradient
            : LightColors.featureCardGradient,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).secondaryHeaderColor.withAlpha(120),
            blurRadius: 200,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => context.pop(),
            ),
            Expanded(
              child: Text(
                "New Chat",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  foreground: Paint()
                    ..shader =
                        (isDark
                                ? DarkColors.messageUserGradient
                                : LightColors.messageUserGradient)
                            .createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  // BODY

  Widget _buildBody(BuildContext context, bool isDark) {
    return Container(
      decoration: _buildBackgroundGradient(context, isDark),
      child: Column(
        children: [
          _buildSearchBar(isDark),
          _buildTopOptions(context, isDark),
          _buildContactLists(isDark),
        ],
      ),
    );
  }

  //
  // BACKGROUND

  BoxDecoration _buildBackgroundGradient(BuildContext context, bool isDark) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Theme.of(context).primaryColor.withAlpha(5),
          isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        ],
        transform: const GradientRotation(3.14 / 1.5),
      ),
    );
  }

  //
  // SEARCH BAR

  Widget _buildSearchBar(bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final secondaryTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final inputBg = isDark ? DarkColors.inputBg : LightColors.inputBg;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDark ? DarkColors.glassBorder : LightColors.glassBorder,
          ),
        ),
        child: TextField(
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: "Search name or number",
            hintStyle: TextStyle(color: secondaryTextColor),
            prefixIcon: Icon(Icons.search, color: secondaryTextColor),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }

  //
  // TOP OPTIONS (NEW GROUP / CONTACT)

  Widget _buildTopOptions(BuildContext context, bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final secondaryTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final accentColor = isDark
        ? DarkColors.accentPrimary
        : LightColors.accentPrimary;

    return Column(
      children: [
        _buildOptionTile(
          icon: Icons.group_add,
          title: "New group",
          textColor: textColor,
          accentColor: accentColor,
          onTap: () => context.push('/new-group'),
        ),
        _buildOptionTile(
          icon: Icons.person_add,
          title: "New contact",
          textColor: textColor,
          accentColor: accentColor,
          onTap: () => context.push('/new-contact'),
        ),
        Divider(color: secondaryTextColor.withOpacity(0.2)),
      ],
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required Color textColor,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: accentColor,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  //
  // CONTACT LISTS

  Widget _buildContactLists(bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final secondaryTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final accentColor = isDark
        ? DarkColors.accentPrimary
        : LightColors.accentPrimary;

    return Expanded(
      child: ListView(
        children: [
          _buildSectionTitle("Frequently contacted", secondaryTextColor),
          ..._frequentlyContacted.map(
            (contact) => _buildContactTile(contact, textColor, accentColor),
          ),
          Divider(color: secondaryTextColor.withOpacity(0.2)),
          _buildSectionTitle("Contacts on myitihas", secondaryTextColor),
          ..._allContacts.map(
            (contact) => _buildContactTile(contact, textColor, accentColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //
  // CONTACT TILE

  Widget _buildContactTile(
    Map<String, String> contact,
    Color textColor,
    Color accentColor,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: accentColor.withOpacity(0.2),
        child: Text(
          contact['name']![0],
          style: TextStyle(
            fontSize: 18.sp,
            color: accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        contact['name']!,
        style: TextStyle(
          fontSize: 15.sp,
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: () {
        // Navigate to chat detail
      },
    );
  }
}
