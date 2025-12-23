import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/Map/Widget/shaktipeethas_section.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:myitihas/utils/theme.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

class ShaktiPeethaDetailPage extends StatefulWidget {
  const ShaktiPeethaDetailPage({super.key});

  @override
  State<ShaktiPeethaDetailPage> createState() => _ShaktiPeethaDetailPageState();
}

class _ShaktiPeethaDetailPageState extends State<ShaktiPeethaDetailPage> {
  ShaktipeethaData? _selectedShaktipeetha; // Track selected Shaktipeetha
  bool _isShaktiDetailsVisible = false;

  void _showShaktiDetails(ShaktipeethaData data) {
    setState(() {
      _selectedShaktipeetha = data;
      _isShaktiDetailsVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final glassBg = isDark ? DarkColors.glassBg : Colors.white.withOpacity(0.9);
    final accentColor = isDark
        ? DarkColors.accentPrimary
        : LightColors.accentPrimary;

    final Gradient selectedGradient = LinearGradient(
      colors: isDark
          ? [Colors.white, DarkColors.accentPrimary]
          : [textColor, textColor],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              ?isDark ? Colors.transparent.withOpacity(1) : null,
              DarkColors.glowPrimary.withAlpha(50),

              // ?isDark ? DarkColors.glassBg : null,
              isDark
                  ? DarkColors.accentSecondary.withOpacity(0.3)
                  : DarkColors.glassBorder,
              ?isDark ? Colors.transparent.withOpacity(1) : null,
            ],
            transform: GradientRotation(3.14 / 1.5),
          ),
        ),
        child:
            // --- 1. SCROLLABLE CONTENT LAYER ---
            Stack(
              children: [
                Positioned(
                  left: 1.h,
                  right: 2.h,
                  top: 5.5.h,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.of(context).pop(); // 👈 pop back
                        },
                      ),
                      Expanded(
                        child: Text(
                          "Shaktipeethas",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            foreground: Paint()
                              ..shader = selectedGradient.createShader(
                                Rect.fromLTWH(0, 0, 60.w, 8.h),
                              ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<ThemeBloc>().add(ToggleTheme());
                        },
                        child: Icon(
                          Icons.dark_mode,
                          color: isDark ? Colors.white : Colors.black,
                          size: 18.sp,
                        ),
                      ),
                      SizedBox(width: 2.w),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 11.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Column(
                      children: [
                        _sectionTitle3(),
                        SizedBox(height: 2.h),

                        ShaktipeethasSection(onCardTap: _showShaktiDetails),
                      ],
                    ),
                  ),
                ),
                if (_isShaktiDetailsVisible && _selectedShaktipeetha != null)
                  _buildShaktipeethaDetailsOverlay(
                    textColor,
                    glassBg,
                    accentColor,
                    isDark,
                  ),
              ],
            ),
      ),
    );
  }

  Widget _subtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Colors.cyanAccent, Colors.pinkAccent],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),

          child: Text(
            "Beyond modern borders lies a cultural and spiritual subcontinent "
            "bound by shared philosophies, traditions, and epic narratives.",
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? [Colors.white, Color(0xFF7DD3FC), Color(0xFFA78BFA)]
        : [Colors.black, Colors.black, Colors.black];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Text(
        "A Tapestry of Shared\nHeritage",
        style: GoogleFonts.playfairDisplay(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          height: 1.25,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: textColor,
            ).createShader(const Rect.fromLTWH(0, 0, 300, 80)),
        ),
      ),
    );
  }

  Widget _descriptionText(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: Text(
          "Akhanda Bharata, or \"Undivided Bharat,\" represents a profound cultural "
          "and spiritual unity that transcends modern political borders. "
          "This historical expanse, covering the land of present-day Bharat, "
          "Pakistan, Afghanistan, Nepal, Bhutan, Bangladesh, Sri Lanka, "
          "and Myanmar, was knit together by a deeply integrated worldview.\n\n"
          "Great empires, from the Mauryan to the Gupta, unified vast territories, "
          "creating channels for a shared culture, art, and administrative "
          "philosophy to flow across the subcontinent.",
          style: TextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle3() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? [Colors.white, Color(0xFF7DD3FC), Color(0xFFA78BFA)]
        : [Colors.black, Colors.black, Colors.black];
    return Text(
      "The 18 Sacred Shaktipeethas",
      textAlign: TextAlign.center,
      style: GoogleFonts.playfairDisplay(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        height: 1.25,
        foreground: Paint()
          ..shader = LinearGradient(
            colors: textColor,
          ).createShader(const Rect.fromLTWH(0, 0, 300, 80)),
      ),
    );
  }

  Widget _buildShaktipeethaDetailsOverlay(
    Color txt,
    Color glass,
    Color acc,
    bool isDark,
  ) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _isShaktiDetailsVisible = false),
        child: Container(
          color: Colors.black45, // Dim background
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: glass,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedShaktipeetha!.title,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: txt,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 15.sp,
                                    color: acc,
                                  ),
                                  Text(
                                    _selectedShaktipeetha!.location,
                                    style: TextStyle(
                                      color: acc,
                                      fontSize: 15.sp,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.close_rounded, color: txt),
                            onPressed: () =>
                                setState(() => _isShaktiDetailsVisible = false),
                          ),
                        ],
                      ),
                      Divider(height: 30, color: txt.withOpacity(0.5)),
                      // Purple Body Part Tag
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: DarkColors.glowSecondary.withOpacity(0.3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _selectedShaktipeetha!.bodyPart,
                            style: TextStyle(
                              color: DarkColors.accentSecondary,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _selectedShaktipeetha!.description,
                        style: TextStyle(
                          color: txt,
                          fontSize: 15.sp,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      // Sacred Significance Box (Light Blue)
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: DarkColors.glassHoverBorder.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: acc.withOpacity(0.5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: acc,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  "Sacred Significance",
                                  style: TextStyle(
                                    color: acc,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              _selectedShaktipeetha!.sacredSignificance,
                              style: TextStyle(color: txt, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 30, color: txt.withOpacity(0.5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: 14.sp,
                            color: txt.withOpacity(0.7),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            _selectedShaktipeetha!.references,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontStyle: FontStyle.italic,
                              color: txt.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      // Know More Button
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          height: 5.5.h,
                          decoration: BoxDecoration(
                            // Use your theme's gradient
                            gradient: isDark
                                ? DarkColors.messageUserGradient
                                : LightColors.messageUserGradient,
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // Fully rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () => context.push(
                              '/chat_detail',
                              extra: {'name': "MyItihas Guide"},
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            icon: Icon(
                              CupertinoIcons.chat_bubble_2_fill,
                              color: Colors.white,
                              size: 19.sp,
                            ),
                            label: Text(
                              "Know More",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
