import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/repo_model.dart';
import '../../../../domain/github_usecase.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  final _usecase = GithubUsecase();

  Future<void> loadFavoriteRepos() async {
    emit(FavoriteReposLoading());
    await _updateFavoriteRepos();
  }

  Future<void> addFavoriteRepo(RepoModel repo) async {
    await _usecase.addFavoriteRepo(repo);
    await _updateFavoriteRepos();
  }

  Future<void> deleteFavoriteRepo(RepoModel repo) async {
    await _usecase.deleteFavoriteRepo(repo);
    await _updateFavoriteRepos();
  }

  Future<void> _updateFavoriteRepos() async {
    final queries = await _usecase.loadFavorites();
    emit(FavoriteReposLoaded(queries: queries));
  }
}
