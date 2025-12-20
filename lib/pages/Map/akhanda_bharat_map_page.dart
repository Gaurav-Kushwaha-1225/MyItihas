import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/Map/Widget/sacred_places_data.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';

class AkhandaBharatMapPage extends StatefulWidget {
  const AkhandaBharatMapPage({super.key});

  @override
  State<AkhandaBharatMapPage> createState() => _AkhandaBharatMapPageState();
}

class _AkhandaBharatMapPageState extends State<AkhandaBharatMapPage>
    with SingleTickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();

  final double mapTopLat = 38.5;
  final double mapBottomLat = 5.0;
  final double mapLeftLon = 60.0;
  final double mapRightLon = 100.0;

  String _searchQuery = "";
  SacredPlace? _selectedPlace;
  bool _isDetailsVisible = false;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  Offset _getRelativePosition(double lat, double lon) {
    double xPercent = (lon - mapLeftLon) / (mapRightLon - mapLeftLon);
    double yPercent = (mapTopLat - lat) / (mapTopLat - mapBottomLat);
    return Offset(xPercent, yPercent);
  }

  void _updateZoom(double scaleFactor) {
    final Matrix4 currentMatrix = _transformationController.value;
    final double currentScale = currentMatrix.getMaxScaleOnAxis();
    final double newScale = (currentScale * scaleFactor).clamp(1.0, 5.0);

    final Matrix4 newMatrix = Matrix4.identity()..scale(newScale);
    if (newScale > 1.0) {
      newMatrix.setTranslation(currentMatrix.getTranslation());
    }

    setState(() {
      _transformationController.value = newMatrix;
    });
  }

  void _onPlaceSelected(SacredPlace place) {
    setState(() {
      _selectedPlace = place;
      _isDetailsVisible = true;
      _searchQuery = "";
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

    final filteredPlaces = sacredPlacesData.where((p) {
      return p.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: glassBg, shape: BoxShape.circle),
              child: Icon(Icons.arrow_back, color: textColor, size: 18.sp),
            ),
            onPressed: () => context.pop(),
          ),
        ),
        title: Text(
          "Sacred Atlas",
          style: GoogleFonts.playfairDisplay(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      // --- WRAPPING BODY IN CONTAINER FOR GRADIENT BACKGROUND ---
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? DarkColors.featureCardGradient
              : LightColors.featureCardGradient,
        ),
        child: Stack(
          children: [
            // 1. THE MAP BOX
            Center(
              child: Container(
                width: 92.w,
                height: 65.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black12,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 1.0,
                    maxScale: 5.0,
                    boundaryMargin: EdgeInsets.zero,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final height = constraints.maxHeight;

                          return Stack(
                            children: [
                              Image.asset(
                                'assets/images/akhand_bharat.png',
                                width: width,
                                height: height,
                                fit: BoxFit.fill,
                                errorBuilder: (_, __, ___) =>
                                    Container(color: Colors.transparent),
                              ),
                              ...sacredPlacesData.map((place) {
                                final pos = _getRelativePosition(
                                  place.lat,
                                  place.lon,
                                );
                                final isSelected =
                                    _selectedPlace?.id == place.id;

                                return Positioned(
                                  left: pos.dx * width - (isSelected ? 10 : 6),
                                  top: pos.dy * height - (isSelected ? 10 : 6),
                                  child: GestureDetector(
                                    onTap: () => _onPlaceSelected(place),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      width: isSelected ? 20 : 12,
                                      height: isSelected ? 20 : 12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? Colors.green
                                            : accentColor,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                (isSelected
                                                        ? Colors.green
                                                        : accentColor)
                                                    .withOpacity(0.5),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 2. Search Bar
            Positioned(
              top: 13.h,
              left: 4.w,
              right: 4.w,
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: glassBg,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isDark
                        ? DarkColors.glassBorder
                        : LightColors.glassBorder,
                  ),
                ),
                child: TextField(
                  style: TextStyle(color: textColor),
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: "Search sacred sites...",
                    hintStyle: TextStyle(
                      color: isDark
                          ? DarkColors.textSecondary
                          : LightColors.textSecondary,
                    ),
                    prefixIcon: Icon(Icons.search, color: accentColor),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                ),
              ),
            ),

            // 3. Search Results
            if (_searchQuery.isNotEmpty)
              Positioned(
                top: 20.h,
                left: 4.w,
                right: 4.w,
                child: Container(
                  constraints: BoxConstraints(maxHeight: 30.h),
                  decoration: BoxDecoration(
                    color: glassBg,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isDark
                          ? DarkColors.glassBorder
                          : LightColors.glassBorder,
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      final place = filteredPlaces[index];
                      return ListTile(
                        title: Text(
                          place.name,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          _onPlaceSelected(place);
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                ),
              ),

            // 4. Fixed Zoom Controls
            Positioned(
              right: 6.w,
              bottom: 25.h,
              child: Column(
                children: [
                  _buildZoomBtn(
                    Icons.add,
                    () => _updateZoom(1.4),
                    glassBg,
                    textColor,
                  ),
                  SizedBox(height: 1.5.h),
                  _buildZoomBtn(
                    Icons.remove,
                    () => _updateZoom(0.7),
                    glassBg,
                    textColor,
                  ),
                ],
              ),
            ),

            // 5. Details Sheet
            if (_isDetailsVisible && _selectedPlace != null)
              Positioned(
                left: 5.w,
                right: 5.w,
                bottom: 3.h,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: glassBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? DarkColors.glassBorder
                          : LightColors.glassBorder,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _selectedPlace!.name,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: textColor),
                            onPressed: () =>
                                setState(() => _isDetailsVisible = false),
                          ),
                        ],
                      ),
                      Text(
                        _selectedPlace!.ref,
                        style: TextStyle(
                          color: isDark
                              ? DarkColors.textSecondary
                              : LightColors.textSecondary,
                          fontSize: 10.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        _selectedPlace!.description,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 11.sp,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => context.push(
                            '/chat_detail',
                            extra: {'name': "MyItihas Guide"},
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Divine Guidance",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomBtn(
    IconData icon,
    VoidCallback onTap,
    Color bg,
    Color color,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 13.w,
        height: 13.w,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Icon(icon, color: color, size: 22.sp),
      ),
    );
  }
}
