import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_theme.dart';
import '../../core/models/repo_model.dart';

class RepoTile extends StatelessWidget {
  const RepoTile({
    super.key,
    required this.repo,
    required this.onTap,
  });
  final RepoModel repo;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 16, right: 28),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.colors.primaryLayerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: Text(
              repo.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: SvgPicture.asset(
              'assets/images/svgs/star.svg',
              height: 20,
              colorFilter: ColorFilter.mode(
                  repo.isFavorite
                      ? AppTheme.colors.primaryAccentColor
                      : AppTheme.colors.primaryPlaceHolderTextColor,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
