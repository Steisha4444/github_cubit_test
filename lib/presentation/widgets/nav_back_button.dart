import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_theme.dart';

class NavBackButton extends StatelessWidget {
  const NavBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: AppTheme.colors.primaryAccentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          'assets/images/svgs/arrow_left.svg',
          height: 20,
        ),
      ),
    );
  }
}
