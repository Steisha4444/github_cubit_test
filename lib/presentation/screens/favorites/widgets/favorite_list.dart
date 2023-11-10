import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/repo_model.dart';
import '../../../widgets/empty_list_text.dart';
import '../../../widgets/repo_tile.dart';
import '../../home/cubit/home_cubit.dart';
import '../cubit/favorites_cubit.dart';

class FavoriteRepoList extends StatelessWidget {
  const FavoriteRepoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesCubit>().loadFavoriteRepos();
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoriteReposLoaded && state.queries.isEmpty) {
          return Center(
            child: EmptyListText(
              text: 'noFavorites'.tr(),
              details: 'clickStar'.tr(),
            ),
          );
        } else if (state is FavoriteReposLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ListView.builder(
              itemCount: state.queries.length,
              itemBuilder: (BuildContext context, int index) {
                final repo = state.queries[index];

                return RepoTile(
                  repo: repo,
                  onTap: () async {
                    await context
                        .read<FavoritesCubit>()
                        .deleteFavoriteRepo(repo)
                        .whenComplete(
                          () => context.read<HomeCubit>().updateRepos(
                                RepoModel(
                                  id: repo.id,
                                  name: repo.name,
                                  isFavorite: !repo.isFavorite,
                                ),
                              ),
                        );
                  },
                );
              },
            ),
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
