part of 'favorites_cubit.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoriteReposLoaded extends FavoritesState {
  final List<RepoModel> queries;

  FavoriteReposLoaded({required this.queries});
}

final class FavoriteReposLoading extends FavoritesState {}
