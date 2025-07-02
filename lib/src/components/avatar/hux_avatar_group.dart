import 'package:flutter/material.dart';
import 'hux_avatar.dart';

/// HuxAvatarGroup displays multiple avatars in a row, typically used to show
/// groups of users, teams, or participants.
///
/// Supports both overlapping and spaced layouts with consistent sizing
/// and styling that follows the Hux design system.
///
/// Example:
/// ```dart
/// HuxAvatarGroup(
///   avatars: [
///     HuxAvatar(name: 'John Doe'),
///     HuxAvatar(name: 'Jane Smith'),
///     HuxAvatar(useGradient: true),
///   ],
///   size: HuxAvatarSize.medium,
///   overlap: true,
/// )
/// ```
class HuxAvatarGroup extends StatelessWidget {
  /// Creates a HuxAvatarGroup widget.
  const HuxAvatarGroup({
    super.key,
    required this.avatars,
    this.size = HuxAvatarSize.medium,
    this.overlap = true,
    this.maxVisible = 4,
    this.spacing = 8.0,
  });

  /// List of avatars to display
  final List<HuxAvatar> avatars;

  /// Size of all avatars in the group
  final HuxAvatarSize size;

  /// Whether avatars should overlap each other
  final bool overlap;

  /// Maximum number of avatars to show before showing a "+X" indicator
  final int maxVisible;

  /// Spacing between avatars when not overlapping
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final visibleAvatars = avatars.take(maxVisible).toList();
    final remainingCount = avatars.length > maxVisible ? avatars.length - maxVisible : 0;
    
    if (overlap) {
      return _buildOverlappingAvatars(context, visibleAvatars, remainingCount);
    } else {
      return _buildSpacedAvatars(context, visibleAvatars, remainingCount);
    }
  }

  Widget _buildOverlappingAvatars(BuildContext context, List<HuxAvatar> visibleAvatars, int remainingCount) {
    final avatarSize = _getAvatarSize();
    final overlapOffset = avatarSize * 0.7; // 30% overlap
    
    return SizedBox(
      width: (visibleAvatars.length - 1) * overlapOffset + avatarSize + (remainingCount > 0 ? overlapOffset : 0),
      height: avatarSize,
      child: Stack(
        children: [
          // Display visible avatars
          ...visibleAvatars.asMap().entries.map((entry) {
            final index = entry.key;
            final avatar = entry.value;
            
            return Positioned(
              left: index * overlapOffset,
              child: HuxAvatar(
                imageUrl: avatar.imageUrl,
                name: avatar.name,
                size: size,
                backgroundColor: avatar.backgroundColor,
                useGradient: avatar.useGradient,
                gradientVariant: avatar.gradientVariant,
              ),
            );
          }),
          
          // Show remaining count if any
          if (remainingCount > 0)
            Positioned(
              left: visibleAvatars.length * overlapOffset,
              child: _buildRemainingCountAvatar(context, remainingCount),
            ),
        ],
      ),
    );
  }

  Widget _buildSpacedAvatars(BuildContext context, List<HuxAvatar> visibleAvatars, int remainingCount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...visibleAvatars.asMap().entries.map((entry) {
          final index = entry.key;
          final avatar = entry.value;
          
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index > 0) SizedBox(width: spacing),
              HuxAvatar(
                imageUrl: avatar.imageUrl,
                name: avatar.name,
                size: size,
                backgroundColor: avatar.backgroundColor,
                useGradient: avatar.useGradient,
                gradientVariant: avatar.gradientVariant,
              ),
            ],
          );
        }),
        
        // Show remaining count if any
        if (remainingCount > 0) ...[
          SizedBox(width: spacing),
          _buildRemainingCountAvatar(context, remainingCount),
        ],
      ],
    );
  }

  Widget _buildRemainingCountAvatar(BuildContext context, int count) {
    return HuxAvatar(
      name: '+$count',
      size: size,
    );
  }

  double _getAvatarSize() {
    switch (size) {
      case HuxAvatarSize.small:
        return 32;
      case HuxAvatarSize.medium:
        return 40;
      case HuxAvatarSize.large:
        return 56;
      case HuxAvatarSize.extraLarge:
        return 80;
    }
  }
}