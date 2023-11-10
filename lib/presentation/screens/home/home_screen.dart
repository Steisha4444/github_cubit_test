import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../core/app_theme.dart';
import '../../widgets/star_button.dart';
import 'cubit/home_cubit.dart';
import 'widgets/repo_list.dart';
import 'widgets/search_field.dart';
import 'widgets/search_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _getList(bool showSearchHistory) {
    if (showSearchHistory) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'searchHistory'.tr(),
              style: TextStyle(
                color: AppTheme.colors.primaryAccentColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SearchList()
        ],
      );
    }
    return RepoList();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    context.read<HomeCubit>().loadSearchHistory();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          elevation: 0.4,
          title: Text(
            'githubReposList'.tr(),
            style: TextStyle(
              color: AppTheme.colors.primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          actions: const [
            Center(
              child: StarButton(),
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              const SearchField(),
              Expanded(
                child: _getList(state is SearchHistoryLoading ||
                    state is SearchHistoryLoaded),
              ),
            ],
          );
        },
      ),
    );
  }
}
