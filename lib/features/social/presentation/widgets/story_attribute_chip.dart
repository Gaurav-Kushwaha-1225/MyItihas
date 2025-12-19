import 'package:flutter/material.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';

class StoryAttributeChip extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String label;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool darkOverlay;

  const StoryAttributeChip({
    super.key,
    this.icon,
    this.emoji,
    required this.label,
    this.backgroundColor,
    this.onTap,
    this.darkOverlay = false,
  }) : assert(
         icon != null || emoji != null,
         'Either icon or emoji must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradients = theme.extension<GradientExtension>();
    final colorScheme = theme.colorScheme;

    return Semantics(
      label: label,
      button: onTap != null,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color:
                  backgroundColor ??
                  (darkOverlay
                      ? Colors.white.withValues(alpha: 0.15)
                      : colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.8,
                        )),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: darkOverlay
                    ? Colors.white.withValues(alpha: 0.3)
                    : (gradients?.glassBorder ?? colorScheme.outline),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (emoji != null) ...[
                  Text(emoji!, style: const TextStyle(fontSize: 11)),
                  const SizedBox(width: 3),
                ] else if (icon != null) ...[
                  Icon(
                    icon,
                    size: 11,
                    color: darkOverlay ? Colors.white : colorScheme.primary,
                  ),
                  const SizedBox(width: 3),
                ],
                Flexible(
                  child: Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: darkOverlay ? Colors.white : colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  factory StoryAttributeChip.scripture(
    String scripture, {
    VoidCallback? onTap,
    bool darkOverlay = false,
  }) {
    return StoryAttributeChip(
      emoji: '📜',
      label: scripture,
      onTap: onTap,
      darkOverlay: darkOverlay,
    );
  }

  factory StoryAttributeChip.theme(
    String theme, {
    VoidCallback? onTap,
    bool darkOverlay = false,
  }) {
    return StoryAttributeChip(
      emoji: _getThemeEmoji(theme),
      label: theme,
      onTap: onTap,
      darkOverlay: darkOverlay,
    );
  }

  factory StoryAttributeChip.emotionalTone(
    String tone, {
    VoidCallback? onTap,
    bool darkOverlay = false,
  }) {
    return StoryAttributeChip(
      emoji: _getToneEmoji(tone),
      label: tone,
      onTap: onTap,
      darkOverlay: darkOverlay,
    );
  }

  factory StoryAttributeChip.storyType(
    String type, {
    VoidCallback? onTap,
    bool darkOverlay = false,
  }) {
    return StoryAttributeChip(
      emoji: _getTypeEmoji(type),
      label: type,
      onTap: onTap,
      darkOverlay: darkOverlay,
    );
  }

  factory StoryAttributeChip.timeEra(
    String era, {
    VoidCallback? onTap,
    bool darkOverlay = false,
  }) {
    return StoryAttributeChip(
      emoji: '🕐',
      label: era,
      onTap: onTap,
      darkOverlay: darkOverlay,
    );
  }

  static String _getThemeEmoji(String theme) {
    final lower = theme.toLowerCase();
    if (lower.contains('war') || lower.contains('battle')) return '⚔️';
    if (lower.contains('love') || lower.contains('romance')) return '❤️';
    if (lower.contains('dharma') || lower.contains('duty')) return '⚖️';
    if (lower.contains('spiritual') || lower.contains('divine')) return '🕉️';
    if (lower.contains('wisdom') || lower.contains('knowledge')) return '📚';
    if (lower.contains('sacrifice')) return '🔥';
    if (lower.contains('hero') || lower.contains('courage')) return '🦁';
    if (lower.contains('family')) return '👨‍👩‍👧‍👦';
    if (lower.contains('justice')) return '⚖️';
    if (lower.contains('nature')) return '🌳';
    return '✨';
  }

  static String _getToneEmoji(String tone) {
    final lower = tone.toLowerCase();
    if (lower.contains('epic') || lower.contains('heroic')) return '🏆';
    if (lower.contains('tragic') || lower.contains('sad')) return '😢';
    if (lower.contains('inspirational') || lower.contains('uplifting')) {
      return '🌟';
    }
    if (lower.contains('mysterious')) return '🔮';
    if (lower.contains('peaceful') || lower.contains('serene')) return '🕊️';
    if (lower.contains('dramatic')) return '🎭';
    if (lower.contains('adventurous')) return '⛰️';
    if (lower.contains('humorous') || lower.contains('funny')) return '😄';
    if (lower.contains('devotional')) return '🙏';
    return '💫';
  }

  static String _getTypeEmoji(String type) {
    final lower = type.toLowerCase();
    if (lower.contains('mythology')) return '🏛️';
    if (lower.contains('legend')) return '📖';
    if (lower.contains('epic')) return '⚔️';
    if (lower.contains('fable') || lower.contains('parable')) return '🦊';
    if (lower.contains('historical')) return '📜';
    if (lower.contains('philosophical')) return '🧘';
    if (lower.contains('adventure')) return '🗺️';
    if (lower.contains('moral')) return '💡';
    return '📚';
  }
}
