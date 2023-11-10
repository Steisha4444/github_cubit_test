import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/models/repo_model.dart';
import '../../../widgets/empty_list_text.dart';
import '../../../widgets/repo_tile.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../cubit/home_cubit.dart';

class RepoList extends StatelessWidget {
  RepoList({super.key});

  final text = Padding(
    padding: const EdgeInsets.only(
      left: 16,
    ),
    child: Text(
      'haveFound'.tr(),
      style: TextStyle(
        color: AppTheme.colors.primaryAccentColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is ReposLoaded && state.repos.isEmpty) {
          return Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: text),
              Padding(
                padding: const EdgeInsets.only(top: 184),
                child: Center(
                  child: EmptyListText(
                    text: 'nothingFound'.tr(),
                    details: 'checkSpelling'.tr(),
                  ),
                ),
              ),
            ],
          );
        } else if (state is ReposLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text,
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: state.repos.length,
                  controller: context.read<HomeCubit>().scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    final repo = state.repos[index];

                    return RepoTile(
                      repo: repo,
                      onTap: () async {
                        final updatedRepo = RepoModel(
                          id: repo.id,
                          name: repo.name,
                          isFavorite: !repo.isFavorite,
                        );
                        if (repo.isFavorite) {
                          await context
                              .read<FavoritesCubit>()
                              .deleteFavoriteRepo(repo)
                              .whenComplete(() => context
                                  .read<HomeCubit>()
                                  .updateRepos(updatedRepo));
                        } else {
                          await context
                              .read<FavoritesCubit>()
                              .addFavoriteRepo(updatedRepo)
                              .whenComplete(() => context
                                  .read<HomeCubit>()
                                  .updateRepos(updatedRepo));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Align(
            alignment: Alignment.topCenter,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
