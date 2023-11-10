import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/repo_model.dart';
import '../../../widgets/empty_list_text.dart';
import '../../../widgets/repo_tile.dart';
import '../cubit/home_cubit.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is SearchHistoryLoaded && state.queries.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Center(
              child: EmptyListText(
                text: 'emptyHistory'.tr(),
                details: 'clickSearch'.tr(),
              ),
            ),
          );
        } else if (state is SearchHistoryLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.queries.length,
              itemBuilder: (BuildContext context, int index) {
                final searchItem = state.queries[index];

                return RepoTile(
                  repo: searchItem,
                  onTap: () => context.read<HomeCubit>().addSearchQuery(
                        RepoModel(
                            id: searchItem.id,
                            name: searchItem.name,
                            isFavorite: !searchItem.isFavorite),
                      ),
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
