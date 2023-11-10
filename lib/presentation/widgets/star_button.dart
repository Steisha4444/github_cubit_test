import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_theme.dart';
import '../screens/favorites/favorites_screen.dart';

class StarButton extends StatelessWidget {
  const StarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavoriteReposScreen()),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          right: 16,
        ),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: AppTheme.colors.primaryAccentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          'assets/images/svgs/star.svg',
          height: 20,
          colorFilter: ColorFilter.mode(
              AppTheme.colors.primaryBackgroundColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
