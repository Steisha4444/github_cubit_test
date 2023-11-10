import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/github_usecase.dart';
import '../../../models/repo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final usecase = GithubUsecase();
  ScrollController scrollController = ScrollController();

  HomeCubit() : super(HomeInitial());

  Future<void> loadSearchHistory() async {
    emit(SearchHistoryLoading());
    await _updateSearchList();
  }

  Future<void> addSearchQuery(RepoModel repo) async {
    await usecase.addSearchQuery(repo);
    await _updateSearchList();
  }

  Future<void> deleteQuery(RepoModel repo) async {
    await usecase.deleteQuery(repo);
    await _updateSearchList();
  }

  Future<void> search(RepoModel repo, [String query = '']) async {
    await addSearchQuery(repo);
    await getRepos(query);
  }

  Future<void> getRepos([String query = '']) async {
    emit(ReposLoading());
    final searchQuery = query;
    final repos = await usecase.getRepos(searchQuery, 1);
    emit(ReposLoaded(repos: repos));
  }

  void updateRepos(RepoModel repo) {
    if (state is ReposLoaded) {
      int index = state.repos!.indexWhere((element) => element.id == repo.id);
      if (index != -1) {
        state.repos?[index] = repo;
      }
    }
    emit(ReposLoaded(repos: state.repos ?? []));
  }

  Future<void> _updateSearchList() async {
    final queries = await usecase.loadSearchHistory();
    emit(SearchHistoryLoaded(queries: queries));
  }
}
