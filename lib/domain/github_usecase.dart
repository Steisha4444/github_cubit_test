import '../core/models/repo_model.dart';
import '../data/github_api.dart';
import '../data/storage/hive_storage.dart';

class GithubUsecase {
  final _db = HiveStorage();
  final _api = GitHubApi();

  Future<List<RepoModel>> loadSearchHistory() async =>
      await _db.getSearchHistory();

  Future<void> addSearchQuery(RepoModel repo) async =>
      await _db.addSearchQuery(repo);

  Future<void> deleteQuery(RepoModel repo) async =>
      await _db.deleteSearch(repo);

  List<RepoModel> _checkIfFavorite(
    List<RepoModel> repos,
    List<RepoModel> favorites,
  ) {
    final updated = repos.map((element) {
      final index = favorites.indexWhere((data) => element.id == data.id);
      if (index != -1) {
        element.isFavorite = true;
      }
      return element;
    }).toList();

    return updated;
  }

  Future<List<RepoModel>> getRepos(String query, int currentPage) async {
    final repos = List<RepoModel>.empty(growable: true);
    if (query.isNotEmpty) {
      final result = await _api.getRepos(query, currentPage);
      final favorites = await _db.getFavoriteRepos();

      repos.addAll(_checkIfFavorite(result, favorites));
    }

    return repos;
  }

  Future<List<RepoModel>> loadFavorites() async => await _db.getFavoriteRepos();

  Future<void> addFavoriteRepo(RepoModel repo) async =>
      await _db.addFavoriteRepo(repo);

  Future<void> deleteFavoriteRepo(RepoModel repo) async =>
      await _db.deleteFavoriteRepo(repo);
}
