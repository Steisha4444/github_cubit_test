part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  List<RepoModel>? get repos;
}

final class HomeInitial extends HomeState {
  @override
  final List<RepoModel>? repos = null;
}

final class ReposLoaded extends HomeState {
  @override
  final List<RepoModel> repos;

  ReposLoaded({required this.repos});
}

final class ReposLoading extends HomeState {
  @override
  final List<RepoModel>? repos = null;
}

final class SearchHistoryLoaded extends HomeState {
  final List<RepoModel> queries;
  @override
  final List<RepoModel>? repos = null;

  SearchHistoryLoaded({required this.queries});
}

final class SearchHistoryLoading extends HomeState {
  @override
  final List<RepoModel>? repos = null;
}
