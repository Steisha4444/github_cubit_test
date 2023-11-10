import 'package:hive/hive.dart';

import '../../presentation/models/repo_model.dart';

class HiveStorage {
  HiveStorage() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(
        RepoModelAdapter(),
      );
    }
  }
  static const _favoritesBoxName = 'favorites';
  static const String _historyBoxName = 'search_history';

  Future<void> addFavoriteRepo(RepoModel repo) async {
    final box = await Hive.openBox<RepoModel>(_favoritesBoxName);
    if (repo.id == null) {
      box.add(repo);
    } else {
      box.put(repo.id, repo);
    }
  }

  Future<List<RepoModel>> getFavoriteRepos() async {
    final box = await Hive.openBox<RepoModel>(_favoritesBoxName);
    return box.values.toList();
  }

  Future<void> deleteFavoriteRepo(RepoModel repo) async {
    final box = await Hive.openBox<RepoModel>(_favoritesBoxName);
    box.delete(repo.id);
  }

  Future<void> addSearchQuery(RepoModel repo) async {
    final box = await Hive.openBox<RepoModel>(_historyBoxName);
    final index =
        box.values.toList().indexWhere((element) => element.name == repo.name);
    bool sameRate = true;
    if (index != -1) {
      sameRate = box.values.toList()[index].isFavorite == repo.isFavorite;
    }
    if (index == -1 || !sameRate) {
      if (repo.id == null) {
        box.add(repo);
      } else {
        box.put(repo.id, repo);
      }
    }
  }

  Future<List<RepoModel>> getSearchHistory() async {
    final box = await Hive.openBox<RepoModel>(_historyBoxName);
    final repos = List<RepoModel>.empty(growable: true);
    for (var element in box.values) {
      repos.add(element.toModel());
    }

    return repos;
  }

  Future<void> deleteSearch(RepoModel repo) async {
    final box = await Hive.openBox<RepoModel>(_historyBoxName);
    box.delete(repo.id);
  }
}
