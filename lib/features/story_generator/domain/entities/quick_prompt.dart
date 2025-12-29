import 'package:flutter/material.dart';
import 'story_prompt.dart';

/// Represents a pre-defined quick prompt for the carousel
class QuickPrompt {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final StoryPrompt presetOptions;
  final List<Color> gradientColors;

  const QuickPrompt({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.presetOptions,
    required this.gradientColors,
  });

  /// Hardcoded list of quick prompts for the carousel
  static List<QuickPrompt> get defaultPrompts => [
    QuickPrompt(
      id: 'warrior_quest',
      title: "A Warrior's Quest",
      subtitle: 'Epic adventure from Mahabharata',
      icon: Icons.shield,
      gradientColors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
      presetOptions: const StoryPrompt(
        scripture: 'Mahabharata',
        storyType: 'Epic Adventure',
        theme: 'Dharma (Duty)',
        mainCharacter: 'Warrior/Kshatriya',
        setting: 'Epic Battlefield',
      ),
    ),
    QuickPrompt(
      id: 'krishna_wisdom',
      title: "Krishna's Wisdom",
      subtitle: 'Divine teachings and philosophy',
      icon: Icons.auto_awesome,
      gradientColors: [const Color(0xFF11998e), const Color(0xFF38ef7d)],
      presetOptions: const StoryPrompt(
        scripture: 'Bhāgavata Purāṇa',
        storyType: 'Philosophical Journey',
        theme: 'Knowledge & Wisdom',
        mainCharacter: 'Divine Being',
        setting: 'Royal Palace',
      ),
    ),
    QuickPrompt(
      id: 'sage_journey',
      title: "A Sage's Journey",
      subtitle: 'Spiritual transformation story',
      icon: Icons.self_improvement,
      gradientColors: [const Color(0xFFf093fb), const Color(0xFFf5576c)],
      presetOptions: const StoryPrompt(
        scripture: 'Upanishads',
        storyType: 'Spiritual Transformation',
        theme: 'Moksha (Liberation)',
        mainCharacter: 'Sage/Rishi',
        setting: "Sage's Ashram",
      ),
    ),
    QuickPrompt(
      id: 'rama_devotion',
      title: "Path of Devotion",
      subtitle: 'Devotional tale from Ramayana',
      icon: Icons.favorite,
      gradientColors: [const Color(0xFFff9a9e), const Color(0xFFfecfef)],
      presetOptions: const StoryPrompt(
        scripture: 'Ramayana',
        storyType: 'Devotional Story',
        theme: 'Bhakti (Devotion)',
        mainCharacter: 'Devoted Seeker',
        setting: 'Sacred Forest',
      ),
    ),
    QuickPrompt(
      id: 'animal_wisdom',
      title: "Tales of Wisdom",
      subtitle: 'Clever stories from Panchatantra',
      icon: Icons.pets,
      gradientColors: [const Color(0xFFa8edea), const Color(0xFFfed6e3)],
      presetOptions: const StoryPrompt(
        scripture: 'Panchatantra',
        storyType: 'Animal Fable',
        theme: 'Cleverness & Wit',
        mainCharacter: 'Talking Animal',
        setting: 'Sacred Forest',
      ),
    ),
    QuickPrompt(
      id: 'divine_legend',
      title: "Divine Legend",
      subtitle: 'Cosmic tales of creation',
      icon: Icons.blur_on,
      gradientColors: [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
      presetOptions: const StoryPrompt(
        scripture: 'Brahma Purāṇa',
        storyType: 'Creation Myth',
        theme: 'Cosmic Harmony',
        mainCharacter: 'Divine Being',
        setting: 'Celestial Realm',
      ),
    ),
  ];
}
