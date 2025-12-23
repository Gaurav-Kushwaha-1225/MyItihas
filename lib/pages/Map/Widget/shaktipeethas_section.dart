import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';

class ShaktipeethaData {
  final String title;
  final String location;
  final String bodyPart;
  final String description;
  final String sacredSignificance;
  final String references;

  const ShaktipeethaData({
    required this.title,
    required this.location,
    required this.bodyPart,
    required this.description,
    required this.sacredSignificance,
    required this.references,
  });
}

class ShaktipeethasSection extends StatelessWidget {
  final Function(ShaktipeethaData) onCardTap;

  const ShaktipeethasSection({super.key, required this.onCardTap});

  // FULL ASHTADASHA (18) SHAKTIPEETHA DATA
  static const List<ShaktipeethaData> shaktipeethasList = [
    ShaktipeethaData(
      title: "Sankari Devi",
      location: "Trincomalee, Sri Lanka",
      bodyPart: "ऊरु (Ūru) - Thigh",
      description:
          "The southernmost Shaktipeetha where Goddess Sati's thigh fell. This ancient temple in Sri Lanka is revered as one of the most powerful centers of divine feminine energy.",
      sacredSignificance:
          "Revered by devotees seeking strength, courage, and protection from natural calamities. The divine energy is especially powerful for those facing life's challenges.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Kamakshi Devi",
      location: "Kanchi, Tamil Nadu",
      bodyPart: "अस्थि (Asthi) - Skeleton",
      description:
          "One of the most revered Shaktipeethas where Goddess Sati's skeleton fell. The temple is known for its unique architecture and the powerful Kamakshi Amman deity.",
      sacredSignificance:
          "The seat of learning and wisdom, where devotees seek blessings for knowledge, education, and spiritual enlightenment. Enhances intellectual capabilities and grants academic success.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Shrunkala Devi",
      location: "Praddyumnam, West Bengal",
      bodyPart: "उदर (Udara) - Stomach",
      description:
          "The sacred site where Goddess Sati's stomach fell. This Shaktipeetha is known for its powerful healing energies and is particularly revered for health and well-being.",
      sacredSignificance:
          "Prayers here can cure digestive ailments and bring overall health and vitality. The divine energy is especially powerful for healing physical and mental ailments.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Chamundeshwari Devi",
      location: "Mysore, Karnataka",
      bodyPart: "केश (Keśa) - Hair",
      description:
          "The powerful Shaktipeetha where Goddess Sati's hair fell. This temple is famous for its annual Dasara festival and the majestic Chamundeshwari Hill.",
      sacredSignificance:
          "Grants victory over enemies and obstacles, making it popular for those seeking success and protection. The divine energy is especially powerful for overcoming challenges and achieving goals.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Jogulamba Devi",
      location: "Alampur, Telangana",
      bodyPart: "दन्त (Danta) - Upper Teeth",
      description:
          "The sacred site where Goddess Sati's upper teeth fell. This ancient temple is known for its unique architecture and powerful spiritual vibrations.",
      sacredSignificance:
          "This temple is believed to grant wisdom and eloquence, making it a favored destination for students and scholars.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Bhramaramba Devi",
      location: "Srisailam, Andhra Pradesh",
      bodyPart: "कण्ठ (Kaṇṭha) - Neck",
      description:
          "The powerful Shaktipeetha where Goddess Sati's neck fell. This temple is part of the famous Srisailam temple complex and is deeply revered by devotees.",
      sacredSignificance:
          "This temple is believed to grant protection and strength, particularly for those facing challenges in life.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Mahalakshmi Devi",
      location: "Kolhapur, Maharashtra",
      bodyPart: "वाమనేत्र (Vāmanetra) - Left Eye",
      description:
          "The sacred site where Goddess Sati's left eye fell. This temple is renowned for its wealth-bestowing powers and is one of the most visited Shaktipeethas.",
      sacredSignificance:
          "Believed to grant prosperity, wealth, and abundance, making it a popular destination for business people and those seeking financial success.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Ekaveenika Devi",
      location: "Nanded, Maharashtra",
      bodyPart: "दक्षिणहस्त (Dakṣiṇahasta) - Right Hand",
      description:
          "The sacred site where Goddess Sati's right hand fell. This temple is known for its powerful spiritual energy and is deeply revered by devotees.",
      sacredSignificance:
          "Believed to grant blessings for success in endeavors and protection from negative energies.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Mahakalai Devi",
      location: "Ujjain, Madhya Pradesh",
      bodyPart: "अधर (Adhara) - Upper Lip",
      description:
          "The sacred site where Goddess Sati's upper lip fell. This temple is closely associated with the famous Mahakaleshwar Jyotirlinga and is deeply revered.",
      sacredSignificance:
          "Believed to grant blessings for communication, eloquence, and the power of speech.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Puruhuthika Devi",
      location: "Pithapuram, Andhra Pradesh",
      bodyPart: "वामहस्त (Vāmahasta) - Left Hand",
      description:
          "The sacred site where Goddess Sati's left hand fell. This temple is known for its powerful spiritual vibrations and is deeply revered by devotees.",
      sacredSignificance:
          "Believed to grant blessings for creativity, artistic abilities, and the power of creation.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Girija Devi",
      location: "Cuttack, Odisha",
      bodyPart: "नाभि (Nābhi) - Navel",
      description:
          "The sacred site where Goddess Sati's navel fell. This temple is known for its powerful healing energies and is deeply revered by devotees seeking health and well-being.",
      sacredSignificance:
          "Believed to grant blessings for fertility, childbirth, and overall health and vitality.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Manikyamba Devi",
      location: "Draksharamam, Andhra Pradesh",
      bodyPart: "वामकपोल (Vāmakapola) - Left Cheek",
      description:
          "The sacred site where Goddess Sati's left cheek fell. This temple is known for its beautiful architecture and powerful spiritual energy.",
      sacredSignificance:
          "Believed to grant blessings for beauty, grace, and the power of attraction.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Kamarupa Devi",
      location: "Guwahati, Assam",
      bodyPart: "योनि (Yoni) - Vulva",
      description:
          "The sacred site where Goddess Sati's vulva fell. This temple is one of the most powerful Shaktipeethas and is deeply revered for its spiritual significance.",
      sacredSignificance:
          "Believed to grant blessings for fertility, creation, and the power of life itself.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Madhaveshwari Devi",
      location: "Prayaga, Uttar Pradesh",
      bodyPart: "अङ्गुष्ठ (Aṅguṣṭha) - Great Toe",
      description:
          "The sacred site where Goddess Sati's great toe fell. This temple is located at the confluence of the Ganga, Yamuna, and Saraswati rivers.",
      sacredSignificance:
          "Believed to grant blessings for skill, craftsmanship, and the power of creation through hands.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Jwalamukhi Devi",
      location: "Jwala, Himachal Pradesh",
      bodyPart: "जिह्वा (Jihvā) - Tongue",
      description:
          "The sacred site where Goddess Sati's tongue fell. This temple is famous for its eternal flame that burns without any fuel, symbolizing divine power.",
      sacredSignificance:
          "Believed to grant blessings for wisdom, knowledge, and the power of the mind.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Sarvamangala Devi",
      location: "Gaya, Bihar",
      bodyPart: "स्तन (Stana) - Breast",
      description:
          "The sacred site where Goddess Sati's breast fell. This temple is deeply revered for its nurturing and protective energies.",
      sacredSignificance:
          "Believed to grant blessings for nourishment, protection, and the power of unconditional love.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Vishalakshi Devi",
      location: "Varanasi, Uttar Pradesh",
      bodyPart: "मणिबन्ध (Maṇibandha) - Wrist",
      description:
          "The sacred site where Goddess Sati's wrist fell. This temple is located in the spiritual capital of Bharat and is deeply revered by devotees.",
      sacredSignificance:
          "Believed to grant blessings for spiritual liberation and the power of divine grace.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
    ShaktipeethaData(
      title: "Saraswathi Devi",
      location: "Kashmir",
      bodyPart: "दक्षिणहस्त (Dakṣiṇahasta) - Right Hand",
      description:
          "The sacred site where Goddess Sati's right hand fell. This temple is deeply revered for its association with knowledge and wisdom.",
      sacredSignificance:
          "Believed to grant blessings for learning, wisdom, and the power of knowledge.",
      references: "Devi Bhagavata Purana, Kalika Purana",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shaktipeethasList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            return _ShaktipeethaCard(
              data: shaktipeethasList[index],
              onTap: () => onCardTap(shaktipeethasList[index]),
            );
          },
        ),
      ],
    );
  }
}

