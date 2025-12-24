import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/stories_details.dart';
import 'package:myitihas/utils/constants.dart';

class StoryGeneratorPage extends StatefulWidget {
  const StoryGeneratorPage({super.key});

  @override
  State<StoryGeneratorPage> createState() => _StoryGeneratorPageState();
}

class _StoryGeneratorPageState extends State<StoryGeneratorPage>
    with SingleTickerProviderStateMixin {
  TextEditingController promptController = TextEditingController();
  bool _isChatStarted = false;
  bool _sidebarOpen = false;
  late AnimationController _sidebarAnimationController;
  late Animation<Offset> _sidebarSlideAnimation;

  List<Map<String, String>> chatHistory = [];

  // Story options data
  Map<String, String> selectedOptions = {
    'storyType': '',
    'theme': '',
    'mainCharacter': '',
    'setting': '',
    'scripture': '',
    'storyLength': 'Medium Length',
    'language': 'English',
  };

  final Map<String, Map<String, dynamic>> storyOptions = {
    'storyType': {
      "types": [
        "Epic Adventure",
        "Moral Tale",
        "Devotional Story",
        "Philosophical Journey",
        "Historical Legend",
        "Folk Tale",
        "Divine Intervention",
        "Warrior Saga",
        "Divine Romance",
        "Creation Myth",
        "Spiritual Transformation",
        "Sacred Quest",
        "Divine Tragedy",
        "Divine Comedy",
        "Mystical Mystery",
        "Legendary Tale",
        "Divine Fable",
        "Divine Parable",
        "Divine Prophecy",
        "Divine Revenge",
        "Divine Sacrifice",
        "Animal Fable",
        "Wisdom Tale",
        "Court Story",
        "Riddle Story",
        "Trickster Tale",
        "Origin Story",
        "Heroic Journey",
        "Redemption Story",
        "Coming of Age",
        "Battle Epic",
      ],
    },
    'theme': {
      "types": [
        "Dharma (Duty)",
        "Karma (Action)",
        "Bhakti (Devotion)",
        "Moksha (Liberation)",
        "Sacrifice & Loyalty",
        "Knowledge & Wisdom",
        "Family & Relationships",
        "Power & Leadership",
        "Spiritual Transformation",
        "Divine Justice",
        "Destiny & Fate",
        "Cosmic Harmony",
        "Sacred Traditions",
        "Divine Redemption",
        "Eternal Truths",
        "Cleverness & Wit",
        "Humility & Pride",
        "Friendship & Trust",
        "Courage & Fear",
        "Greed & Contentment",
        "Truth & Deception",
        "Compassion & Cruelty",
        "Unity & Division",
        "Patience & Haste",
        "Good vs Evil",
        "Inner Peace",
        "Self-Discovery",
        "Forgiveness",
        "Perseverance",
        "Honor & Shame",
      ],
    },
    'mainCharacter': {
      "types": [
        "Divine Being",
        "Sage/Rishi",
        "Warrior/Kshatriya",
        "Royal Family Member",
        "Devoted Seeker",
        "Common Person",
        "Celestial Being",
        "Divine Animal",
        "Asura/Rakshasa",
        "Temple Priest",
        "Mystic/Yogi",
        "Divine Guardian",
        "Spiritual Entity",
        "Elemental Spirit",
        "Mythical Creature",
        "Divine Avatar",
        "Goddess/Devi",
        "Demoness/Rakshasi",
        "Epic Hero",
        "Epic Villain",
        "Divine Mentor",
        "Clever Courtier",
        "Wise Minister",
        "Merchant/Trader",
        "Farmer/Villager",
        "Student/Disciple",
        "Forest Hermit",
        "Traveling Bard",
        "Royal Guard",
        "Palace Servant",
        "Clever Child",
        "Elderly Wise Person",
        "Talking Animal",
        "Magical Being",
        "Ghost/Spirit",
      ],
    },
    'setting': {
      "types": [
        "Sacred Forest",
        "Ancient Kingdom",
        "Sage's Ashram",
        "Epic Battlefield",
        "Celestial Realm",
        "Holy Pilgrimage Site",
        "Ancient Village",
        "Royal Palace",
        "Sacred Mountain",
        "Holy River",
        "Ancient Temple",
        "Mystical Cave",
        "Sacred Island",
        "Spiritual Desert",
        "Royal Court",
        "Marketplace",
        "Gurukul School",
        "Monastery",
        "Ancient Library",
        "Enchanted Garden",
        "Riverside Ghat",
        "Mountain Pass",
        "Desert Oasis",
        "Jungle Clearing",
        "Ancient City",
        "Hermit's Hut",
        "Palace Gardens",
        "Village Square",
        "Sacred Grove",
        "Crossroads",
        "Ancient Ruins",
        "Magical Realm",
        "Underwater Kingdom",
        "Sky Palace",
      ],
    },
    'scripture': {
      "types": [
        'Epics (Itihasa)',
        'Core Scriptures (Shruti)',
        'Mahāpurāṇas (Smriti)',
        'Upapurāṇas',
        'Wisdom & Other Tales',
      ],
      "subtypes": {
        'Epics (Itihasa)': ['Ramayana', 'Mahabharata', 'Ramcharitmanas'],
        'Core Scriptures (Shruti)': ['Vedas', 'Upanishads', 'Ramcharitmanas'],
        'Mahāpurāṇas (Smriti)': [
          'Brahma Purāṇa',
          'Padma Purāṇa',
          'Viṣṇu Purāṇa',
          'Śiva Purāṇa',
          'Bhāgavata Purāṇa',
          'Nārada Purāṇa',
          'Mārkaṇḍeya Purāṇa',
          'Agni Purāṇa',
          'Bhaviṣya Purāṇa',
          'Brahma Vaivarta Purāṇa',
          'Liṅga Purāṇa',
          'Varāha Purāṇa',
          'Skanda Purāṇa',
          'Vāmana Purāṇa',
          'Kūrma Purāṇa',
          'Matsya Purāṇa',
          'Garuda Purāṇa',
          'Brahmāṇḍa Purāṇa',
          'Sanatkumāra Purāṇa',
        ],
        'Upapurāṇas': [
          'Narasimha Purāṇa',
          'Nandī Purāṇa',
          'Śiva Rahasya Purāṇa',
          'Durvāsā Purāṇa',
          'Kapila Purāṇa',
          'Vāmana Purāṇa',
          'Bhārata Purāṇa',
          'Sāmba Purāṇa',
          'Saurapurāṇa',
          'Āditya Purāṇa',
          'Maheshwara Purāṇa',
          'Kalki Purāṇa',
          'Mahābhāgavata Purāṇa',
          'Taraṇi Purāṇa',
          'Vishnudharmottara Purāṇa',
          'Bṛhaddharma Purāṇa',
          'Devī Bhāgavata Purāṇa',
        ],
        'Wisdom & Other Tales': [
          'Panchatantra',
          'Hitopadesha',
          'Jataka Tales',
          'Vikram Betal',
          'Tenali Rama',
          'Amar Chitra Katha',
          'Local Temple Narratives',
        ],
      },
    },
  };

  List<bool> selectedMode = [true, false];

  @override
  void initState() {
    super.initState();
    _sidebarAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _sidebarSlideAnimation =
        Tween<Offset>(begin: Offset(-10, 0), end: Offset(0, 0)).animate(
          CurvedAnimation(
            parent: _sidebarAnimationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    promptController.dispose();
    _sidebarAnimationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _sidebarOpen = !_sidebarOpen;
      if (_sidebarOpen) {
        _sidebarAnimationController.forward();
      } else {
        _sidebarAnimationController.reverse();
      }
    });
  }

  void _sendMessage() {
    if (promptController.text.isEmpty) return;

    setState(() {
      if (!_isChatStarted) {
        _isChatStarted = true;
      }

      chatHistory.add({'type': 'user', 'message': promptController.text});

      // Simulate bot response
      Future.delayed(Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            chatHistory.add({
              'type': 'bot',
              'message':
                  'Generating your mythological story with the selected options...',
            });
          });
        }
      });

      promptController.clear();
    });
  }

  void _randomizeAll() {
    setState(() {
      final random = DateTime.now().millisecond;
      selectedOptions['storyType'] =
          storyOptions['storyType']!["types"]![random % 4];
      selectedOptions['theme'] = storyOptions['theme']!["types"]![random % 4];
      selectedOptions['mainCharacter'] =
          storyOptions['mainCharacter']!["types"]![random % 4];
      selectedOptions['setting'] =
          storyOptions['setting']!["types"]![random % 4];
      selectedOptions['scripture'] =
          storyOptions['scripture']!["types"]![random % 5];
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Container(
      padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.005),
      height: height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _isChatStarted
                    ? _buildChatView()
                    : Stack(
                        children: [
                          Positioned(child: _buildWelcomeView()),
                          // Positioned(
                          //   left: 0,
                          //   child: Container(
                          //     color: Colors.transparent,
                          //     child: Row(
                          //       children: [
                          //         GestureDetector(
                          //           onTap: _toggleSidebar,
                          //           child: Container(
                          //             padding: EdgeInsets.all(8),
                          //             decoration: BoxDecoration(
                          //               color:
                          //                   isDark
                          //                       ? DarkColors.glassBg
                          //                       : LightColors.glassBg,
                          //               border: Border.all(
                          //                 color:
                          //                     isDark
                          //                         ? DarkColors.glassBorder
                          //                         : LightColors.glassBorder,
                          //               ),
                          //               borderRadius: BorderRadius.circular(12),
                          //             ),
                          //             child: Icon(
                          //               Icons.menu_rounded,
                          //               color: Theme.of(context).primaryColor,
                          //               size: aspectRatio > 0.5 ? 24 : 20,
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            right: 0,
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? DarkColors.glassBg
                                            : LightColors.glassBg,
                                        border: Border.all(
                                          color: isDark
                                              ? DarkColors.glassBorder
                                              : LightColors.glassBorder,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.history_rounded,
                                        color: Theme.of(context).primaryColor,
                                        size: aspectRatio > 0.5 ? 24 : 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeView() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Column(
      children: [
        SizedBox(height: height * 0.05),
        Container(
          width: aspectRatio > 0.5 ? 80 : 70,
          height: aspectRatio > 0.5 ? 80 : 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isDark
                ? LinearGradient(
                    colors: [
                      Color(0xFF38BDF8).withAlpha(200),
                      Color(0xFFA78BFA).withAlpha(200),
                    ],
                  )
                : LinearGradient(
                    colors: [
                      Color(0xFF3B82F6).withAlpha(200),
                      Color(0xFF8B5CF6).withAlpha(200),
                    ],
                  ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(100),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            Icons.auto_stories_rounded,
            color: Colors.white,
            size: aspectRatio > 0.5 ? 40 : 36,
          ),
        ),
        SizedBox(height: aspectRatio > 0.5 ? 24 : 20),
        Text(
          'Story Generator',
          style: GoogleFonts.inter(
            fontSize: aspectRatio > 0.5 ? 24 : 22,
            fontWeight: FontWeight.w700,
            color: isDark ? DarkColors.textPrimary : LightColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: aspectRatio > 0.5 ? 12 : 10),
        Text(
          'Create your own mythological stories with AI',
          style: GoogleFonts.inter(
            fontSize: aspectRatio > 0.5 ? 14 : 13,
            fontWeight: FontWeight.w400,
            color: isDark
                ? DarkColors.textSecondary
                : LightColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Powered by ancient wisdom and modern technology',
          style: GoogleFonts.inter(
            fontSize: aspectRatio > 0.5 ? 14 : 13,
            fontWeight: FontWeight.w400,
            color: isDark
                ? DarkColors.textSecondary.withAlpha(150)
                : LightColors.textSecondary.withAlpha(150),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: aspectRatio > 0.5 ? 43 : 35),
        _buildModeToggle(isDark),
        SizedBox(height: height * 0.015),
        if (selectedMode[0] == true)
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(aspectRatio > 0.5 ? 15 : 8),
                decoration: BoxDecoration(
                  color: isDark ? DarkColors.glassBg : LightColors.glassBg,
                  border: Border.all(
                    color: isDark
                        ? DarkColors.glassBorder
                        : LightColors.glassBorder,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "https://myitihas.com/img/ramayan-1.png",
                        height: height * 0.2,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "The Bundle of Unity",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? DarkColors.textPrimary
                            : LightColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      "Tenali Rama - The Bundle of Sticks Parable",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? DarkColors.textSecondary
                            : LightColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      "Unity creates unbreakable strength while division leads to vulnerability; a kingdom's true power lies in its people's harmony.",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? DarkColors.textPrimary
                            : LightColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                  ],
                ),
              ),
              SizedBox(height: height * 0.015),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(aspectRatio > 0.5 ? 15 : 8),
                decoration: BoxDecoration(
                  color: isDark ? DarkColors.glassBg : LightColors.glassBg,
                  border: Border.all(
                    color: isDark
                        ? DarkColors.glassBorder
                        : LightColors.glassBorder,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "https://myitihas.com/img/ramayan-1.png",
                        height: height * 0.2,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "The Bundle of Unity",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? DarkColors.textPrimary
                            : LightColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      "Tenali Rama - The Bundle of Sticks Parable",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? DarkColors.textSecondary
                            : LightColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      "Unity creates unbreakable strength while division leads to vulnerability; a kingdom's true power lies in its people's harmony.",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? DarkColors.textPrimary
                            : LightColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                  ],
                ),
              ),
            ],
          ),

        if (selectedMode[1] == true)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(aspectRatio > 0.5 ? 20 : 16),
            decoration: BoxDecoration(
              color: isDark ? DarkColors.glassBg : LightColors.glassBg,
              border: Border.all(
                color: isDark
                    ? DarkColors.glassBorder
                    : LightColors.glassBorder,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customize Your Story',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? DarkColors.textPrimary
                        : LightColors.textPrimary,
                  ),
                ),
                SizedBox(height: aspectRatio > 0.5 ? 16 : 12),
                _buildOptionSelector(
                  context,
                  'Story Type',
                  'storyType',
                  isDark,
                ),
                SizedBox(height: aspectRatio > 0.5 ? 12 : 10),
                _buildOptionSelector(context, 'Theme', 'theme', isDark),
                SizedBox(height: aspectRatio > 0.5 ? 12 : 10),
                _buildOptionSelector(
                  context,
                  'Main Character',
                  'mainCharacter',
                  isDark,
                ),
                SizedBox(height: aspectRatio > 0.5 ? 12 : 10),
                _buildOptionSelector(context, 'Setting', 'setting', isDark),
                SizedBox(height: aspectRatio > 0.5 ? 12 : 10),
                _buildOptionSelector(context, 'Scripture', 'scripture', isDark),
                SizedBox(height: aspectRatio > 0.5 ? 16 : 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: width * 0.4,
                        padding: EdgeInsets.symmetric(
                          vertical: aspectRatio > 0.5 ? 14 : 12,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? DarkColors.accentPrimary.withAlpha(50)
                              : LightColors.accentPrimary.withAlpha(50),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.clear_all_rounded,
                              color: isDark
                                  ? DarkColors.textPrimary
                                  : LightColors.textPrimary,
                              size: 18,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Clear all',
                              style: GoogleFonts.inter(
                                fontSize: aspectRatio > 0.5 ? 16 : 14,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? DarkColors.textPrimary
                                    : LightColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _randomizeAll,
                      child: Container(
                        width: width * 0.4,
                        // width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: aspectRatio > 0.5 ? 14 : 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: isDark
                              ? DarkColors.messageUserGradient
                              : LightColors.messageUserGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.casino_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Randomize all',
                              style: GoogleFonts.inter(
                                fontSize: aspectRatio > 0.5 ? 16 : 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (selectedMode[1] == true) SizedBox(height: height * 0.015),
        if (selectedMode[1] == true) _buildInputField(),
        SizedBox(height: height * 0.12),
      ],
    );
  }

  Widget _buildOptionSelector(
    BuildContext context,
    String label,
    String key,
    bool isDark,
  ) {
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    String value = selectedOptions[key] ?? 'Select...';
    return GestureDetector(
      onTap: () => _showOptionDialog(context, label, key, isDark),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: aspectRatio > 0.5 ? 13 : 12,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? DarkColors.textSecondary
                    : LightColors.textSecondary,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: aspectRatio > 0.5 ? 13 : 12,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? DarkColors.accentPrimary
                        : LightColors.accentPrimary,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: isDark
                      ? DarkColors.accentPrimary
                      : LightColors.accentPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionDialog(
    BuildContext context,
    String label,
    String key,
    bool isDark,
  ) {
    final height = MediaQuery.of(context).size.height;
    final List<String> options = storyOptions[key]?["types"];
    showDialog(
      context: context,
      builder: (context) {
        double aspectRatio = MediaQuery.of(context).size.aspectRatio;
        return Dialog(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.9,
            minHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? DarkColors.textPrimary
                            : LightColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: aspectRatio * 30,
                      crossAxisSpacing: aspectRatio * 30,
                    ),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      String option = options[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOptions[key] = option;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: (selectedOptions[key] == option)
                                ? (isDark
                                      ? DarkColors.accentPrimary.withOpacity(
                                          0.15,
                                        )
                                      : LightColors.accentPrimary.withOpacity(
                                          0.15,
                                        ))
                                : (isDark
                                      ? DarkColors.glassBg
                                      : LightColors.glassBg),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: (selectedOptions[key] == option)
                                  ? (isDark
                                        ? DarkColors.accentPrimary
                                        : LightColors.accentPrimary)
                                  : (isDark
                                        ? DarkColors.glassBorder
                                        : LightColors.glassBorder),
                              width: 1.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                _getOptionImage(option, key),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: height * 0.05,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: isDark
                                          ? LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                DarkColors.messageUserBgStart
                                                    .withAlpha(0),
                                                DarkColors.messageUserBgStart
                                                    .withAlpha(50),
                                                DarkColors.messageUserBgEnd
                                                    .withAlpha(100),
                                              ],
                                            )
                                          : LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                LightColors.messageUserBgStart
                                                    .withAlpha(0),
                                                LightColors.messageUserBgStart
                                                    .withAlpha(50),
                                                LightColors.messageUserBgEnd
                                                    .withAlpha(100),
                                              ],
                                            ),
                                    ),
                                    child: Text(
                                      option,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getOptionImage(String option, String key) {
    String image = option.replaceAll(' ', '_');
    image = '$image.png';
    String imageUrl =
        "https://raw.githubusercontent.com/dev-community-dev/MyItihas-StaticDB/main/storyOptions/story_types/${image}";
    return imageUrl.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,

              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              errorWidget: (context, error, stackTrace) =>
                  Icon(Icons.image_rounded, size: 25),
            ),
          )
        : Icon(Icons.image, size: 40);
  }

  Widget _buildOptionPreview(String label, String value, bool isDark) {
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: aspectRatio > 0.5 ? 13 : 12,
            fontWeight: FontWeight.w500,
            color: isDark
                ? DarkColors.textSecondary
                : LightColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: aspectRatio > 0.5 ? 13 : 12,
            fontWeight: FontWeight.w600,
            color: isDark
                ? DarkColors.accentPrimary
                : LightColors.accentPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildChatView() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    // String prompt = promptController.text;
    String title = "The Bundle of Unity";
    String message = '''
                    The golden halls of Vijayanagara's royal court shimmered under the afternoon sun as King Krishnadevaraya observed his ministers with growing concern. The usual harmonious atmosphere had fractured into hostile factions - Brahmin pundits whispered against Kshatriya warriors, merchants eyed farmers with suspicion, and veteran ministers resented younger advisors. The air crackled with tension as council members exchanged barbed comments during discussions of state affairs.

                    "Your Majesty," began Minister Lakshmanacharya, his silk angavastram trembling with indignation, "these new tax proposals show utter disregard for temple lands!" Before the king could respond, Commander Thimmarasu slammed his armored hand on the marble floor. "While priests debate taxes, invaders gather at our borders! Military spending must take precedence!" The council descended into chaotic arguments until the king's silver scepter struck the lion-headed armrest, the resonant clang silencing the hall.

                    Amidst this discord, the court jester-poet Tenali Ramakrishna remained conspicuously absent. For three days, his customary place near the king's ivory throne stood empty, his sharp wit noticeably missing from court proceedings. When concerned messengers reported Tenali bedridden with mysterious illness, the king himself decided to visit his clever courtier. The royal palanquin wound through Vijaynagara's bustling streets, fragrant with jasmine garlands and the earthy scent of turmeric being ground in market stalls.

                    They found Tenali reclining on a simple bamboo cot, surrounded by ancient palm-leaf manuscripts. His usually bright eyes appeared dimmed, though a ghost of his characteristic smile played on his lips as he bowed weakly. "A thousand pardons, My Lord," he murmured, "this humble servant couldn't attend court..." The king knelt beside him, genuine concern softening his regal bearing. "Your absence leaves our court divided, Tenali. Ministers bicker like fishwives while the kingdom needs unity!"

                    Tenali's fingers trembled as he gestured toward a bundle of sticks bound with golden thread near his bedside. "Great King... if you truly wish to heal divisions... have your ministers break this bundle." Puzzled but trusting his wisest advisor, Krishnadevaraya carried the mysterious offering back to court. The next morning, he placed the bundle before his quarreling council. "The one who breaks this shall receive a bag of rubies!" he proclaimed.

                    Strong Commander Thimmarasu stepped forward first, his muscular arms straining until veins protruded like blue rivers. The bundle remained intact. Learned Lakshmanacharya tried incantations from ancient texts, to no avail. Young Minister Appaji attempted clever engineering tricks, yet the bundle held firm. Even combined efforts failed as the sticks reinforced each other. Finally, the king himself severed the golden thread with his dagger - the sticks scattering effortlessly when separated.

                    A profound silence fell over the council hall as understanding dawned. Tenali entered, no longer appearing frail, his eyes sparkling with wisdom. "Your Majesty," he declared, "Like these sticks bound together, our kingdom stands strong through unity. But let division creep in..." He kicked the scattered sticks across the polished floor. "Even children could break us one by one." The ministers stared at the symbolic sticks, their recent quarrels suddenly seeming petty.

                    Krishnadevaraya rose from his pearl-inlaid throne, his voice echoing through the pillared hall. "Let this be our lesson! When Brahmins protect warriors, warriors defend farmers, and farmers feed scholars - only then does Vijayanagara become invincible!" The ministers bowed in unison, their earlier animosities dissolved in shared realization. From that day, whenever disputes arose, the king would quietly place a single stick before the arguers - a silent reminder that soon brought smiles and compromise.
                    ''';
    String imageUrl = 'https://myitihas.com/img/ramayan-1.png';
    String reference = 'Tenali Rama - The Bundle of Sticks Parable';
    String learnings =
        "Unity creates unbreakable strength while division leads to vulnerability; a kingdom's true power lies in its people's harmony.";
    List<String> aboutStory = [
      "📖 Characters found in this story: Arjuna, Krishna",
      "💡 You can select any character above to learn more about them from the scriptures!",
      "🎉 Story generated successfully! 'The Divine Song Unveiled' is ready to read. Enjoy your personalized tale!",
    ];
    String llmResponse = "";
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.08,
                decoration: BoxDecoration(
                  color: isDark ? DarkColors.glassBg : LightColors.glassBg,
                  border: Border.all(
                    color: isDark
                        ? DarkColors.glassBorder
                        : LightColors.glassBorder,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: aspectRatio > 0.5 ? 20 : 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: aspectRatio > 0.5 ? 20 : 18,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? DarkColors.textPrimary
                            : LightColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryDetailsView(
                              storyData: {
                                'title': title,
                                'scripture':
                                    'Tenali Rama - The Bundle of Sticks Parable',
                                'imageUrl': imageUrl,
                                'learning': learnings,
                                'message': message,
                                'reference': reference,
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Theme.of(
                              context,
                            ).secondaryHeaderColor.withAlpha(50),
                          ),
                        ),
                        child: Icon(
                          Icons.fullscreen_rounded,
                          color: Theme.of(context).secondaryHeaderColor,
                          size: aspectRatio > 0.5 ? 24 : 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: chatHistory.map((chat) {
                  final isUser = chat['type'] == 'user';
                  return Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: width * 0.8),
                        margin: EdgeInsets.symmetric(
                          vertical: aspectRatio > 0.5 ? 10 : 8,
                        ),
                        padding: EdgeInsets.all(aspectRatio > 0.5 ? 13 : 8),
                        decoration: BoxDecoration(
                          gradient: isUser
                              ? (isDark
                                    ? DarkColors.messageUserGradient
                                    : LightColors.messageUserGradient)
                              : (isDark
                                    ? LinearGradient(
                                        colors: [
                                          DarkColors.glassBg,
                                          DarkColors.glassBg,
                                        ],
                                      )
                                    : LinearGradient(
                                        colors: [
                                          LightColors.glassBg,
                                          LightColors.glassBg,
                                        ],
                                      )),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (
                              int i = 0;
                              i < aboutStory.length && !isUser;
                              i++
                            )
                              Text(
                                aboutStory[i],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                  fontSize: aspectRatio > 0.5 ? 16 : 14,
                                  fontWeight: FontWeight.w500,
                                  color: (isDark
                                      ? DarkColors.textPrimary
                                      : LightColors.textPrimary),
                                ),
                              ),
                            isUser
                                ? Text(
                                    chat['message']?.trim() ?? '',
                                    style: GoogleFonts.inter(
                                      fontSize: aspectRatio > 0.5 ? 16 : 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                            llmResponse.trim() != ""
                                ? Text(
                                    chat['message']?.trim() ?? '',
                                    style: GoogleFonts.inter(
                                      fontSize: aspectRatio > 0.5 ? 16 : 14,
                                      fontWeight: FontWeight.w500,
                                      color: isUser
                                          ? Colors.white
                                          : (isDark
                                                ? DarkColors.textPrimary
                                                : LightColors.textPrimary),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        _buildInputField(),
      ],
    );
  }

  Widget _buildSelectedOptionsPills() {
    // bool isDark = Theme.of(context).brightness == Brightness.dark;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    // Filter out internal keys if any, or just display specifics
    final displayKeys = [
      'storyType',
      'theme',
      'mainCharacter',
      'setting',
      'scripture',
      'storyLength',
    ];

    return Container(
      height: aspectRatio > 0.5 ? 40 : 32,
      margin: EdgeInsets.only(bottom: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: displayKeys.map((key) {
          final value = selectedOptions[key];
          if (value == null || value.isEmpty) return Container();

          Color pillColor;
          String label = "$key: $value";

          // Custom formatting for display
          switch (key) {
            case 'storyType':
              label = "STORY TYPE: $value";
              pillColor = Color(0xFF3B82F6);
              break;
            case 'theme':
              label = "THEME: $value";
              pillColor = Color(0xFFA855F7);
              break;
            case 'mainCharacter':
              label = "MAIN CHARACTER: $value";
              pillColor = Color(0xFFEC4899);
              break;
            case 'setting':
              label = "SETTING: $value";
              pillColor = Color(0xFF10B981);
              break;
            case 'scripture':
              label = "SCRIPTURE: $value";
              pillColor = Color(0xFFF59E0B);
              break;
            case 'storyLength':
              label = "STORY LENGTH: $value";
              pillColor = Color(0xFFEF4444);
              break;
            default:
              label = value;
              pillColor = Colors.grey;
          }

          return Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: pillColor.withOpacity(0.2),
              border: Border.all(color: pillColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: aspectRatio > 0.5 ? 10 : 9,
                    fontWeight: FontWeight.w600,
                    color: pillColor,
                  ),
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    // Functionality to remove option could be added here
                  },
                  child: Icon(Icons.close, size: 12, color: pillColor),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInputField() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? DarkColors.inputBg : LightColors.inputBg,
        border: Border.all(
          color: isDark ? DarkColors.glassBorder : LightColors.glassBorder,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: aspectRatio > 0.5 ? 18 : 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: promptController,
              style: GoogleFonts.inter(
                fontSize: aspectRatio > 0.5 ? 18 : 16,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? DarkColors.textPrimary
                    : LightColors.textPrimary,
              ),
              maxLines: null,
              decoration: InputDecoration(
                hintText: _isChatStarted
                    ? 'Continue your story...'
                    : 'Enter your story prompt',
                hintStyle: GoogleFonts.inter(
                  fontSize: aspectRatio > 0.5 ? 16 : 14,
                  fontWeight: FontWeight.w400,
                  color: isDark
                      ? DarkColors.textSecondary
                      : LightColors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onSubmitted: (value) {
                _sendMessage();
              },
            ),
          ),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).secondaryHeaderColor.withAlpha(50),
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mic_rounded,
                color: Theme.of(context).secondaryHeaderColor,
                size: aspectRatio > 0.5 ? 24 : 20,
              ),
            ),
          ),
          SizedBox(width: aspectRatio > 0.5 ? 8 : 5),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).secondaryHeaderColor.withAlpha(50),
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.attach_file_rounded,
                color: Theme.of(context).secondaryHeaderColor,
                size: aspectRatio > 0.5 ? 24 : 20,
              ),
            ),
          ),
          SizedBox(width: aspectRatio > 0.5 ? 8 : 5),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: isDark
                    ? DarkColors.messageUserGradient
                    : LightColors.messageUserGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: aspectRatio > 0.5 ? 24 : 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeToggle(bool isDark) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isDark ? DarkColors.glassBg : LightColors.glassBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark ? DarkColors.glassBorder : LightColors.glassBorder,
          width: 1,
        ),
      ),
      child: ToggleButtons(
        isSelected: selectedMode,
        onPressed: (index) {
          setState(() {
            for (int i = 0; i < selectedMode.length; i++) {
              selectedMode[i] = i == index;
            }
          });
        },
        borderRadius: BorderRadius.circular(13),
        borderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        fillColor: isDark
            ? DarkColors.accentPrimary.withOpacity(0.15)
            : LightColors.accentPrimary.withOpacity(0.15),
        color: isDark ? DarkColors.textSecondary : LightColors.textSecondary,
        selectedColor: isDark
            ? DarkColors.accentPrimary
            : LightColors.accentPrimary,
        constraints: BoxConstraints(
          minWidth: (MediaQuery.of(context).size.width - 30) / 2,
        ),
        children: [
          _ModeItem(
            icon: Icons.touch_app_rounded,
            label: 'Interactive',
            height: height,
          ),
          _ModeItem(
            icon: Icons.code_rounded,
            label: 'Raw Prompt',
            height: height,
          ),
        ],
      ),
    );
  }

  Widget buildAdvancedOption(String label, bool isDark) {
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    final List<String> options = label == 'Story Length'
        ? ["Brief Tale", "Medium Length", "Extended Narrative", "Epic Length"]
        : [
            "English",
            "Hindi",
            "Telugu",
            "Tamil",
            "Kannada",
            "Malayalam",
            "Bengali",
            "Gujarati",
            "Marathi",
            "Punjabi",
            "Odia",
            "Assamese",
            "Nepali",
            "Sanskrit",
            "Urdu",
            "Bhojpuri",
            "Kashmiri",
            "Konkani",
            "Manipuri",
            "Santali",
            "Dogri",
            "Maithili",
          ];

    final String currentValue = label == 'Story Length'
        ? selectedOptions['storyLength'] ?? 'Medium Length'
        : selectedOptions['language'] ?? 'English';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: aspectRatio > 0.5 ? 13 : 12,
            fontWeight: FontWeight.w500,
            color: isDark
                ? DarkColors.textSecondary
                : LightColors.textSecondary,
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (val) {
            setState(() {
              if (label == 'Story Length') {
                selectedOptions['storyLength'] = val;
              } else {
                selectedOptions['language'] = val;
              }
            });
          },
          itemBuilder: (context) => options
              .map((o) => PopupMenuItem<String>(value: o, child: Text(o)))
              .toList(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: aspectRatio > 0.5 ? 8 : 6,
              vertical: aspectRatio > 0.5 ? 4 : 3,
            ),
            decoration: BoxDecoration(
              color: isDark ? DarkColors.inputBg : LightColors.inputBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? DarkColors.glassBorder
                    : LightColors.glassBorder,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentValue,
                  style: GoogleFonts.inter(
                    fontSize: aspectRatio > 0.5 ? 14 : 12,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? DarkColors.textPrimary
                        : LightColors.textPrimary,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: aspectRatio > 0.5 ? 20 : 18,
                  color: isDark
                      ? DarkColors.textSecondary
                      : LightColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ModeItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double height;

  const _ModeItem({
    required this.icon,
    required this.label,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.005),
        Icon(icon, size: 20),
        SizedBox(height: height * 0.005),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: height * 0.005),
      ],
    );
  }
}
