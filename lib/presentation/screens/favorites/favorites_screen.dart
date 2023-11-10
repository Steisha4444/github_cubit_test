import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';
import '../../widgets/nav_back_button.dart';
import 'widgets/favorite_list.dart';

class FavoriteReposScreen extends StatelessWidget {
  const FavoriteReposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(58),
        child: AppBar(
          elevation: 0.4,
          leadingWidth: 60,
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 6, top: 6),
            child: NavBackButton(),
          ),
          title: Text(
            'favoriteRepos'.tr(),
            style: TextStyle(
              color: AppTheme.colors.primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: const FavoriteRepoList(),
    );
  }
}