class _ShaktipeethaCard extends StatelessWidget {
  final ShaktipeethaData data;
  final VoidCallback onTap;

  const _ShaktipeethaCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glassBg =
        Theme.of(context).extension<GradientExtension>()?.glassBackground ??
        Colors.black26;
    final accentColor = Theme.of(context).colorScheme.primary;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: glassBg,
          borderRadius: BorderRadius.circular(18.sp),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data.title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.5.h),
            _subtitle(context),
            SizedBox(height: 1.h),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.location_on,
                      size: 12.sp,
                      color: accentColor,
                    ),
                  ),
                  WidgetSpan(child: SizedBox(width: 1.w)),
                  TextSpan(
                    text: data.location,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: DarkColors.glowSecondary.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  data.bodyPart,
                  style: TextStyle(
                    color: DarkColors.accentSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: Text(
                data.description,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            Divider(height: 1.5.h, color: textColor.withOpacity(0.5)),
            Row(
              children: [
                Icon(
                  Icons.menu_book,
                  size: 12.sp,
                  color: textColor.withOpacity(0.7),
                ),
                SizedBox(width: 1.5.w),
                Expanded(
                  child: Text(
                    data.references,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                      color: textColor.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _subtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;

    return Center(
      child: Container(
        width: 8.w,
        height: 0.4.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [DarkColors.accentPrimary, DarkColors.accentSecondary],
          ),
        ),
      ),
    );
  }
}
